<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>운동 정보</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/exerciseStyle.css"/>
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class="info">
    			<div class="search">
    				<div class="healthInfo-title">
	    				<p class="healthInfo-title-text">EXERCISE</p>
	    				<button class="select" type="submit" onclick="">선택</button>
    				</div>
    				<div class="title-division-line"></div>
    				<div class="search-place">
    					<div id="search-box"><input type="text" name="healthName" value=""></div>
	    				<div id="search-text"><p>검색</p></div>
    				</div>
    				<div class="detail-division-line"></div>
    				<div class="search-tag">
    				</div>
    			</div>
    			<div class="list">
    				<p class="list-text">즐겨찾기 목록</p>
	    			<%-- 검색하면
	                <c:if test="${ }}">
	                    <a class="list-text">즐겨찾기 목록</a>
	                </c:if>
	                <c:if test="${ }">
	                    <a class="list-text">검색 결과</a>
	                </c:if>
	                --%>
	                <div class="list-division-line">
	                	<img>
	                	<p>검색 결과: 00개</p>
	                </div>
	                <div class="list-result">
	                </div>
    			</div>
   			</div>
    		<div class="add-info">
    			<div class="add-info-content">
	    			<div class="add-info-title">
	    				<p class="healthInfo-title-text">ADD</p>
	    			</div>
	    			<div class="title-division-line"></div>
	    			<div class="date"><p>날짜</p></div>
	    			<div class="detail-division-line"></div>
	    			<div class="healthInfo">
	    				<div id="healthInfo-text">
	    					<p>총 00분 운동 진행</p>
	    					<p>000kcal 소비</p>
	    				</div>
	    				<div id="healthInfo-graph"></div>
	    				<div class="healthInfo-select">
	    				</div>
	    			</div>
	    			<button class="select-info" type="submit" onclick="">기록 완료</button>
	    			<%-- 이미 입력 값이 없으면
	                <c:if test="${ }}">
	                    <button class="select-info" type="submit" onclick="">기록 완료</button>
	                </c:if>
	                <c:if test="${ }">
	                    <button class="select-info" type="submit" onclick="">수정</button>
	                </c:if>
	                --%>
	    		</div>
	    	</div>
   		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
