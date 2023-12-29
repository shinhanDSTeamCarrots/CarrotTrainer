<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>리포트</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/bodyReportStyle.css" />
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/userInfoScript.jsp"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/bodyChangeChart.js"></script>
	<script type="text/javascript">
		const foodchange = JSON.parse('${foodGraphJson}');
		const healthchange = JSON.parse('${healthGraphJson}');
		const bodychange = JSON.parse('${bodyGraphJson}');
		console.log(foodchange);
		console.log(healthchange);
		console.log(bodychange);
		$(document).ready(function(){
			drawGraphs(foodchange, healthchange, bodychange);
		});
		
	
	</script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="bodyReport-title">
	    		<div class="bodyReport-title-content">
	    			<p class="bodyReport-title-text">REPORT</p>
	   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/diary'">오늘의 다이어리</button>
	    		</div>
	    		<div class="title-division-line"></div>
	    		<p class="bodyReport-text">안녕하세요, <span class="sql-text-name"></span>님!</p>
    		</div>
   			<div class="bodyReport-list" id="scroll-event">
   				<ul>
    				<li><a href="#bodyReport-bmi">나의 몸 변화</a></li>
	    			<li><a href="#bodyReport-food">나의 음식 기록</a></li>
	    			<li><a href="#bodyReport-exercise">나의 운동 기록</a></li>
   				</ul>
	   		</div>
   			<div class="bodyReport-content">
    			<div class="bodyReport-content-detail" id="bodyReport-bmi">
    				<p class="bodyReport-text">나의 몸 변화</p>
    				<canvas id="line-chart"></canvas>
    			</div>
    			<div class="bodyReport-content-detail" id="bodyReport-food">
    				<p class="bodyReport-text">나의 음식 기록</p>
    				<canvas id="foodBar-chart"></canvas>
    			</div>
    			<div class="bodyReport-content-detail" id="bodyReport-exercise">
    				<p class="bodyReport-text">나의 운동 기록</p>
    				<canvas id="exerciseDoughnut-chart"></canvas>
    			</div>
    		</div>
	    </div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
