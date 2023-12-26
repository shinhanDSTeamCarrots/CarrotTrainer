//모달 팝업
$(function() {
	//모달 열기
	$('#popupBtn').click(function(){
		$('#modalWrap').css('display', 'flex');
	});
	// 닫기 버튼을 클릭했을 때 모달 닫기
	$('#closeBtn').click(function(){
		$('#modalWrap').css('display', 'none');
	});
	// 팝업 외부를 클릭했을 때 모달 닫기
	$('#modalWrap').click(function(e){
		if (e.target === this) {
    		$(this).css('display', 'none');
    	}
	});
	
	// minus-button 클릭 이벤트
	$("#minus-button").on("click", function () {
	    let currentValue = parseInt($("#weight").val());
	    
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
	        let newWeightValue = currentValue - 10;

	        $("#weight").val(newWeightValue);        
	    }
	});
	// plus-button 클릭 이벤트
	$("#plus-button").on("click", function () {
	    let currentValue = parseInt($("#weight").val());
	    
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
	        let newWeightValue = currentValue + 10;
	
	        $("#weight").val(newWeightValue);
	    }
	});
});
