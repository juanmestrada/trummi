
const panels = document.querySelectorAll('.panel');

const panelOptions = {
	threshold: 0.25
}

const panelInView = new IntersectionObserver(function(entries, panelObserver) {
	entries.forEach(entry => {
		if(!entry.isIntersecting) {
			return
		} else {
			entry.target.classList.add('inView');
			panelObserver.unobserve(entry.target);
		}
	})
}, panelOptions);

panels.forEach(panel => {
	panelInView.observe(panel);
});