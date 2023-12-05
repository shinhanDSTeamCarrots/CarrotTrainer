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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/bodyReportStyle.css" />
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="bodyReport-title">
    			<p class="bodyReport-title-text">REPORT</p>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary.do'">오늘의 다이어리</button>
    		</div>
    		<div class="title-division-line"></div>
    		<div class="bodyReport-text">안녕하세요, <span class="sql-text">당근</span>님!</div>
   			<div class="bodyReport-list" id="scroll-event">
   				<ul>
    				<li><a href="#bodyReport-bmi">나의 BMI 변화</a></li>
	    			<li><a href="#bodyReport-food">나의 음식 기록</a></li>
	    			<li><a href="#bodyReport-exercise">나의 운동 기록</a></li>
   				</ul>
   			</div>
   			<div class="bodyReport-content">
    			<div class="bodyReport-content-detail" id="bodyReport-bmi">
    				<a class="bodyReport-text">나의 BMI 변화</a>
    			</div>
    			<div class="bodyReport-content-detail" id="bodyReport-food">
    				<a class="bodyReport-text">나의 음식 기록</a>
    			</div>
    			<div class="bodyReport-content-detail" id="bodyReport-exercise">
    				<a class="bodyReport-text">나의 운동 기록</a>
    			</div>
    		</div>
	    </div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
