//모달 팝업
$(function() {
	//모달 열기
	$('#popupBtn').click(function(){
		$('#modalWrap').css('display', 'flex');
	});
	// 닫기 버튼을 클릭했을 때 모달 닫기
	$('#modalWrap').click(function(){
		$('#modalWrap').css('display', 'none');
	});
	// 팝업 외부를 클릭했을 때 모달 닫기
	$('#closeBtn').click(function(e){
		if (e.target === this) {
    		$(this).css('display', 'none');
    	}
	});
});