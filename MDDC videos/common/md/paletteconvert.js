const palette = [
	[  0,   0,  52,  52,  87,  87, 116, 116, 144, 144, 172, 172, 206, 206, 255, 255],
	[  0,   0,  29,  29,  52,  52,  70,  70,  87,  87, 101, 101, 116, 116, 130, 130],
	[130, 130, 144, 144, 158, 158, 172, 172, 187, 187, 206, 206, 228, 228, 255, 255],
];

module.exports = {
	fromMD: (data, mode) => {
		let out = new Uint32Array(data.length / 2);

		for(let x = 0;x < data.length;x += 2){
			// process this entry
			let v = (x & 0x1F) == 0 ? 0 : 0xFF;
			v += (palette[mode][data[x + 1] & 0xF] << 24);
			v += (palette[mode][data[x + 1] >> 4] << 16);
			v += (palette[mode][data[x] & 0xF] << 8);
			out[x / 2] = v;
		}

		return out;
	},
	toMD: (data, mode) => {

	}
};