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

.NewsImg {
  width: 336px; /* or any other size */
  height: 200px; /* or any other size */
  object-fit: cover; /* This will ensure that the aspect ratio is maintained and the image is covered nicely within the dimensions. */
}


.card-title,
.card-author {
    font-size: 1.2rem;
    margin-bottom: 10px;
}

.pagination {
	margin-top: 20px;
	text-align: center;
}


  .pagination a {
    display: inline-block;
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ddd;
    color: #333;
    text-decoration: none;
    font-size: 1.5em;  /* 폰트 크기를 늘림 */
}
.pagination a.active {
    background-color: #007bff;
    color: white;
}
.pagination a:hover {
    background-color: #0056b3;
    color: white;
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

<!-- <div class="write-btn-container">
		
				<a href="write" class="write-button">게시글 등록</a>
			
			</div> -->

        <div class="cards-container">
            <!-- 여러 카드를 반복적으로 표시 -->
            
            <div class="card">
            <div class="card-image">
                	<a href="cardRead3"><img class="NewsImg" src="/myct/img/upload/cardnews_04.jpg" /></a>
                </div>
               </div>
               
               <div class="card">
            <div class="card-image">
                	<a href="cardRead2"><img class="NewsImg" src="/myct/img/upload/cardnews_02.jpg" /></a>
                </div>
               </div>
               
               <div class="card">
            <div class="card-image">
                	<a href="cardRead"><img class="NewsImg" src="/myct/img/upload/cardnews_03.jpg" /></a>
                </div>
               </div>
            <c:forEach items="${page}" var="vo">
            	<c:if test="${vo.category_no == 4}">
          
				
				
				
				<div class="card">
                
                <div class="card-title">제목:<c:out value="${vo.board_title}" /> </div>
                <div class="card-author">작성자:<c:out value="${vo.member_nickname}" /></div>
                
                
            </div>
            
            
            
           
            </c:if>
            </c:forEach>
            
        </div>
       		
<div class="pagination">
    <c:if test="${pageMaker.prev}"> 
        <a href="?page=${pageMaker.startPage - 1}">이전</a>
    </c:if>
    
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
        <a href="?page=${pageNum}" class="${pageNum eq pageMaker.cri.page ? 'active' : ''}">${pageNum}</a>
    </c:forEach>
    
    <c:if test="${pageMaker.next}"> 
        <a href="?page=${pageMaker.endPage + 1}">다음</a>
    </c:if>
</div>
    </div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>