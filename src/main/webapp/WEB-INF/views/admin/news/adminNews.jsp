<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>자유게시판</title>
<META name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script src="js/script.js"></script>
</head>
<style>
  body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f4f4f4;
  }
  .news-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    background: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  .news-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
  .news-header h2 {
    margin: 0;
  }
  .write-button {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
  }
  .write-button:hover {
    background-color: #0056b3;
  }
  .news-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
  }
  .news-card {
    background-color: #f0f0f0;
    padding: 20px;
    border-radius: 4px;
    height: 200px;
    /* Placeholder for actual news content */
  }
  .news-card p {
    margin: 0;
    color: #333;
  }
  .pagination {
    text-align: center;
  }
  .pagination span {
    padding: 5px 10px;
    margin: 0 5px;
    border: 1px solid #ddd;
    cursor: pointer;
  }
  .pagination .active {
    background-color: #007bff;
    color: white;
    border-color: #007bff;
  }
</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
  <div class="news-container">
  <div class="news-header">
    <h2>건강뉴스 관리</h2>
    <a href="adminWrite" class="write-button">글쓰기</a>
  </div>
  
  <div class="news-grid">
    <!-- 카드 뉴스 6개 생성 -->
    <div class="news-card"><p>제목: 헤드라인1</p></div>
    <div class="news-card"><p>제목: 헤드라인2</p></div>
    <div class="news-card"><p>제목: 헤드라인3</p></div>
    <div class="news-card"><p>제목: 헤드라인4</p></div>
    <div class="news-card"><p>제목: 헤드라인5</p></div>
    <div class="news-card"><p>제목: 헤드라인6</p></div>
  </div>
  
  <div class="pagination">
    <!-- 페이징 순서 -->
    <span class="active">1</span>
    <span>2</span>
    <span>3</span>
    <!-- ... More page numbers if needed ... -->
  </div>
</div>
    	</div>
</body>
</html>