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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    
</head>
<style>
.container {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
}

.board-title {
    font-size: 2rem;
    text-align: center;
    margin-bottom: 30px;
}

.post-details {
    margin-bottom: 20px;
}

.post-title {
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.post-meta {
    font-size: 1rem;
    color: #777;
    margin-bottom: 20px;
}

.post-content {
    border: 1px solid #ccc;
    padding: 15px;
    margin-bottom: 20px;
    /* 이미지가 실제로 들어갈 경우 아래의 스타일을 적용하십시오. */
    /* background-image: url('path-to-image.jpg'); */
    height: 400px; /* 가상의 내용을 위한 고정 높이 */
}

.pagination {
    text-align: center;
    margin-top: 30px;
    padding: 10px 0;
}

.page-link,
.page-number {
    display: inline-block;
    margin: 0 5px;
    padding: 5px 10px;
    text-decoration: none;
    color: #333;
    border: 1px solid #ddd;
    background-color: #f8f8f8;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.page-link:hover,
.page-number:hover {
    background-color: #e9e9e9;
}

.page-number.active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}


hr {
    border: none;
    height: 1px;
    background-color: #ddd;
    margin-bottom: 20px;
}

</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
        <h1 class="board-title">웰니스 뉴스</h1>
        <div class="post-details">
            <h2 class="post-title">제목: 안녕하세요</h2>
            <div class="post-meta">등록일: 2023-11-12 조회수: 92</div>
            <hr>
            <div class="post-content">
                <p>여기에는 카드뉴스 내용이 들어갑니다...</p>
            </div>
        </div>
       <div class="pagination">
    <a href="#" class="page-link">처음</a>
    <a href="#" class="page-link">이전</a>
    <a href="#" class="page-number active">1</a>
    <a href="#" class="page-number">2</a>
    <a href="#" class="page-number">3</a>
    <a href="#" class="page-number">4</a>
    <a href="#" class="page-number">5</a>
    <a href="#" class="page-link">다음</a>
    <a href="#" class="page-link">마지막</a>
</div>

    </div>
    	
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	 </div>
</body>
</html>