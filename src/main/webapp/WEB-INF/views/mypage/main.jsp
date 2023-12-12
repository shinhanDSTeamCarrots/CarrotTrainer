<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>글쓰기</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
	<!-- CKEditor CDN 추가 -->
    <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
</head>
<style>
  body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f4f4f4;
  }
  .mypage-container {
    max-width: 800px;
    margin: 0 auto;
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  .section {
    border: 1px solid #ccc;
    margin-bottom: 20px;
    padding: 10px;
    border-radius: 4px;
  }
  .section h3 {
    margin-top: 0;
  }
  .section a {
    display: block;
    margin-bottom: 10px;
    color: #007bff;
    text-decoration: none;
  }
  .section a:hover {
    text-decoration: underline;
  }
</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="mypage-container">
  <div class="section">
    <h3>회원 정보</h3>
    <p>나이: 19</p>
    <p>BMI: 100</p>
    <!-- 링크를 통해 회원 정보 페이지로 이동할 수 있습니다 -->
    <a href="member-info.html">회원 정보 수정</a>
  </div>
  
  <div class="section">
    <h3>게시글 정보</h3>
     <!-- 링크를 통해 게시글 관리 페이지로 이동할 수 있습니다 -->
    <p> <a href="my-posts.html">내 게시글 보기</a> </p>
    <p> <a href="my-comments.html">내 댓글 보기</a></p>
   
   
   
  </div>
  
  <div class="section">
    <h3>구매 내역</h3>
    <!-- 링크를 통해 구매 내역 페이지로 이동할 수 있습니다 -->
    <a href="purchase-history.html">구매한 상품</a>
    <a href="purchase-actions.html">구매 활동 상황</a>
  </div>
</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>