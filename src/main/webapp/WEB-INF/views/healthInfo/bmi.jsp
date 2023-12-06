<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="bmi-title">
    			<p class="bmi-title-text">DIARY</p>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary.do'">오늘의 다이어리</button>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport.do'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<p class="bmi-text">안녕하세요, <span class="sql-text-name">당근</span>님!</p>
    		<div class="bmi-content">
	    		<div class="bmi-data">
	    			<div class="bmi-input-data">
		    			<ul>
		    				<li>나이:</li>
			    			<li><input></li>
	   					</ul>
	   					<ul>
		    				<li>신장:</li>
			    			<li><input></li>
	   					</ul>
	   					<ul>
		    				<li>체중:</li>
			    			<li><input></li>
	   					</ul>
	   					<ul>
		    				<li>성별:</li>
			    			<li><input></li>
	   					</ul>
	   					<ul>
		    				<li>목표:</li>
			    			<li></li>
	   					</ul>
	   					<ul>
		    				<li>운동량:</li>
			    			<li></li>
	   					</ul>
	   				</div>
	   				<div class="bmi-input-button">
	   					<button class="bmi-btn" type="submit" onclick="">계산하기</button>
	   					<%-- 로그인 했을 때, type submit 아닐때는 기능 없
		                <c:if test="${ }">
		                </c:if>
		                --%>
	   					<button class="bmi-btn" type="" onclick="">초기화</button>
	   				</div>
	   				<div class="bmi-info">
	   				</div>
	   			</div>
   				<div class="bmi-result">
   					<div class="detail-division-line"></div>
   					<div class="bmi-result-text">
   						<p><span class="sql-result-text">당근</span>님의 BMI는 <span class="sql-result-text">21.50</span>이며 <span class="sql-result-text">정상 범위</span>에 속합니다.</p>
   						<p><span class="sql-result-text">당근</span>님의 비만도와 활동량을 고려한 하루 권장 칼로리 섭취량은 <span class="sql-result-text">1553</span>kcal 입니다. </p>
   					</div>
   					<div class="bmi-result-graph">
   					</div>
   				</div>
   			</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
