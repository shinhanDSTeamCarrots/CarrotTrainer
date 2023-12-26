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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goods/management.css"/>
	<script src="js/script.js"></script>
	
	<!-- js -->
	<script>
	
	
	
	</script>
	
	
	
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
		   			<form method="get" name="searchForm" id="searchForm" action="${pageContext.request.contextPath}/admin/goods/management">
			   			<div class="search_area">
			   				<input type="text" name="search_goods" value="${search_goods}" title="검색어 입력"> 
			    			<input type="submit" id="search" value="검색" title="검색">
			    		</div>
			    	</form>
		   		</div>
	    	</div>
	    	
	    	<!-- 저장된 상품 목록 리스트 -->
	    	
	    	<div class="gmlist">
	    		<h2>상품목록</h2>	
		  		<table class="qnaTable">
					<thead>
						<tr>	    					
							<th>상품번호</th>
							<th>이미지</th>
							<th>카테고리</th>
							<th>이름</th>
							<th>가격</th>
							<th>등록일</th>
							<th>재고</th>	
								        					
						</tr>
					</thead>
					<tbody>
					<c:if test="${empty goodsList}">
						<tr>
							<td class="none" colspan="4">등록된 상품이 없습니다</td>
						</tr>	    					
					</c:if>
					<c:forEach items="${goodsList}" var="goodsList">
						<tr>
							<td class="goodsNo">${goodsList.goods_no }</td>
							<td class="goodsImg"><img id="goodsImg" src="/myct/img/goods/${goodsList.image }.jpg"/></td>
							<td class="goodsCategory">${goodsList.category_no }</td>
							<td class="goodsName">${goodsList.goods_name }</td>
							<td class="goodsPrice">${goodsList.price}원</td>
							<td class="registerDate">${goodsList.register_date }</td>
							<td class="goodsStock">${goodsList.stock }개</div>
						</tr>
					</c:forEach>
					</tbody>
		 		</table>
			</div>
	    	
	    	
	    	<!-- 상품등록 -->
			<div class="insertForm" id="goodsInsert">						
	    		<div class="goodsHeader">
					<h2 class="sub_title">상품 등록하기</h2>
					<p class="goodsCnt"><span>총 <c:out value="${qnaCount}" />개</span></p>
					<button class="writebtn">상품등록</button>
				</div>
				<!-- 상품등록 폼 -->
				<form action="${pageContext.request.contextPath}/admin/goods/insert" method="post" class="writeform">
					
					<div class="goods_name">
						<p>상품이름</p>
						<input type="text" name="goods_name" class="goods_name">
					</div>
					<div class="price">
						<p>가격</p>
						<input type="text" name="price" class="price">
					</div>
					<div class="discount_price">
						<p>할인가</p>
						<input type="text" name="discount_price" class="discount_price">
					</div>
					<div class="delivery_fee">
						<p>배송비</p>
						<input type="text" name="delivery_fee" class="delivery_fee">
					</div>
					
					<div class="image">
						<p>대표이미지</p>
						<input type="file" name="image" accept="image/*">
	    			</div>
					<div class="image_detail1">
						<p>상세이미지</p>
						<input type="file" name="image_detail1" accept="image/*">
					</div>
					<div class="purchase_info">
						<p>구매정보</p>
						<input type="text" name="purchase_info" class="purchase_info">
					</div>				
					<div class="stock">
						<p>재고</p>
						<input type="text" name="stock" class="stock">
					</div>
					<div class="category_no">
						<p>카테고리 번호</p>
						<input type="text" name="category_no" class="category_no">
					</div>
					
					<div class="insertBtns">
						<button class="donebtn" type="submit">등록완료</button>
						<button class="closebtn">취소</button>
					</div>
				</form>
	    	</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
