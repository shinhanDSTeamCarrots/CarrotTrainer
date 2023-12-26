$(function() {
	//입력
	$("#modalBody-insertBtn").click(function(e) {
		if(bodyChangeConfirm()) {
			$("#modalBody-weight").attr("action", "insertBodyChange");
			$("#modalBody-weight").submit();
		}
		else {
			e.preventDefault();
		}
	});
	//수정
	$("#modalBody-updateBtn").click(function(e) {
		if(bodyChangeConfirm()) {
			if(confirm("정말 수정하시겠습니까?")) {
				$("#modalBody-weight").attr("action", "updateBodyChange");
				$("#modalBody-weight").submit();
			}
		}
		else {
			e.preventDefault();
		}
	});
	//삭제
	$("#modalBody-deleteBtn").click(function(e) {
		if(bodyChangeConfirm()) {
			if(confirm("정말 삭제하시겠습니까?")) {
				$("#modalBody-weight").attr("action", "deleteBodyChange");
				$("#modalBody-weight").submit();
			}
		}
		else {
			e.preventDefault();
		}
	});
	// 숫자 이외의 문자를 제거하고 input에 설정
	handleInputChange("weight");
	handleInputChange("muscle_mass");
 	handleInputChange("fat_mass");
	
	// minus-button 클릭 이벤트
	$("#minus-button").on("click", function () {
	    var currentValue = parseInt($("#weight").val());
	
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue)) {
	        $("#weight").val(currentValue - 1);
	    }
	});
	
	// plus-button 클릭 이벤트
	$("#plus-button").on("click", function () {
	    var currentValue = parseInt($("#weight").val());
	
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue)) {
	        $("#weight").val(currentValue + 1);
	    }
	});
	
	//오늘의 상태 입력 확인
	function bodyChangeConfirm() {
		if ($("#body_change_weight").val() === "") {
			alert("체중을 입력하세요");
			$("#body_change_weight").focus();
			return false;
		}
		return true;
	}
	//숫자만 입력가능 함수
	function handleInputChange(inputId) {
	    $("#" + inputId).on("input", function () {
	        var inputValue = $(this).val();
	        $(this).val(inputValue.replace(/[^0-9]/g, ''));
	    });
	}
});
