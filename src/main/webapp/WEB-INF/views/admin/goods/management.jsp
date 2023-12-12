<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title></title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    	
    	<!-- 관리자페이지 상품관리 헤더 -->
    	<div class="gmheader">
    		<h1>상품관리</h1>
    		<!-- 검색창 -->
	   		<div class="search_wrap">
	   			<div class="search_area">
	   				<input type="text" name="search_goods" value=""> 
	    			<button id="search">검색</button>
	    		</div>
	   		</div>
    	</div>
    	
    	<!-- 저장된 상품 목록 리스트 -->
    	<div class="gmlist">
    		<ul>
				<c:forEach items="${goodsList}" var="goodsList">
				<li>
					<div class="goodsCategory">${goodsList.category_no }</div>
					<div class="goodsName">${goodsList.goods_name }</div>
					<div class="goodsImage">${goodsList.image }</div>
					<div class="goodsPrice">${goodsList.price}</div>
					<div class="goodDetail">${goodsList.image_detail1 }</div>
					<div class="purchaseInfo">${goodsList.purchase_info }</div>
					<div class="registerDate">${goodsList.register_date }</div>
					<div class="goodsStock">${goodsList.goods_stock }</div>
					<div class="goodsIsdeleted">${goodsList.is_delete }</div>
					<div class="goodsOption">${goodsList.option_name }</div>
					<div class="goodsPriceUpdown">${goodsList.price_updown }</div>
				</li>
				</c:forEach>
   			</ul>
    	</div>
    	
    	<!-- 상품등록 폼 -->
    	
    	
    	
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
