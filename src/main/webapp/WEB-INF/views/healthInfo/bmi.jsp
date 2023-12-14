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
    		<p class="bmi-text">안녕하세요, <span class="sql-text-name">당근</span>님!</p>
    		<div class="bmi-content">
	    		<div class="bmi-data">
	    			<form>
	    			<%--
	    			<form action="" method="post">
	    			--%>
		    			<div class="bmi-input-data">
			    			<ul>
			    				<li>나이:</li>
				    			<li><input type="text" name="age" id="age" value=""></li>
		   					</ul>
		   					<ul>
			    				<li>신장:</li>
				    			<li><input type="text" name="height" id="height" value="">cm</li>
		   					</ul>
		   					<ul>
			    				<li>체중:</li>
				    			<li><input type="text" name="weight" id="weight" value="">kg</li>
		   					</ul>
		   					<ul>
			    				<li>성별:</li>
				    			<li>
				    				<input type="radio" name="gender" id="male" value="1">남
				    				<input type="radio" name="gender" id="female" value="2">여
				    			</li>
		   					</ul>
		   					<ul>
			    				<li>목표:</li>
				    			<li><input type="text" name="target_weight" id="target_weight" value="">kg</li>
		   					</ul>
		   					<ul>
			    				<li>운동량:</li>
				    			<li>
				    				<select name="exercise_mass" id="exercise_mass">
				    					<option value="1">저강도</option>
				    					<option value="2">중강도</option>
				    					<option value="3">고강도</option>
				    				</select>
				    			</li>
		   					</ul>
		   				</div>
		   				<div class="bmi-input-button">
		   					<button class="bmi-btn" id="bmi-calc">계산하기</button>
		   					<%--
		   					onclick시 하단 내용 출력
			                --%>
		   					<button class="bmi-btn" type="reset">초기화</button>
		   				</div>
		   			</form>
	   				<div class="bmi-info">
	   				</div>
	   			</div>
   				<div class="bmi-result">
   					<div class="detail-division-line"></div>
   					<div class="bmi-result-text">
   						<p><span class="sql-result-text">당근</span>님의 BMI는 <span class="sql-result-text" id="bmi"></span>이며 <span class="sql-result-text" id="bmiResult"></span> 범위에 속합니다.</p>
   						<p>평균 체중은 <span class="sql-result-text" id="avgWeight"></span>kg이고 평균 체중과 목표 체중의 차이는 <span class="sql-result-text" id="difWeight"></span>kg입니다.</p>
   						<p><span class="sql-result-text">당근</span>님의 비만도와 활동량을 고려한 하루 권장 칼로리 섭취량은 <span class="sql-result-text" id="target_calorie"></span>kcal 입니다. </p>
   					</div>
   					<div class="bmi-result-graph">
   					</div>
   					<div>
   						<button class="bmi-btn" type="submit">등록하기</button>
   						<%--
   						로그인 되어있으면 등록, 안되어있으면 로그인이 필요합니다 alert
   						<c:if test="${ }">
		                </c:if>
		                --%>
   					</div>
   				</div>
   			</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
