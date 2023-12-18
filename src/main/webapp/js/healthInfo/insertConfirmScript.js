//입력값 확인
$(function() {
	$("#modalBody-button").click(function(e) {
		if(bodyChangeConfirm()) {
			$("#modalBody-weight").submit();
		}
		else {
			e.preventDefault();
		}
	});

	//오늘의 상태 입력 확인
	function bodyChangeConfirm() {
		if ($("#body_change_weight").val() === "") {
			alert('체중을 입력하세요');
			$("#body_change_weight").focus();
			return false;
		}
		return true;
	}
});
