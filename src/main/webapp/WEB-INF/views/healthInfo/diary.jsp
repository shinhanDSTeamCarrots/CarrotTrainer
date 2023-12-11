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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/diaryStyle.css" />
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
	    				<div class="diary-result-main">
	    					<div class="diary-result-main-text">
		    					<p>총 섭취량 <span class="sql-diary-result-main">1100</span>kcal</p>
		    					<p>총 활동량 <span class="sql-diary-result-main">50</span>kcal</p>
	    					</div>
	    					<div class="detail-division-line"></div>
	    					<div id="diary-result-main-sub">
		    					<p>남은 섭취량 <span class="sql-diary-result">200</span>kcal</p>
		    					<p>오늘의 상태는? <span class="sql-diary-result">8</span>kg</p>
	    					</div>
	    				</div>
	    				<div class="diary-contact-text">
	    					<a href="${pageContext.request.contextPath}/foodDiary.do">오늘의 음식 기록하기 ></a>
	    					<a href="${pageContext.request.contextPath}/exercise.do">오늘의 운동 기록하기 ></a>
	    					<a class="modal-popup" id="today-popup">오늘의 상태 기록하기 ></a>
    					</div>
    				</div>
    			</div>
    			<div class="diary-comment">
    				<p id="diary-comment-title"><span class="sql-diary-comment">당근</span>님의 <span class="sql-diary-comment">11월 20일</span>부터 <span class="sql-diary-comment">11월 26일</span>까지의 기록이에요</p>
    				<div class="diary-comment-detail" id="body">
    					<p>총 <span class="sql-diary-detail">0.5</span>kg 몸의 변화가 생겼어요!</p>
    					<p>목표 몸무게 달성까지 앞으로 잘 부탁드려요~</p>
    				</div>
    				<div class="diary-comment-detail" id="food">
    					<p>주로 <span class="sql-diary-detail">저녁</span>을 든든하게 먹었네요ㅎㅎ</p>
    					<p>내일부터는 <span class="sql-diary-detail">아침</span>을 든든하게 먹는 건 어떨까요~?</p>
    				</div>
    				<div class="diary-comment-detail" id="exercise">
    					<p>총 <span class="sql-diary-detail">3</span>회 운동을 진행했고 <span class="sql-diary-detail">요가</span>를 가장 즐겨했어요</p>
    					<p>꾸준한 운동은 몸 건강에 좋아요</p>
    				</div>
    			</div>
    		</div>
    		<!-- 모달 팝업 -->
    		<div id="modalWrap">
    			<div id="modalContent">
    			  	<div id="modalBody">
    			  		<!-- 닫기 버튼 -->
    			  		<span id="closeBtn">&times;</span>
    			  		<!-- 팝업 내용 -->
    			  		<div id="modalBody-main">
    			  			<div id="modalBody-title">
    			  				<div id="modalBody-title-text">오늘의 상태</div>
    			  				<div class="title-division-line"></div>
    			  			</div>
    			  			<div id="modalBody-main">
    			  				<div id="modalBody-weight">
	    			  				<div id="">
	    			  					<div class="modalBody-main-text">체중(kg)</div>
		    			  				<div id="minus-button">-</div>
		    			  				<input id="">
		    			  				<div id="plus-button">+</div>
		    			  			</div>
	    			  				<div class="list-division-line"></div>
    			  				</div>
    			  				<div id="modalBody-result">
	    			  				<div id="">
	    			  					<div class="modalBody-main-text">골격근량(kg)</div>
		    			  				<input id="">
		    			  			</div>
		    			  			<div id="">
	    			  					<div class="modalBody-main-text">체지방량(%)</div>
		    			  				<input id="">
		    			  			</div>
    			  				</div>
    			  			</div>
    			  			<div id="modalBody-button">
    			  				<button>기록 완료</button>
    			  			</div>
    			  		</div>
    			  	</div>
    			</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
