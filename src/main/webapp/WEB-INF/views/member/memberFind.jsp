<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
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
	function idCheck(){
		var id = document.getElementById("idSearch").value;
		var isValid = id=='';
		if(isValid){
			document.getElementById("error-id").style.display = "block";
		} else{
			document.getElementById("error-id").style.display = "none";
		}
	}
	
	function pwCheck(){
		var id = document.getElementById("pwSearch").value;
		var email = document.getElementById("email").value;
		var isValid = id=='' || email == '';
		if(isValid){
			document.getElementById("error-pw").style.display = "block";
		}
		else{
			document.getElementById("error-pw").style.display = "none";
		}
	}
</script>
<style>
.error-message{
	color: red;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="idSearch">
			<h2 class="title">아이디 찾기</h2>
			<h3 class="title">
				아래 칸에 회원님의 아이디를 입력해 주세요.<br>이메일로 회원님의 아이디를 전송해 드릴게요.
			</h3>
			<input type="text" id="idSearch" name="idSearch"> <input
				type="button" id="search" name="search" onClick="idCheck()" value="입력">
				<div id="error-id" class="error-message" style="display: none;">아이디를 입력해 주세요.</div>
		</div>
		<div class="pwSearch">
			<h2 class="title">비밀번호 찾기</h2>
			<h3 class="title">회원님의 이메일로 임시 비밀번호를 발송해 드릴게요.</h3>
			아이디<input type="text" id="pwSearch" name="pwSearch"> 
			이메일<input type="text" id="email" name="email"> <input type="button"
				id="search" name="search" onClick="pwCheck()" value="입력">
				<div id="error-pw" class="error-message" style="display: none;">아이디와 이메일을 모두 입력해 주세요.</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>