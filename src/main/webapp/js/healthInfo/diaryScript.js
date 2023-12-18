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

	//오늘의 상태 입력 확인
	function bodyChangeConfirm() {
		if ($("#body_change_weight").val() === "") {
			alert("체중을 입력하세요");
			$("#body_change_weight").focus();
			return false;
		}
		return true;
	}
});
