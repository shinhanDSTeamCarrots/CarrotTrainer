<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="foodDiary-title">
    			<p class="foodDiary-title-text">TODAY'S DIARY</p>
    			<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary'">오늘의 다이어리</button>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<div class="foodDiary-content">
    			<div class="foodDiary-result">
    				<div class="foodDiary-food-result">
	    				<div class="foodDiary-food-result-image">
	    					<div class="foodDiary-food-result-carrot">
	    					</div>
	    				</div>
	    				<div class="foodDiary-food-result-detail">
	    					<div class="kcal">0/1390kcal</div>
	    					<div class="nutrient">
		    					<div class="nutrient-graph">
		    						<div class="carbs-graph">
			    						<div>탄수화물</div>
			    						<div></div>
			    						<div>0 / 180g</div>
		    						</div>
		    						<div class="protein-graph">
			    						<div>단백질</div>
			    						<div></div>
			    						<div>0 / 100g</div>
		    						</div>
		    						<div class="fat-graph">
			    						<div>지방</div>
			    						<div></div>
			    						<div>0 / 30g</div>
		    						</div>
		    						<div class="sugar-graph">
			    						<div>당</div>
			    						<div></div>
			    						<div>0 / 50g</div>
		    						</div>
	    						</div>
    						</div>
    					</div>
    				</div>
    				<div class="foodDiary-food-input">
    					<div class="foodDiary-food-inform" id="breakfast">
    						<div class="nutrient-image"></div>
    						<div>아침</div>
    						<div>120 kcal</div>
    					</div>
    					<div class="foodDiary-food-inform" id="lunch">
    						<div class="nutrient-image"></div>
    						<div>점심</div>
    						<div>120 kcal</div>
    					</div>
    					<div class="foodDiary-food-inform" id="dinner">
    						<div class="nutrient-image"></div>
    						<div>저녁</div>
    						<div>120 kcal</div>
    					</div>
    					<div class="foodDiary-food-inform" id="snack">
    						<div class="nutrient-image"></div>
    						<div>간식</div>
    						<div>120 kcal</div>
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
	    			<p>탄수화물 50g 초과했어요</p>
	    			<p>단백질 10g 더 먹어보세요</p>
	    			<p>지방 10g 더 먹어보세요</p>
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
