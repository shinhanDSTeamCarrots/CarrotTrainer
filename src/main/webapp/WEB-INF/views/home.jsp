<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>Home</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
</head>
<body>
	<div id="popup"></div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
		
		<div class="noticeDiv">
			<c:forEach items="${noticeList}" var="notices">
			<p>${notices.board_title }</p><br>
			</c:forEach>
		</div>
		<div class="hotBoardDiv">
			<c:forEach items="${hotBoardList}" var="hotBoard">
			<p>${hotBoard.board_title }</p><br>
			</c:forEach>
		</div>
		<div class="hotGoodsDiv">
			<c:forEach items="${hotGoodsList}" var="hotGoods">
			<p>${hotGoods.goods_name }</p><br>
			</c:forEach>
		</div>
		
		
		
		
		</div>

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>
