$(function() {
	animateProgressBar('#carbs-bar', 70, 10);
	animateProgressBar('#protein-bar', 70, 10);
	animateProgressBar('#fat-bar', 70, 10);
	animateProgressBar('#sugar-bar', 70, 10);
	
	//상태바 애니메이션
	function animateProgressBar(barSelector, targetWidth, interval) {
		let currentWidth = 0;
	    const bar = $(barSelector);
	
	    const barAnimation = setInterval(() => {
	    	bar.find('.progress').width(currentWidth + '%');
	    	currentWidth++ >= targetWidth && clearInterval(barAnimation);
		}, interval);
	}
});
