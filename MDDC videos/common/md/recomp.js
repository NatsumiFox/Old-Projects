const { exec } = require("child_process");
const fs = require('fs');

// FORMATS:
//  0 - uncompressed
//  1 - Enigma
//  2 - Nemesis
//  3 - Saxman
//  4 - Kosinski
//  5 - Kosinski Moduled

const formats = [
	"copy", "\"%dir%/recomp/enicmp.exe\" %ex%", "\"%dir%/recomp/nemcmp.exe\" %ex%", "\"%dir%/recomp/saxcmp.exe\" %ex%", 
	"\"%dir%/recomp/koscmp.exe\" %ex%", "\"%dir%/recomp/koscmp.exe\" -m %ex%"
];

module.exports = (directory) => {
	let dir = directory;

	// use another function to do this processing for us
	let _cmp = (fin, fout, fmt, fex) => {
		return new Promise((res, rej) => {
			// build execute string
			let exe = formats[fmt].replace("%dir%", dir).replace("%ex%", fex) +" \""+ fin.replace(/\//g, "\\") +"\" \""+ fout.replace(/\//g, "\\") + "\"";
			console.log(exe);

			// execute the command now
			exec(exe, (error, stdout, stderr) => {
				if (error) rej(error);
				else res(fout);
			});
		});
	};

	return {
		compress: (format, fin, fout) => {
			return _cmp(fin, fout, format, "");
		},
		uncompress: (format, fin, fout) => {
			return _cmp(fin, fout, format, " -x");
		},
		readunc: (format, fin) => {
			return new Promise((res, rej) => {
				// first, compress the file
				_cmp(fin, fin + ".unc", format, " -x").then((f) => {
					// read the file contents
					fs.readFile(f, (err, data) => {
						// file read check
						if(err) rej(err);
						else res(data);
							
						// delete file from fs
						fs.unlinkSync(f);
					});
				}).catch(rej);
			});
		},
	}
}