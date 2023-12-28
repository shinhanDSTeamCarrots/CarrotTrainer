<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<META name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script src="js/script.js"></script>
<script>
	function memberDel() {
		if ($("#member_pw").val().trim() == ''
				|| $("#member_id").val().trim() == '') {
			alert("개인정보를 모두 입력해주세요.");
			return false;
		}
		$("#frm").submit();
	}
</script>
<style>
.wrap {
	margin: auto;
	text-align: center;
}

.container {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
}

h2, h3 {
	margin-top: 5px;
	margin-bottom: 5px;
}
</style>
</head>

<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">

			<h2 class="title">탈퇴하기</h2>
			<h3 class="title">아래 칸에 개인정보를 입력하시면 탈퇴됩니다.</h3>
			<br>
			<form name="frm" id="frm" action="memberDel" method="post">
				아이디<input type="text" name="member_id" id="member_id"> 비밀번호<input
					type="password" name="member_pw" id="member_pw">
					<br>
				<h3 class="title" style="color: red;">(주의) 탈퇴 시 회원님의 마일리지는 자동으로
					소멸되며, 이후 복구할 수 없습니다.</h3><br>
					
				<input type="submit" value="탈퇴하기" onClick="memberDel()">
			</form>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>