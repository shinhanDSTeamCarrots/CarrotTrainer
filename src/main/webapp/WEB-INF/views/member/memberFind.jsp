<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
</head>
<body>
	<fieldset class = "idSearch">
		<h2 class = "title">아이디 찾기</h2>
		<h3 class = "title">아래 칸에 회원님의 아이디를 입력해 주세요.<br>이메일로 회원님의 아이디를 전송해 드릴게요.</h3>
		<input type = "text" id = "idSearch" name = "idSearch">
		<input type = "button" id="search" name = "search" onClick = "" value = "입력">
	</fieldset>
	<fieldset class = "pwSearch">
		<h2 class = "title">비밀번호 찾기</h2>
		<h3 class = "title">회원님의 이메일로 임시 비밀번호를 발송해 드릴게요.</h3>
		아이디<input type = "text" id = "idSearch2" name = "idSearch2">
		이메일<input type = "text" id = "email" name = "email">
		<input type = "button" id = "search" name = "search" onClick ="" value = "입력">
	</fieldset>
</body>
</html>