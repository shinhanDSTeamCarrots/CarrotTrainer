//모달 팝업
$(function() {
	$('#popupBtn').click(function(){
		$('#modalWrap').css('display', 'flex');
	});
});
// 닫기 버튼을 클릭했을 때 모달이 사라짐
$(function() {
	$('#modalWrap').click(function(){
		$('#modalWrap').css('display', 'none');
	});
});
// 팝업 외부를 클릭했을 때 모달이 사라짐
$(function() {
	$('#closeBtn').click(function(e){
		if (e.target === this) {
    		$(this).css('display', 'none');
    	}
	});
});