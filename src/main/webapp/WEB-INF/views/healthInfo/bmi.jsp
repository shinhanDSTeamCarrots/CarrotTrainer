<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>다이어리</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/bmiStyle.css" />
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/bmiCalcScript.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/userInfoScript.jsp"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="bmi-title">
    			<p class="bmi-title-text">DIARY</p>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary'">오늘의 다이어리</button>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<p class="bmi-text">안녕하세요, <span class="sql-text-name"></span>님!</p>
    		<div class="bmi-content">
	    		<div class="bmi-data">
	    			<form class="bmi-input-data" method="post">
		    			<ul class="bmi-input-detail">
		    				<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title">나이:</li>
			    			<li><input class="bmi-input-text" type="text" name="age" id="age" value="${bodyInfo.age }"></li>
	   					</ul>
	   					<ul class="bmi-input-detail">
	   						<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title">신장:</li>
			    			<li><input class="bmi-input-text" type="text" name="height" id="height" value="${bodyInfo.height }">cm</li>
	   					</ul>
	   					<ul class="bmi-input-detail">
	   						<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title">체중:</li>
			    			<li><input class="bmi-input-text" type="text" name="weight" id="weight" value="${bodyInfo.weight }">kg</li>
	   					</ul>
	   					<ul class="bmi-input-detail">
	   						<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title">성별:</li>
			    			<li>
			    				<input type="radio" name="gender" id="male" value="1" ${bodyInfo.gender == 1 ? 'checked' : ''}>남
			    				<input type="radio" name="gender" id="female" value="2" ${bodyInfo.gender == 2 ? 'checked' : ''}>여
			    			</li>
	   					</ul>
	   					<ul class="bmi-input-detail">
	   						<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title">목표:</li>
			    			<li><input class="bmi-input-text" type="text" name="target_weight" id="target_weight" value="${bodyInfo.target_weight }">kg</li>
	   					</ul>
	   					<ul class="bmi-input-detail">
	   						<li class="bmi-input-essential">*</li>
		    				<li class="bmi-input-title" id="title-exercise_mass">운동량:</li>
			    			<li class="exercise_mass">
			    				<select name="exercise_mass" id="exercise_mass">
			    					<option value="" disabled selected>[필수] 평소 운동량을 선택해주세요</option>
			    					<option value="1" ${bodyInfo.exercise_mass == 1 ? 'selected' : ''}>저강도</option>
			    					<option value="2" ${bodyInfo.exercise_mass == 2 ? 'selected' : ''}>중강도</option>
			    					<option value="3" ${bodyInfo.exercise_mass == 3 ? 'selected' : ''}>고강도</option>
			    				</select>
			    			</li>
	   					</ul>
	   					<input type="hidden" name="body_info_no" id="body_info_no" value="${bodyInfo.body_info_no }">
		    			<input type="hidden" name="member_no" id="member_no" value="${bodyInfo.member_no }">
	   				</form>
	   				<div class="bmi-input-button">
	   					<button class="bmi-btn" id="bmi-calc">계산</button>
	   					<button class="bmi-btn" id="bmi-reset" type="reset">초기화</button>
	   				</div>
	   				<div class="bmi-info">
	   				</div>
	   			</div>
   				<div class="bmi-result">
   					<div class="detail-division-line"></div>
   					<div class="bmi-result-text">
   						<p><span class="sql-text-name" id="result-user-name"></span>님의 BMI는 <span class="sql-result-text" id="bmi"></span>이며 <span class="sql-result-text" id="bmiResult"></span>범위 입니다.</p>
   						<p>평균 체중은 <span class="sql-result-text" id="avgWeight"></span>kg이고 현재 체중과 목표 체중의 차이는 <span class="sql-result-text" id="difWeight"></span>kg로 <span class="sql-result-text" id="aimResult"></span>목적에 속합니다.</p>
   						<p><span class="sql-text-name" id="result-user-name"></span>님의 목적과 활동량을 고려한 하루 권장 칼로리 섭취량은 <span class="sql-result-text" id="target_calorie"></span>kcal 입니다. </p>
   					</div>
   					<div class="bmi-result-data">
   					</div>
   					<div class="bmi-result-graph">
   						<div class="bar-container">
   							<div class="bar-underWeight">저체중</div>
							<div class="bar-nomalWeight">정상</div>
							<div class="bar-overWeight">과체중</div>
						    <div class="bar-fatness">비만</div>
						</div>
   					</div>
   					<!-- bmi 수치 -->
   					<div class="bmi-fixed-data">
   						<div class="bmi-fixed-data-detail">
   							<div class="text-underWeight">bmi</div>
   							<div class="text-nomalWeight">18.50</div>
   							<div class="text-overWeight">23.00</div>
   							<div class="text-fatness">25.00</div>
   						</div>
   					</div>
   					<div>
						<c:if test="${!empty loginInfo && empty bodyInfo}">
							<button class="bmi-btn" id="bmi-insertBtn">입력하기</button>
						</c:if>
						<c:if test="${!empty loginInfo && !empty bodyInfo}">
							<button class="bmi-btn" id="bmi-updateBtn">수정하기</button>
						</c:if>
   					</div>
   				</div>
   			</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
