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
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script>
	$(function(){
	    // swiper
	    var swiper = new Swiper('.swiper-visual',{
	        autoplay : {
	            delay:3000
	        },
	        loop : true
	    });
	});
	</script>		
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>		
		<div class="container">	
			<!-- 이미지 슬라이드 + 인기상품 -->
			<div class="health">
				<!-- 이미지 슬라이드 -->
				<div class="visual">
		            <div class="swiper swiper-visual">
		                <div class="swiper-wrapper">
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide1.png');"></div>
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide2.png');"></div>
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide3.png');"></div>
		              
		                </div>
		            </div>   
		        </div>        
			</div>
			<div class="list-division-line"></div>
			<!-- 게시판  -->
			<div class="board">		
				<!-- 공지사항 -->
				<div class="noticeboard">
					<div class="noticeboard-content">
						<p class="title">공지사항</p>
						<div class="title-division-line"></div>
						<div class="noticeboard-detail">
							<div class="board-detail-wrap">
								<c:forEach items="${noticeList}" var="notices" varStatus="loop">
								<div class="boardRank">
									<p class="boardRankNum">${loop.index + 1}</p>
									<p class="boardRankTitle">${notices.board_title }</p>
								</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<!-- 자유게시판 인기글 -->
				<div class="freeboard">
					<div class="freeboard-content">
						<p class="title">인기글</p>
						<div class="title-division-line"></div>
						<div class="freeboard-detail">
							<div class="board-detail-wrap">
								<c:forEach items="${hotBoardList}" var="hotBoard" varStatus="loop">
								<div class="boardRank">
									<p class="boardRankNum">${loop.index + 1}</p>
									<p class="boardRankTitle">${hotBoard.board_title }</p>
								</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 인기상품 -->
			<div class="shopping-wrap">
				<div class="shopping">
					<div class="shopping-content">
						<p class="title">★나당트 인기 메뉴★</p>
						<div class="title-division-line"></div>
						<div class="item">
							<c:forEach items="${hotGoodsList}" var="hotGoods">							
								<a href=${pageContext.request.contextPath}/detail/${hotGoods.goods_no } style="cursor: pointer;">
								<div class="itemInfo">
									<div class="goods">
										<img id="goodsImg" src="/myct/img/goods/${hotGoods.image }.jpg"/>								
										<p class="goodsname">${hotGoods.goods_name }</p>
										<p class="goodsPrice">${hotGoods.price }원</p>
									</div>	
								</div>
								</a>
							</c:forEach>
						</div>
					<div class="title-division-line"></div>
					</div>				
				</div>
			</div>	
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>
