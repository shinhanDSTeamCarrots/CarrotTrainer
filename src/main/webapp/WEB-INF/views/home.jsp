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
		
			
			<div class="health">
				<div class="healthimg">
					이미지들어갈예정
				</div>
				 <div class="visual">
		            <div class="swiper swiper-visual">
		                <div class="swiper-wrapper">
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide1.png');"></div>
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide2.png');"></div>
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide3.png');"></div>
		                    <div class="swiper-slide" style="background-image:url('/myct/img/home/homeslide4.png');"></div>
		                </div>
		            </div>   
		        </div>
			
			</div>
		
			<div class="board">
			
				<div class="noticeboard">
					<p class="title">공지사항</p>
					<c:forEach items="${noticeList}" var="notices">
					<p>${notices.board_title }</p>
					</c:forEach>
				</div>
				<div class="freeboard">
					<p class="title">인기글</p>
					<c:forEach items="${hotBoardList}" var="hotBoard">
					<p>${hotBoard.board_title }</p>
					</c:forEach>
				</div>	
			</div>
			<div class="shopping">
				<p class="title">인기상품</p>
				<c:forEach items="${hotGoodsList}" var="hotGoods">
				<p>${hotGoods.goods_name }</p><br>
				</c:forEach>
			</div>
		
			
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>
