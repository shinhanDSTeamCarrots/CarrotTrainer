<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제가 완료되었습니다!</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
<style type="text/css">
.container {
	width:100%;
	max-width:1200px;
	margin : 0 auto;
	display:flex;
	padding: 20px;
    box-sizing: border-box;
    flex-direction:column;
}

/* 장바구니 헤더 */
.cart_header{
	background-color: #EDF1D6;
	display:flex;	
	flex-direction:row;
	width:100%;
	heigth:40px;
	color:#435334;
	justify-content: space-between;
    align-items: center;
}
.cart_header > .rightAlign{
	text-align: right;
	display:flex;
	line-height:40px;
	margin-right:20px;
}
.cart_header > h1{
	line-height: 40px;
	margin-left: 20px;
	
}
.cart_header > .rightAlign > #cart_subtitle{
	font-weight: 600;	
	line-height: 40px;
	margin-right:20px;
	margin-left:20px;
	
}
.cart_header > .rightAlign > #cart_later{
	font-weight: 400;
	line-height: 40px;
}

/*구분선*/

.title-division-line {
	width:1160px;
	border-top: 1.5px solid #435334;
	margin : 0 auto;
}

.totalprice-division-line {
	width:1160px;
	border-top: 3px solid #435334;
	margin : 0 auto;
}
.container > strong {
	text-align: center;
}

</style>
</head>
<body>
 <div class="wrap">
   	<%@ include file="/WEB-INF/views/common/header.jsp" %>
   	<div class="container">
   	<div class="cart_header">
    	<h1 id="cart_title">장바구니</h1>
    	<div class="rightAlign">
	    	<h2 id="cart_later">1.장바구니 &gt; 2.주문/결제 &gt;</h2>
	    	<h2 id="cart_subtitle">3.주문완료</h2>
	    </div>   
    </div>
	<strong>결제 번호: ${order }</strong>
	<strong>결제가 완료되었습니다!</strong>
   	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>