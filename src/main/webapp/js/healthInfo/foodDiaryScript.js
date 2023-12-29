$(function() {
	const carbsValue = $('#carbs').text();
	const proteinValue = $('#protein').text();
	const fatValue = $('#fat').text();
	const sugarValue = $('#sugar').text();
	
	animateProgressBar('#carbs-bar', carbsValue, 10);
	animateProgressBar('#protein-bar', proteinValue, 10);
	animateProgressBar('#fat-bar', fatValue, 10);
	animateProgressBar('#sugar-bar', sugarValue, 10);
	
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
