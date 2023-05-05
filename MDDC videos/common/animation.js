// this will help the test variable to be defined first
const _run = (x) => {
	if (window["#test"] === undefined)
		setTimeout(_run, 1);

	if (window["#test"]) {
		// pseudo-function for testing
		window["#anim"] = (func) => {
			console.log("#anim trigger");
			func();
		}

	} else {
		// function to wait for animation trigger
		window["#anim"] = (func) => {
			let fn = (e) => {
				// check for spacebar
				if (e.keyCode == 32) {
					document.body.removeEventListener("keypress", fn);
					console.log("#anim trigger");
					func();
				}

				e.preventDefault();
			};

			document.body.addEventListener("keypress", fn, false);
		}
	}
}; _run();

// function to quickly append css
window.audio = (file, volume) => {
	let s = new Audio(file);
	s.volume = volume;
	s.play();
	return s;
};

// function to quickly append css
window.css = (code) => {
	let s = document.createElement("style");
	s.type = "text/css";
	s.innerText = code;
	document.head.appendChild(s);
	return s;
};

// function to process animation scripts
window.script = (delta, array) => {
	let frames = 0;

	let _run = () => {
		++frames;
		array[0].delay -= delta[0];

		if(array[0].delay <= 0){
			// if timer has ended, remove the first item from the array
			let data = array.shift();
			console.log("script", data);

			if (data.class) {
				data.class.forEach((c) => {
					// get element from document
					let e = document.getElementById(c.id);
					if (!e) throw "Element '" + c.id + "' not found!";

					if (c.eq) {
						// set element classes
						e.className = c.eq;
					}
				});
			}

			// run code if requested
			if (data.code) data.code();
		}

		// run animation again
		if(array.length > 0)
			requestAnimationFrame(_run);
		else console.log("script", frames);
	}

	// start animation
	requestAnimationFrame(_run);
};

// function to test background dragging
window.dragbg = (element, w, h) => {
	var _style = css();
	var x = 0, y = 0, scale = 1;
	var em = document.getElementById(element);
	var mx, my;

	// refresh stats
	var refresh = () => {
		let c = (a) => {
			return "calc("+ Math.round(a / scale) +"px * "+ scale +")";
		}

		_style.innerText = "#"+ element +"{background-position:"+ c(-x) +" "+ c(-y) +";background-size:"+ c(w * scale) +" "+ c(h * scale) +"}*{pointer-events:none;}";
	};

	// define functions
	var start = (e) => {
		e.preventDefault();
		mx = e.clientX;
		my = e.clientY;
		em.onmouseup = end;
		em.onmousemove = move;
		em.onwheel = zoom;
	};

	var move = (e) => {
		e.preventDefault();
		x += mx - e.clientX;
		y += my - e.clientY;
		mx = e.clientX;
		my = e.clientY;
		refresh();
	};

	var end = (e) => {
		e.preventDefault();
		em.onmouseup = null;
		em.onmousemove = null;
		em.onwheel = null;
		refresh();
	};

	var zoom = (e) => {
		e.preventDefault();
		scale += e.deltaY * -0.00025;
		scale = Math.min(Math.max(.5, scale), 8);
		scale = Math.round(scale * 1000) / 1000;
		refresh();
	};

	refresh();
    em.onmousedown = start;
};