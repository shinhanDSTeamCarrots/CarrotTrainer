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
	<script src="${pageContext.request.contextPath}/js/healthInfo/foodDiaryScript.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="foodDiary-title">
    			<p class="foodDiary-title-text">TODAY'S DIARY</p>
    			<button class="move" onclick="location.href='${pageContext.request.contextPath}/healthInfo/diary'">오늘의 다이어리</button>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/healthInfo/bodyReport'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<div class="foodDiary-content">
    			<div class="foodDiary-result">
    				<div class="foodDiary-food-result">
	    				<div class="foodDiary-food-result-image">
	    					<div class="foodDiary-food-result-carrot">
	    						<img id="carrotImage" src="${pageContext.request.contextPath}/img/carrotTrainer.png">
	    					</div>
	    				</div>
	    				<div class="foodDiary-food-result-detail">
	    					<div class="sql-total-kcal">
    							<c:if test="${empty foodDiary }">
    							<span id="sql-daily-kcal">0</span><span id="sql-target-kcal"> / ${bodyInfo.target_calorie } kcal</span>
    							</c:if>
			                	<c:if test="${!empty foodDiary }">
			                	<span id="sql-daily-kcal">${foodDiary.total_calorie }</span><span id="sql-target-kcal"> / ${bodyInfo.target_calorie } kcal</span>
			                	</c:if>
	    					</div>
	    					<div class="nutrient">
		    					<div class="nutrient-graph">
		    						<div class="carbs-graph">
			    						<div class="nutrient-graph-name">탄수화물</div>
			    						<div class="progress-bar" id="carbs-bar">
			    							<div class="progress"></div>
			    						</div>
			    						<div class="nutrient-graph-result">
			    							<c:if test="${empty foodDiary }"><div id="carbs">0</div> / ${bodyInfo.target_carbs }g</c:if>
						                	<c:if test="${!empty foodDiary }"><div id="carbs">${foodDiary.total_carbs }</div> / ${bodyInfo.target_carbs }g</c:if>
		    							</div>
		    						</div>
		    						<div class="protein-graph">
			    						<div class="nutrient-graph-name">단백질</div>
			    						<div class="progress-bar" id="protein-bar">
			    							<div class="progress"></div>
			    						</div>
			    						<div class="nutrient-graph-result">
			    							<c:if test="${empty foodDiary }"><div id="protein">0</div> / ${bodyInfo.target_protein }g</c:if>
						                	<c:if test="${!empty foodDiary }"><div id="protein">${foodDiary.total_protein }</div> / ${bodyInfo.target_protein }g</c:if>
		    							</div>
		    						</div>
		    						<div class="fat-graph">
			    						<div class="nutrient-graph-name">지방</div>
			    						<div class="progress-bar" id="fat-bar">
			    							<div class="progress"></div>
			    						</div>
			    						<div class="nutrient-graph-result">
			    							<c:if test="${empty foodDiary }"><div id="fat">0</div> / ${bodyInfo.target_fat }g</c:if>
						                	<c:if test="${!empty foodDiary }"><div id="fat">${foodDiary.total_fat }</div> / ${bodyInfo.target_fat }g</c:if>
		    							</div>
		    						</div>
		    						<div class="sugar-graph">
			    						<div class="nutrient-graph-name">당</div>
			    						<div class="progress-bar" id="sugar-bar">
			    							<div class="progress"></div>
			    						</div>
			    						<div class="nutrient-graph-result">
			    							<c:if test="${empty foodDiary }"><div id="sugar">0</div> / ${bodyInfo.target_sugar }g</c:if>
						                	<c:if test="${!empty foodDiary }"><div id="sugar">${foodDiary.total_sugar }</div> / ${bodyInfo.target_sugar }g</c:if>
		    							</div>
		    						</div>
	    						</div>
    						</div>
    					</div>
    				</div>
    				<div class="foodDiary-food-input">
    					<div class="foodDiary-food-inform" id="breakfast" onclick="location.href='${pageContext.request.contextPath}/healthInfo/food'">
    						<div class="nutrient-image"><p>+</p></div>
    						<div class="nutrient-time">아침</div>
    						<div class="kcal">
    							<span class="sql-diary-result">
    								<c:if test="${empty foodCal }">0</c:if>
									<c:if test="${!empty foodCal }">${foodCal.breakfast_calorie }</c:if>
    							</span> kcal
    						</div>
    					</div>
    					<div class="foodDiary-food-inform" id="lunch" onclick="location.href='${pageContext.request.contextPath}/healthInfo/food'">
    						<div class="nutrient-image"><p>+</p></div>
    						<div class="nutrient-time">점심</div>
    						<div class="kcal">
    						<input type="hidden" value="${foodCal.lunch_calorie }"/>
    							<span class="sql-diary-result">
    								<c:if test="${empty foodCal }">0</c:if>
									<c:if test="${!empty foodCal }">${foodCal.lunch_calorie }</c:if>
    							</span> kcal
    						</div>
    					</div>
    					<div class="foodDiary-food-inform" id="dinner" onclick="location.href='${pageContext.request.contextPath}/healthInfo/food'">
    						<div class="nutrient-image"><p>+</p></div>
    						<div class="nutrient-time">저녁</div>
    						<div class="kcal">
    							<span class="sql-diary-result">
    								<c:if test="${empty foodCal }">0</c:if>
									<c:if test="${!empty foodCal }">${foodCal.dinner_calorie }</c:if>
    							</span> kcal
    						</div>
    					</div>
    					<div class="foodDiary-food-inform" id="snack" onclick="location.href='${pageContext.request.contextPath}/food'">
    						<div class="nutrient-image"><p>+</p></div>
    						<div class="nutrient-time">간식</div>
    						<div class="kcal">
    							<span class="sql-diary-result">
    								<c:if test="${empty foodCal && empty foodDiary }">0</c:if>
									<c:if test="${!empty foodCal }">${foodCal.snack_calorie }</c:if>
    							</span> kcal
    						</div>
    					</div>
    				</div>
    			</div>
    		</div>
    		<div class="detail-division-line"></div>
    		<div class="foodDiary-comment">
    			<div class="foodDiary-comment-graph">
    			</div>
    			<div class="foodDiary-comment-text">
	    			<p>탄수화물 <span class="sql-diary-comment">50</span>g <span>초과했어요</span></p>
	    			<p>단백질 <span class="sql-diary-comment">10</span>g <span>더 먹어보세요</span></p>
	    			<p>지방 <span class="sql-diary-comment">10</span>g <span>더 먹어보세요</span></p>
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
