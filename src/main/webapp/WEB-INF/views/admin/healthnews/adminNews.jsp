<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 페이지 웰니스뉴스 </title>
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
.container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
}

.board-title {
    font-size: 2rem;
    text-align: center;
    margin-bottom: 30px;
}

.write-btn-container {
	text-align: right; /* 버튼을 오른쪽으로 정렬 */
	margin: 20px 0 20px; /* 상단 여백 추가 */
	
}

.write-button {
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	padding: 10px 20px; /* 패딩 */
	border: none; /* 테두리 없음 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 클릭 가능한 커서 모양 */
	font-size: 1.0rem; /* 글씨 크기 */
	margin-bottom: 0px; /* 하단 여백 추가 */
	font-weight: 700;
}



.cards-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.card {
    width: calc(33.333% - 20px); /* Three cards per row, with some margin */
    margin-bottom: 30px;
    background-color: #f3f3f3;
    padding: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card-image {
    height: 200px; /* Fixed height for placeholder */
    background-color: #ddd; /* Placeholder color */
    margin-bottom: 15px;
}

.card-title,
.card-author {
    font-size: 1.2rem;
    margin-bottom: 10px;
}

.pagination {
    text-align: center;
    margin-top: 30px;
}

.pagination span {
    margin: 0 10px;
    cursor: pointer;
}


</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
        <h1 class="board-title">관리자 페이지 웰니스 뉴스</h1>
        <!-- 글쓰기 버튼 -->
			<div class="write-btn-container">
			<c:if test="${!empty loginInfo }">
				<a href="write" class="write-button">게시글 등록</a>
				</c:if>
			</div>

        <div class="cards-container">
            <!-- 여러 카드를 반복적으로 표시 -->
            <div class="card">
                <div class="card-image"><a href="/myct/healthnews/cardread">웰니스 뉴스</a></div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <!-- 추가 카드 -->
            <div class="card">
                <div class="card-image">이미지1</div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <div class="card">
                <div class="card-image">이미지1</div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <div class="card">
                <div class="card-image">이미지1</div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <div class="card">
                <div class="card-image">이미지1</div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <div class="card">
                <div class="card-image">이미지1</div>
                <div class="card-title">제목: 타이틀1</div>
                <div class="card-author">작성자:</div>
            </div>
            <!-- ... -->
        </div>
        <div class="pagination">
            <!-- 페이지네이션 -->
            <span>1</span>
            <span>2</span>
            <!-- ... -->
        </div>
    </div>
    </div>
    
</body>
</html>