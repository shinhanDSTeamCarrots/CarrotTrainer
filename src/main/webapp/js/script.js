//헤더 메뉴바
$(function(){
    $('.depth1 > li').on('mouseover',function(){
        $(this).find('.depth2').stop().slideDown();
    }).on('mouseleave',function(){
        $(this).find('.depth2').stop().slideUp();
    });
});

//메뉴 클릭시 해당 영역으로 이동
$(function () {
	$('#scroll-event').click(function (){
    	$('html, body').animate({scrollTop: $(this.hash).offset().top}, 300);
    });
});