<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>일일 권장량 계산</title>
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
    		<div class="diary-title">
    			<p class="diary-title-text">TODAY'S DIARY</p>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport.do'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<p class="diary-text">안녕하세요, <span class="sql-text-name">당근</span>님!</p>
    		<div class="diary-content">
    			<div class="diary-result">
    				<div class="diary-calendar">
    				</div>
    				<div class="diary-result-text">
    				</div>
    			</div>
    			<div class="diary-comment">
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
