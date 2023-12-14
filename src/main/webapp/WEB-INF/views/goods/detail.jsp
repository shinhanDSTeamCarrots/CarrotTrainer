<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>상품상세</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goods/detail.css"/>
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
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
			    				<li><a href="${pageContext.request.contextPath}/goodsList/1">닭가슴살</a></li>
			    				<li><a href="${pageContext.request.contextPath}/goodsList/2">도시락</a></li>
			    				<li><a href="${pageContext.request.contextPath}/goodsList/3">샐러드</a></li>	    				
		    				</ul>
	    				</li>
	    			</ul>
	    		</div>   		
		    	<!-- 상품 카테고리명 & 검색창 -->
		   		<h1><c:out value="${item.category_name }"/></h1>
		
		   		<!-- 검색창 -->
		   		<div class="search_wrap">
		   			<div class="search_area">
		   				<input type="text" name="search_goods" value=""> 
		    			<button id="search">검색</button>
		    		</div>
		   		</div>
		    </div>
		    
		    <!-- 상품 디테일 페이지 -->
		    <div class="goodsDetail">		    	
	
				<div class="goodsImg">
					<img id="goodsImg" src="/myct/img/goods/${item.image }.jpg"/>
				</div>
				<div class="goodsInfo">
					<div class="goodsName">
						<p>${item.goods_name}</p>
					</div>
					<div class="goodsPrice">
						<p>${item.price}원</p>
					</div>
					<div class="title-division-line"></div>
					<div class="deliveryfee">
						<p>배송비 | ${item.delivery_fee }원</p>
					</div>
					<div class="title-division-line"></div>
					<div class="option">
						<select name="selectOption">
							<option disabled selected> [필수] 옵션을 선택해주세요 </option>
							<c:forEach items="${detail}" var="detail">
								<option>${detail.option_name } +${detail.price_updown }원 </option>	
							</c:forEach>
						</select>
					</div>
					<div class="btns">	
						<button class="cartbtn" onclick="">장바구니</button>
						<button class="purchasebtn" onclick="">구매하기</button>
						
					</div>
				</div>
			</div>	
			<!-- 상품상세 페이지 메뉴 바 -->
			<div class="detailMenu" id="scroll-event">
  				<ul>
   				<li><a href="#detailImage">상세설명</a></li>
    			<li><a href="#detailPurchaseInfo">구매정보</a></li>
    			<li><a href="#detailReview">상품후기</a></li>
    			<li><a href="#detailQna">상품문의</a></li>
  				</ul>
   			</div>
		
			<div class="detailMenuContent">
				<div class="itemDetailImage" id="detailImage">
					<p>상세이미지</p>
				</div>
				<div class="itemDetailPurchaseInfo" id="detailPurchaseInfo">
					${item.purchase_info}
				</div>
				<div class="itemDetailReview" id="detailReview">
					<p>전체 리뷰</p>
					<jsp:include page="/review/shoppingReview.do?goods_no=${item.goods_no }"/>
				</div>
				<div class="itemDetailQna" id="detailQna">
					<p>전체 문의</p>
				</div>
			
			</div>
		   
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
