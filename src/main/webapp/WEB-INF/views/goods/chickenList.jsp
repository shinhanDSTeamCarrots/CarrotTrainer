<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page isErrorPage="true" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title></title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goods/goodslist.css"/>
	<script src="js/script.js"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		
    		<!-- 카테고리 메뉴바(카테고리 + 카테고리명 + 검색창) -->
    		<div class="goods_header">
	    		<div class="category">	
	    			<ul class="depth1">
	    				<li>
		    				<a>카테고리</a>
		    				<ul class="depth2">
			    				<li><a href="">닭가슴살</a></li>
			    				<li><a href="">도시락</a></li>
			    				<li><a href="">샐러드</a></li>	    				
		    				</ul>
	    				</li>
	    			</ul>
	    		</div>
	    		   		
		    	<!-- 상품 카테고리명 & 검색창 -->
		   		<h1>닭가슴살</h1>
		
		   		<!-- 검색창 -->
		   		<div class="search_wrap">
		   			<div class="search_area">
		   				<input type="text" name="search_goods" value=""> 
		    			<button id="search">검색</button>
		    		</div>
		   		</div>
		    </div>
		    
    	<!-- 상품목록 -->
   		<div class="goods_list">
   			<ul>
				<c:forEach items="${goodsList}" var="goods">
				<li>
					<div class="goodsImg">
						<a href="#"><img url="/src/main/webapp/img/goods/닭가슴살${goods.goods_no }.jpg"></a>
					</div>
					<div class="goodsName">
						<a href="#">${goods.goods_name}</a>
					</div>
					<div class="goodsPrice">
						${goods.price}
					</div>
				</li>
				</c:forEach>
   			</ul>
   		</div>
   	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>