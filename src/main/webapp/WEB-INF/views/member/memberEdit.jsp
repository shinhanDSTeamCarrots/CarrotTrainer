<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>개인정보 수정</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<h2 class = "title">개인정보 수정</h2>
    			<form name="frm" id="frm" action="regist.do" method="post">
    					<fieldset class = "memberInfo">
    						<ul>
    							<li>아이디</li>
    							<li>비밀번호<input type = "password" name = "pw" id ="pw" placeholder = "영문,숫자,특수문자 조합 8자 이상"></li>
    							<li>비밀번호 확인<input type = "password" name = "pwCheck" id ="pwCheck"></li>
    							<li>주소<input type = "text" name = "addr" id ="addr">
    									<input type = "text name ="addr2" id = "addr2">
    							</li>
    							<fieldset class = "bodyPartCheck">
    							<!-- 이미 체크해둔 부분 버튼 색깔 다르게 하는 방법 생각하기 -->
    								<input type = "checkbox" id = "eye" name = "eye" value ="눈">
    								<input type = "checkbox" id = "ear" name = "ear" value ="귀">
    								<input type = "checkbox" id = "breath" name = "breath" value ="기관지">
    								<input type = "checkbox" id = "liver" name = "liver" value ="간">
    								<input type = "checkbox" id = "stomach" name = "stomach" value ="위">
    								<input type = "checkbox" id = "intestines" name = "intestines" value ="장">   						
    							</fieldset>
    						</ul>
    					</fieldset>
    						<a href= "memberDel.jsp">회원 탈퇴하기</a>
    						<input type = "submit" id = "edit" class = "edit" value = "수정하기" onClick = ""> 
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>