<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/modalScript.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/userInfoScript.jsp"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/diaryScript.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/calendarScript.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="diary-title">
    			<p class="diary-title-text">TODAY'S DIARY</p>
   				<button class="move" onclick="location.href='${pageContext.request.contextPath}/bodyReport'">모아보기</button>
    		</div>
    		<div class="title-division-line"></div>
    		<p class="diary-text">안녕하세요, <span class="sql-text-name"></span>님!</p>
    		<div class="diary-content">
    			<div class="diary-result">
    				<div class="diary-calendar">
	    				<div id="calendar">
	    					<div id="calendar_header">
	    						<span class="arrow left-arrow">&lt;</span>
	    						<div class="month-year"></div>
	    						<span class="arrow right-arrow">&gt;</span>
	   						</div>
	   						<div id="calendar_weekdays"></div>
	   						<div id="calendar_content"></div>
	 					</div>
 					</div>
    				<div class="diary-result-text">
    					<img src="${pageContext.request.contextPath}/img/carrot_border.png">
    					<div class="diary-result-wrap">
		    				<div class="diary-result-main">
		    					<div class="diary-result-main-text">
			    					<p>총 섭취량 <span class="sql-diary-result-main">1100</span>kcal</p>
			    					<p>총 활동량 <span class="sql-diary-result-main">50</span>kcal</p>
		    					</div>
		    					<div class="detail-division-line"></div>
		    					<div id="diary-result-main-sub">
			    					<p>남은 섭취량 <span class="sql-diary-result">200</span>kcal</p>
			    					<p>오늘의 상태는? 
				    					<span class="sql-diary-result" id="sql-weight-result">
					    					<c:if test="${empty bodyChange }">0.0</c:if>
							                <c:if test="${!empty bodyChange }">${bodyChange.weight }</c:if>
				    					</span>kg
			    					</p>
		    					</div>
		    				</div>
		    				<div class="diary-contact-text">
		    					<a href="${pageContext.request.contextPath}/foodDiary">오늘의 음식 기록하기 ></a>
		    					<a href="${pageContext.request.contextPath}/exercise">오늘의 운동 기록하기 ></a>
		    					<a href="#" id="popupBtn">오늘의 상태 기록하기 ></a>
	    					</div>
	    				</div>
    					<img src="${pageContext.request.contextPath}/img/carrot_border.png">
    				</div>
    			</div>
    			<div class="diary-comment">
    				<p id="diary-comment-title"><span class="sql-text-name" id="sql-user-name"></span>님의 <span class="sql-diary-comment">11월 20일</span>부터 <span class="sql-diary-comment">11월 26일</span>까지의 기록이에요</p>
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
    			  		<div id="modalBody-content">
    			  			<div id="modalBody-title">
    			  				<div id="modalBody-title-text">오늘의 상태</div>
    			  				<div class="title-division-line"></div>
    			  			</div>
    			  			<div id="modalBody-main">
    			  				<form id="modalBody-weight" method="post">
	    			  				<div class="modalBody-result">
	    			  					<div class="modalBody-input-essential">*</div>
	    			  					<div class="modalBody-text">체중(kg)</div>
		    			  				<div class="modalBody-input">
		    			  					<div id="minus-button">-</div>
			    			  				<input class="modalBody-input-text" type="text" name="weight" id="weight" value="${bodyChange.weight }">
			    			  				<div id="plus-button">+</div>
		    			  				</div>
		    			  			</div>
	    			  				<div class="detail-division-line"></div>
	    			  				<div class="modalBody-result">
	    			  					<div class="modalBody-text">골격근량(kg)</div>
		    			  				<div class="modalBody-input">
		    			  					<input class="modalBody-input-text" type="text" name="muscle_mass" id="muscle_mass" value="${bodyChange.muscle_mass }">
		    			  				</div>
		    			  			</div>
		    			  			<div class="modalBody-result">
	    			  					<div class="modalBody-text">체지방률(%)</div>
		    			  				<div class="modalBody-input">
		    			  					<input class="modalBody-input-text" type="text" name="fat_mass" id="fat_mass" value="${bodyChange.fat_mass }">
		    			  				</div>
		    			  			</div>
		    			  			<input type="hidden" name="body_change_no" id="body_change_no" value="${bodyChange.body_change_no }">
		    			  			<input type="hidden" name="member_no" id="member_no" value="${bodyChange.member_no }">
    			  				</form>
    			  			</div>
    			  			<div id="modalBody-button">
	    			  			<c:if test="${empty bodyChange }"><button id="modalBody-insertBtn">기록 완료</button></c:if>
							    <c:if test="${!empty bodyChange }">
							    	<button class="modalBody-updelBtn" id="modalBody-updateBtn">수정</button>
							    	<button class="modalBody-updelBtn" id="modalBody-deleteBtn">삭제</button>
							    </c:if>
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
