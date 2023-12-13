<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>오늘의 음식</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/foodDiaryStyle.css" />
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="foodDiary-title">
    			<p class="foodDiary-title-text">TODAY'S DIARY</p>
    			<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary.do'">오늘의 다이어리</button>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport.do'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<div class="foodDiary-content">
    			<div class="foodDiary-result">
    				<div class="foodDiary-food-result">
	    				<div class="foodDiary-food-result-image">
	    				</div>
	    				<div class="foodDiary-food-result-detail">
	    					<div class="kcal"></div>
	    					<div class="nutrient">
    						</div>
    					</div>
    				</div>
    				<div class="foodDiary-food-input">
    					<div class="foodDiary-food-inform" id="breakfast">
    					</div>
    					<div class="foodDiary-food-inform" id="lunch">
    					</div>
    					<div class="foodDiary-food-inform" id="dinner">
    					</div>
    					<div class="foodDiary-food-inform" id="snack">
    					</div>
    				</div>
    			</div>
    			<div class="foodDiary-calendar">
    			</div>
    		</div>
    		<div class="detail-division-line"></div>
    		<div class="foodDiary-comment">
    			<div class="foodDiary-comment-graph">
    			</div>
    			<div class="foodDiary-comment-text">
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
