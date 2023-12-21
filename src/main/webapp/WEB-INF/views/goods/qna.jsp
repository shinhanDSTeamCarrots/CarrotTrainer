<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    		<div class="qnaHeader">
    			<h1>상품문의</h1>    		
	    		<div class="writeQna">
	    			<button class="writebtn"></button>
	    		</div>
	    	</div>
    		<div class="qnaList">
    			<table class="qnaTable">
    				<thead>
	    				<tr>	    					
	    					<th>글번호</th>
	    					<th>제목</th>
	    					<th>작성자</th>
	    					<th>작성일</th>	    					
	    				</tr>
    				</thead>
    				<tbody>
    		
    				
    				</tbody>
    			</table>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
