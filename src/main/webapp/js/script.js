$(function(){
    $('.depth1 > li').on('mouseover',function(){
        $(this).find('.depth2').stop().slideDown();
    }).on('mouseleave',function(){
        $(this).find('.depth2').stop().slideUp();
    });
});