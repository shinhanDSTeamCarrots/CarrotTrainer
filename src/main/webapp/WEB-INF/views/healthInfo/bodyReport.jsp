<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>리포트</title>
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
    		<div class=bodyReport-title">
    			<p class="healthInfo-title-text">EXERCISE</p>
   				<button class="select" type="submit" onclick="">선택</button>
    		</div>
    		<div class="title-division-line"></div>
    		<div class="bodyReport-text">안녕하세요, 당근님!</div>
    		<div class="bodyReport-content">
    			<div class="bodyReport-list">
    			</div>
    			<div id="bodyReport-bmi">
    			</div>
    			<div id="bodyReport-food">
    			</div>
    			<div id="bodyReport-exercise">
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
