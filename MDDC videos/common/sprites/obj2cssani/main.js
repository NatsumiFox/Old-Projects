const Parser = require("../../md/parsemaps.js");
const Compress = require("../../md/recomp.js")("../../md/");
global.ParseNum = require("../../md/parsenumber.js");
global.NumToBytes = require("../../md/numtobytes.js");
const { fromMD } = require("../../md/paletteconvert.js");
const fs = require("fs");
const Jimp = require("jimp");

// read config file
fs.readFile("config.json", async(err, data) => {
	// check for errors
	if(err) console.log(err);
	else {
		try {
			let config = JSON.parse(data);

			for (let x of ["pal", "map", "dplc"]) {
				// load this part of the file
				console.log("load file " + x);
				config[x].file = await _load(config[x]);
			}

			// load all art files
			for (let x of config.art) {
				// load this part of the file
				console.log("load file art");
				x.file = await _load(x);
			}

			// convert palette to RGB
			config.pal = fromMD(config.pal.file, 0);

			// convert the frames
			let frames = await _convertFrames(config);

			// convert animations
			_convertAnim(frames.length, config);

			new Jimp(config.size * frames.length, config.size, 0x0, function (er, img) {
				if(er) throw er;

				// write all frames to image
				for (let f = 0;f < frames.length;f ++) {
					for (let y = 0, i = 0; y < config.size;y ++){
						for (let x = 0; x < config.size; x++, i++) {
							// write pixel by pixel
							img.setPixelColor(frames[f][i], (f * config.size) + x, y);
						}
					}
				}

				// write image
				img.write("data.png");
			});

		} catch(ex){
			// if we got an error
			console.log(ex);
		}
	}
});

// load file data
const _load = (obj) => {
	return new Promise((res, rej) => {
		if (obj.compress < 0) {
			// ASM
			Parser.parseFile(obj.compress, obj.file).then((data) => {
				try {
					res(data.slice(obj.offset || 0))

				} catch (ex) {
					rej(ex);
				}
			}).catch(rej);

		} else {
			// BINARY
			Compress.readunc(obj.compress, obj.file).then((file) => {
				try {
					res([...file.slice(obj.offset || 0)]);

				} catch(ex){
					rej(ex);
				}
			}).catch(rej);
		}
	});
};

// convert frames to pixel arrays
const _convertFrames = (config) => {
	return new Promise((res, rej) => {
		let ret = [];
		let mapaddr = 0xFFFFFFFF, dplcaddr = 0xFFFFFFFF;

		// run for every frame
		while(true) {
			let tiles = [];

			if (ret.length * 2 >= dplcaddr || ret.length * 2 >= mapaddr)
				break;

			// find appropriate art file
			let art = null;

			for (let a of config.art)
				if(ret.length >= a.start)
					art = a.file;

			// check if we found an art file
			if (art == null)
				return rej({ error: "No valid art file for frame!", data: ret.length });

			// load dplc data
			let addr = (config.dplc.file[ret.length * 2] << 8) | (config.dplc.file[ret.length * 2 + 1]);
			if (dplcaddr > addr) dplcaddr = addr;

			for (let dd of _convertDPLC(config.format, config.dplc.file, addr)) {
				// push all tiles individually to the array
				for (let x = 0; x < dd.length * 32;x += 32){
					if (dd.tile + x + 32 > art.length)
						return rej({ error: "Invalid tile requested by DPLC", data: dd, tile: (x + dd.tile) / 32 });

					tiles.push(art.slice(dd.tile + x, dd.tile + x + 32));
				}
			}

			// load maps data
			addr = (config.map.file[ret.length * 2] << 8) | (config.map.file[ret.length * 2 + 1]);
			if (mapaddr > addr) mapaddr = addr;

			// create pixel array
			let px = [];
			for (let i = 0; i < config.size * config.size;i ++)
				px[i] = 0;

			// create pixel data
			for (let dd of _convertMaps(config.format, config.map.file, addr)) {
				let tla = dd.tile & 0x7FF;
				let line = dd.tile & (0x6000 >> 9) * 32;
				let flipx = !!(dd.tile & 0x0800);
				let flipy = !!(dd.tile & 0x1000);

				// loop for every tile in this sprite
				for(let x = 0;x <= (dd.size & 0xC);x += 4){
					for (let y = 0; y <= (dd.size & 0x3); y++) {

						// calculate tile index
						let tt = tla + (flipy ? (dd.size & 0x3) - y : y) + ((flipx ? ((dd.size & 0xC) - x) / 4 : x / 4) * ((dd.size & 0x3) + 1));

						if (tt >= tiles.length)
							return rej({ error: "Invalid tile requested by mappings", data: tla });

						// draw the tile inside of the sprite
						for (let yy = 0; yy < 8; yy++) {
							let yyy = yy + (y * 8) + dd.y + ((config.size / 2) | 0);

							if (yyy >= 0 && yyy < config.size)
								for (let xx = 0; xx < 8; xx++) {

									// check whether to draw pixel
									let xxx = xx + x + x + dd.x + ((config.size / 2) | 0);

									if (xxx >= 0 && xxx < config.size) {
										let _x = flipx ? 7 - xx : xx;
										let _y = flipy ? 7 - yy : yy;
										let _c = (tiles[tt][(_y * 4) + ((_x / 2) | 0)] >> ((_x & 1) ? 0 : 4)) & 0xF;

										// check if the new color is transparent and write if not
										if(_c) px[(yyy * config.size) + xxx] = config.pal[_c];
									}
								}
						}
					}
				}
			}

			// write the data into list
			ret.push(px);
		}

		res(ret);
		console.log("convert frames");
	});
};

// function to convert DPLC data into appropriate format
const _convertDPLC = (format, data, addr) => {
	let out = [];
	let entries = 0;

	// convert num of entries
	switch(format) {
		case 1: // byte
			entries = data[addr++];
			break;

		default: // word
			entries = (data[addr++] << 8) | data[addr++];
			break;
	}

	// loop for every entry
	for(;entries > 0;--entries) {
		switch (format) {
			case 1: // Sonic 1
			case 4: // Sonic 3K Player
				let d = (data[addr++] << 8) | data[addr++];
				out.push({ full: d, length: ((d & 0xF000) >> 12) + 1, tile: (d & 0xFFF) * 32 });
				break;
		}
	}

	return out;
};

// function to convert map data into appropriate format
const _convertMaps = (format, data, addr) => {
	let out = [];
	let entries = 0;

	// convert num of entries
	switch (format) {
		case 1: // byte
			entries = data[addr++];
			break;

		default: // word
			entries = (data[addr++] << 8) | data[addr++];
			break;
	}

	// loop for every entry
	for (; entries > 0; --entries) {
		switch (format) {
			case 1: // Sonic 1
				out.push({ y: _sex(data[addr++]), size: data[addr++], tile: (data[addr++] << 8) | data[addr++], x: _sex(data[addr++]) });
				break;

			case 3:case 4: // Sonic 3K
				out.push({ y: _sex(data[addr++]), size: data[addr++], tile: (data[addr++] << 8) | data[addr++], x: _sign((data[addr++] << 8) | data[addr++]) });
				break;
		}
	}

	return out;
};

// sign extend from byte to word
const _sex = (data) => data >= 0x80 ? -(0x100 - data) : data;

// change unsigned word to signed word
const _sign = (data) => data >= 0x8000 ? -(0x10000 - data) : data;

// function to output the CSS data for this project
const _convertAnim = (frames, config) => {
	return new Promise((res, rej) => {
		try {
			let css = "." + config.class + "{width:" + config.size + "px;height:" + config.size + "px;margin-left:" + (-config.size / 2) + "px;margin-top:" + (-config.size / 2) +"px;image-rendering:pixelated;background-image:url(data.png);background-repeat:no-repeat;background-position:center;}\n";
			css += "." + config.class + ".xflip{transform:rotateY(180deg);}";
			css += "." + config.class + ".yflip{transform:rotateX(180deg);}\n";

			// loop for every animation
			for (let a in config.ani) {
				css += "@keyframes a" + config.class +"_" + a + "{\n";

				let f = null;
				let last = config.ani[a][1], lp = 0, part = 0, mul = 100 / (config.ani[a].length - 1);

				// next part of the animation
				let proc = (lx) => {
					css += (Math.round(lp*1000)/1000) + "%";

					// check if this is a range
					if(lx) css += ",100%";
					else if (lp !== (part - mul)) css += "," + (Math.round((part - mul)*1000)/1000) + "%";

					// write BG position
					css += "{background-position-x:-" + (last * config.size) + "px;}\n";
				};

				// the amount of frames for each animation frame to play
				let time = null;

				for (f of config.ani[a]) {
					// check if this is the animation timer
					if(time === null) {
						time = f + 1;
						continue;
					}

					// check if frame has changed
					if (f != last) {
						proc(false);

						// create a new thing
						last = f;
						lp = part;
					}

					part += mul;
				}

				// do final part
				proc(true);
				css += "}\n." + config.class + ".ani_" + a + "{animation-name:a" + config.class + "_" + a + ";animation-duration:" + Math.round((1000 / 60) * time * (config.ani[a].length - 1)) +"ms;animation-timing-function:steps(1);animation-iteration-count:infinite;}\n";
			}

			// write data file
			fs.writeFile("data.css", css, (err) => {
				if (err) return rej(err);
				res("data.css");
			});
		} catch(ex) {
			rej(ex);
		}
	});
};