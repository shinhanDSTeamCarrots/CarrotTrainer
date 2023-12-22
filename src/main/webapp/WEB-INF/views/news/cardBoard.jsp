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
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<!-- CKEditor CDN 추가 -->
    <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    
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

.search-container {
    display: flex; /* Flexbox를 사용하여 인라인으로 정렬 */
    justify-content: flex-end; /* 요소들을 컨테이너의 끝으로 정렬 */
    margin-top: 20px; /* 상단 여백 */
    margin-bottom: 20px; /* 하단 여백 */
}

.search-input {
    /* flex-grow: 1; 사용 가능한 전체 공간을 차지하지 않도록 주석 처리합니다. */
    width: 250px; /* 검색창의 너비를 250px로 조정합니다. */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px 0 0 5px;
    font-size: 1rem;
    margin-right : 10px;
}

.search-button {
    padding: 10px 20px;
    border: 1px solid #4CAF50; /* 버튼 경계선 스타일 */
    background-color: #4CAF50; /* 버튼 배경색 */
    color: white; /* 버튼 글자색 */
    cursor: pointer; /* 커서 스타일 */
    border-radius: 0 5px 5px 0; /* 오른쪽 상단과 오른쪽 하단의 테두리를 둥글게 */
    font-size: 1rem; /* 폰트 사이즈 */
    transition: background-color 0.3s ease; /* 배경색 변경시 트랜지션 효과 */
}

.search-button:hover {
    background-color: #367c39; /* 마우스를 올렸을 때 버튼의 배경색 변경 */
}

.search-button i {
    margin-right: 5px; /* 아이콘과 텍스트 사이의 여백 */
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
        <h1 class="board-title">웰니스 뉴스</h1>
        <div class="search-container">
    <input type="text" id="search-input" class="search-input" placeholder="검색">
    <button id="search-button" class="search-button">
        <i class="fas fa-search"></i> 검색
    </button>
</div>

        <div class="cards-container">
            <!-- 여러 카드를 반복적으로 표시 -->
            <div class="card">
                <div class="card-image"><a href="/myct/healthnews/cardread.do">웰니스 뉴스</a></div>
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
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>