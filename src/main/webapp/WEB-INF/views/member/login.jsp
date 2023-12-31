<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>로그인</title>
<META name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
	function loginCheck() {
		if ($("#member_id").val() == '') {
			alert("아이디를 입력해 주세요.");
			$("#member_id").focus();
			return false;
		}
		if ($("#member_pw").val() == '') {
			alert("비밀번호를 입력해 주세요");
			$("#member_pw").focus();
			return false;
		}

		$("#board").submit();
	}
</script>
<style>
.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
	background-color: #fff;
	height: 900px;
	
}
.login-main {
    display: flex;
    flex-direction:column;
    justify-content: center;
    margin: 100px auto;
}
.login-main img {
	margin: 30px;
}
.login-card {	
    width: 100%;
    max-width: 500px; /* Increase the maximum width */
    padding: 40px; /* More padding for larger appearance */
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Enhance shadow for depth */
    border-radius: 15px; /* Larger border radius for softer corners */
    background: white;
    transition: transform 0.3s ease; /* Smooth transition for hover effect */
    margin: 0 auto;
}

h1 {
    text-align: center;
    color: #333;
    font-size: 2rem; /* Larger font size */
    margin-bottom: 30px; /* More space below heading */
}



.form-group {
    margin-bottom: 20px;
}

.input-row {
    display: flex; /* Align items in a row */
    justify-content: space-between; /* Space out label and input */
    align-items: center; /* Align items vertically */
    margin-bottom: 20px; /* Space between rows */
}

label {
    text-align: left; /* Align text to the left */
    margin-right: 10px;
    font-size: 14px;
    font-weight: bold;
}
.idpw {
	margin: 10px;
    text-align: center;
}
#member_id{
	margin-left: 7px;
}

input[type="text"],
input[type="password"] {
    padding: 15px; /* Larger padding for bigger input fields */
    border: 2px solid #ddd;
    border-radius: 5px;
    font-size: 1rem; /* Adjust font size as needed */
}


button {
    width: 100%;
    padding: 15px; /* Bigger button */
    font-size: 1.1rem; /* Larger font size */
    color: white;
    background-color: #f9b572;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s; /* Smooth transition for hover effect */
}


button:hover {
    background-color: #ffa954; /* Darken color on hover */
}

.login-card:hover {
    transform: translateY(-5px); /* Slight raise effect on hover */
}


</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="login-main">
				<img src="${pageContext.request.contextPath}/img/carrot_border.png">
				<div class="login-card">
			        <h1 class="ll">LOGIN</h1>
			        <form action="login" method="post" id="login-form">
				        <div class="idpw">
				            <div class="form-group">
				                <label class="name" for="member_id">ID</label>
				                <input class="userInput" type="text" name="member_id" id="member_id">
				            </div>
				            <div class="form-group">
				                <label class="name" for="member_pw">PW</label>
				                <input class="userInput" type="password" name="member_pw" id="member_pw">
				            </div>
				         </div>
			            <button type="submit" onclick="return loginCheck();">로그인</button>
			        </form>
	   			 </div>
	   			 <img src="${pageContext.request.contextPath}/img/carrot_border.png">
   			 </div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		
	</div>
</body>
</html>