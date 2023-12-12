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
    	
	    	<!-- 카테고리 -->
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
		    </div>
		    
		    <!--  장바구니 진행 위치 -->
		    <div class="cart_header">
		    	<h1 id ="cart_title">장바구니</h1>
		    	<h2 id="cart_subtitle">1.장바구니</h2>
		    	<h2 id="cart_later"> > 2.주문/결제 > 3.주문완료</h2>	    
		    </div>
		    
		    <!-- 전체 선택 삭제 -->
		    <div class="select_all">
		    	<input type="checkbox" id = "selectAll">
		    	<label for ="selectAll">전체 선택</label>
		    	<button id="deleteSelected"><img src="/webapp/img/trashcan"></button>
		    </div>
		    
		    <!-- 장바구니 담긴 목록 보여주기 -->
		    <div class="cart_list">
		    	<div class="each_cartitem">
		    		<ul>
						<c:forEach items="${cartList}" var="cartList">
						<li>
							<div class="goodsImg">
								<img src="/webapp/img/goods/닭가슴살${cartList.goods_no }.jpg">
							</div>
							<div class="goodsName">
								<a href="#">${cartList.cart_name }</a>
							</div>
							<div class="goodsOption">
								${cartList.option_name}
							</div>
							<div class="itemCnt">
								${cartList.goods_cnt}
							</div>
							<div class="itemPrice">
								${cartList.option_name}
							</div>
						</li>
						</c:forEach>
	   				</ul>	    	
		    	</div>	    
		    </div>
		    
		    
		    <div class="title-division-line"></div>
		    
		    <!-- 총 가격 합산 -->
			<div class="totalPrice">
			
			</div>	 
		    
		    
		    <!-- 결제하기 버튼 -->
		    <div class="purchaseButton">
		    	<button class="purchase" onclick="location.href='${page.Context.request.contextPath}'">결제하기</button>
		    </div>
		    
	    
	    
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
