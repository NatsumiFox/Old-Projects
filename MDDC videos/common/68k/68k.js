window["68k"] = (element, lnum) => {
	let e = document.getElementById(element);
	e.innerHTML = _highlight(e.innerHTML, lnum);
}

// regex for various things
const rexLabel = new RegExp("^(\\s*\\.?\\@?[A-z0-9_]+:)", "i");
const rexLabel2 = new RegExp("^(\\.?\\@?[A-z0-9_]+:?)", "i");
const rexSpace = new RegExp("^(\\s+)", "i");
const rexListReg = new RegExp("^(d[0-7]|a[0-7]|sp)", "i");

// regex for argument types
const rexEAd8 = new RegExp("^(([^,]*)\\(((pc)()|(a[0-7]|sp)(|\\.w|\\.l)|(d[0-7])(|\\.w|\\.l)),(a[0-7]|d[0-7]|sp)(|\\.w|\\.l)\\))", "i");
const rexEAd16 = new RegExp("^(([^,]*)\\((pc|a[0-7]|sp)\\))", "i");
const rexAp = new RegExp("^\\((a[0-7]|sp)\\)(\\+?)", "i");
const rexAm = new RegExp("^\\-\\((a[0-7]|sp)\\)", "i");
const rexData = new RegExp("^#([^,]+)", "i");
const rexAddr = new RegExp("^(\\(?\\.?\\@?[^,\\.]+\\)?)(\\.(w|l))?", "i");
const rexReg = new RegExp("^(d[0-7]|a[0-7]|sp|usp|ssp|sr|ccr)", "i");
const rexList = new RegExp("^(((d|a)[0-8]\\/?\\-?)+)", "i");

// regex for instructions
const arrCC = (mdt, mdf) => "(" + mdt + "|" + mdf +"|eq|ne|pl|mi|cc|cs|vc|vs|lo|ls|hi|hs|lt|le|gt|ge)";
const arrIns = [
	"b(tst|clr|set|chg)", "(ls|as|ro|rox)(l|r)", "b" + arrCC("ra", "sr"), "s" + arrCC("t", "f"), "db" + arrCC("t", "f"), "move(|a|q|p|m)", "link", "unlk",
	"(add|sub)(|i|a|x|q)", "cmp(|i|a|m)", "neg(|x)", "(and|or|eor)(|i)", "dc", "dcb", "ds", "tst", "(mul|div)(u|s)", "chk", "ext", "trap", "trapv", "nop",
	"reset", "illegal", "stop", "rt(e|s|d|r)", "jmp", "jsr", "pea", "lea", "exg", "swap", "clr", "(a|s|n)bcd", "tas",
];
const rexIns = new RegExp("^(\\s*(" + arrIns.join("|") + ")(\\.[bwls])?)(?=(\\s+|$))", "i");
const rexUnkIns = new RegExp("^(\\s*[^\\s]*)(?=(\\s+|$))", "i");

// function to highlight 68k code
const _highlight = (text, lnum) => {
	let res = "", lx = 0;

	// loop for every line of the file
	for(let line of text.split("\n")){
		let out = "<p_line>";

		if(line.trim().length == 0)
			out += " ";

		else {
			// split comment off
			let cmt = line.indexOf(";");
			let comment = null;

			if (cmt >= 0) {
				comment = line.substring(cmt);
				line = line.substring(0, cmt);
			} 

			// check if this line contains a label
			let rx = line.match(rexLabel);

			if (!rx || !rx.length)
				rx = line.match(rexLabel2);

			if (rx && rx.length) {
				// does contain a label
				out += "<p_label>" + rx[1] + "</p_label>";
				line = line.substring(rx[1].length);
			}

			// check for instructions
			rx = line.match(rexIns);

			if (rx && rx.length) {
				// does contain an instruction
				out += "<p_ins>" + rx[1] + "</p_ins>";
				line = line.substring(rx[1].length);

			} else {
				// check for unknown instructions
				rx = line.match(rexUnkIns);

				if (rx && rx.length) {
					// does contain an instruction
					out += "<p_unk>" + rx[1] + "</p_unk>";
					line = line.substring(rx[1].length);
				}
			}

			if (line.trim().length > 0) {
				rx = line.match(rexSpace);

				if (rx && rx.length) {
					// does contain additional space
					out += rx[1];
					line = line.substring(rx[1].length);
				}

				// check for parameters
				while (line.trim().length > 0) {
					if(line.charAt(0) == ","){
						// separator
						out += ",";
						line = line.substring(1);
					}

					rx = line.match(rexEAd8);

					if (rx && rx.length) {
						// d8(pc|ax|dx,ax|dx)
						out += expression(rx[2]) + "(<p_reg>" + (rx[6] || rx[4]) + "</p_reg>" + (rx[7] ? "<p_ins>" + rx[7] + "</p_ins>" : "")
							+",<p_reg>" + rx[10] + "</p_reg>" + (rx[11] ? "<p_ins>" + rx[11] + "</p_ins>" : "") + ")";

						line = line.substring(rx[1].length);
						continue;			
					}

					rx = line.match(rexEAd16);

					if (rx && rx.length) {
						// d16(pc|ax)
						out += expression(rx[2]) + "(<p_reg>" + rx[3] + "</p_reg>)";

						line = line.substring(rx[1].length);
						continue;
					}

					rx = line.match(rexAp);

					if (rx && rx.length) {
						// (ax)+
						out += "(<p_reg>" + rx[2] + "</p_reg>)" + rx[3];

						line = line.substring(rx[1].length);
						continue;
					}

					rx = line.match(rexAm);

					if (rx && rx.length) {
						// -(ax)
						out += "-(<p_reg>" + rx[1] + "</p_reg>)";

						line = line.substring(rx[1].length);
						continue;
					}

					rx = line.match(rexData);

					if (rx && rx.length) {
						// #<data>
						out += "#" + expression(rx[1]);

						line = line.substring(rx[0].length);
						continue;
					}

					rx = line.match(rexList);

					if (rx && rx.length) {
						// movem register list
						line = line.substring(rx[1].length);
						let s = rx[1];
						rx = s.match(rexSpace);

						if (rx && rx.length) {
							// does contain additional space
							out += rx[1];
							s = s.substring(rx[1].length);
						}

						while (s.length > 0) {
							// check if a separator character
							if (s.charAt(0) == '-' || s.charAt(0) == '/') {
								out += "<p_math>" + s.charAt(0) + "</p_math>";
								s = s.substring(1);
							}

							rx = s.match(rexListReg);

							if (rx && rx.length) {
								// register
								out += "<p_reg>" + rx[1] + "</p_reg>";
								s = s.substring(rx[1].length);
								continue;
							}

							out += "<p_unk>" + s + "</p_unk>";
							break;
						}

						continue;
					}

					rx = line.match(rexReg);

					if (rx && rx.length) {
						// register
						out += "<p_reg>" + rx[1] + "</p_reg>";

						line = line.substring(rx[1].length);
						continue;
					}

					rx = line.match(rexAm);

					if (rx && rx.length) {
						// (ax)+
						out += "-(<p_reg>" + rx[2] + "</p_reg>)";

						line = line.substring(rx[1].length);
						continue;
					}

					rx = line.match(rexAddr);

					if (rx && rx.length) {
						// <addr>
						out += expression(rx[1]) + (rx[2] ? "<p_ins>" + rx[2] + "</p_ins>" : "");

						line = line.substring(rx[0].length);
						continue;
					}

					out += "<p_unk>" + line + "</p_unk>";
					line = "";
					break;
				}
			}

			// write comment
			if (comment != null)
				out += "<p_cmt>"+ line + comment +"</p_cmt>";
		}

		out += (lnum ? "<p_lnum>"+ lx++ +"</p_lnum>" : "") +"</p_line>";
		res += out;
		console.log("68k_highlight " + out);
	}

	return res;
}

// regex for various expression parts
const rexMath = new RegExp("^([\\+\\-\\*/%\\^\\|&<>=!~]+)", "i");
const rexStr = new RegExp("^((\"|')[^\"']*(\\\"|\\'))", "i");

const rexNum = [
	new RegExp("^(\\d+)", "i"), new RegExp("^((0x|\\$)[0-9A-F]+)", "i"), new RegExp("^(\\d+[0-9A-F]*h)", "i"),
	new RegExp("^([0-1]+b)", "i"), new RegExp("^((%|0b)[0-1]+)", "i"),
];

// function for highlighting an expression
const expression = (text) => {
	let out = "";
	let rx = text.match(rexSpace);

	if (rx && rx.length) {
		// does contain additional space
		out = rx[1];
		text = text.substring(rx[1].length);
	}

	let chars = "";

	// write chars helper
	let dochars = () => {
		if (chars.length > 0) {
			out += "<p_label>" + chars + "</p_label>";
			chars = "";
		}
	};

	// helper function
	let help = (rex, fun) => {
		let r = text.match(rex);

		if (r && r.length) {
			dochars();

			// process entry
			out += fun(r);
			text = text.substring(r[1].length);
			return true;
		}

		return false;
	};

	// helper function for numbers
	let num = (n) => {
		return help(rexNum[n], (r) => "<p_num>" + r[1] + "</p_num>");
	};

	// loop for all text entries
	while (text.length > 0) {
		if (help(rexMath, (r) => "<p_math>" + r[1] + "</p_math>")) continue;
		if (help(rexStr, (r) => "<p_str>" + r[1] + "</p_str>")) continue;
		if (num(0) || num(1) || num(2) || num(3) || num(4)) continue;

		chars += text.charAt(0);
		text = text.substring(1);
	}

	dochars();
	return out;
}

// function to highlight specific lines
window["68k_hi"] = (element, lines) => {
	let e = document.getElementById(element);

	for (let l of lines)
		e.children[l].classList.add("p_hilite");
}

// function to highlight specific lines
window["68k_lo"] = (element, lines) => {
	let e = document.getElementById(element);

	for (let l of lines)
		e.children[l].classList.remove("p_hilite");
}

// function to scroll to a specific line
window["68k_ln"] = (element, line) => {
	document.getElementById(element).scrollTop = line * 25;
}

// function to hide or show specific lines
window["68k_set"] = (element, state, lines) => {
	let e = document.getElementById(element);

	for (let l of lines)
		e.children[l].classList[state ? "remove" : "add"]("p_hidden");
}
