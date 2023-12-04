<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>답변게시판</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
</head>
<style>
 .container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .board-title {
        font-size: 2.4rem;
        font-weight: 700;
        margin-bottom: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
        font-size: 1.2rem;
    }

    th {
        background-color: #f2f2f2;
        font-weight: 700;
    }

    .pagination {
        margin-top: 20px;
        text-align: center;
    }

    .pagination span {
        margin: 0 5px;
        cursor: pointer;
        font-size: 25px;
    }

    .search-container {
        text-align: right;
        margin-top: 20px;
    }

.search-input {
    padding: 10px 15px; /* 입력창 내부 여백을 좌우로 제공 */
    font-size: 1.6rem; /* 입력창 글씨 크기 조정 */
    border: 1px solid #ddd; /* 테두리 스타일 조정 */
    margin-right: 8px; /* 입력창과 검색버튼 사이의 간격 조정 */
    width: 300px; /* 입력창 너비 조정 */
    height: 48px; /* 입력창 높이 조정 */
    vertical-align: middle; /* 입력창을 수직 중앙에 위치시키기 위함 */
}

.search-button {
    background-color: #4CAF50; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    padding: 0 20px; /* 버튼 내부 여백을 좌우로만 제공 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 클릭 가능한 커서 모양 */
    font-size: 1.6rem; /* 버튼 글씨 크기 조정 */
    height: 38px; /* 버튼 높이 조정 */
    line-height: 38px; /* 버튼의 높이에 맞춰 line-height 설정 */
    text-align: center; /* 텍스트를 버튼의 중앙으로 정렬 */
    display: inline-block; /* inline-block으로 설정하여 line-height가 적용되도록 함 */
    vertical-align: middle; /* 버튼을 수직 중앙에 위치시키기 위함 */
    white-space: nowrap; /* 텍스트를 한 줄로 유지 */
}

    
    .write-btn-container {
    text-align: right; /* 버튼을 오른쪽으로 정렬 */
    margin-top: 20px; /* 상단 여백 추가 */
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
}
    
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
            <div class="board-title">답변게시판</div>
            <!-- 글쓰기 버튼 추가 -->
<div class="write-btn-container">
    <button class="write-button">글쓰기</button>
</div>
            
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회</th>
                        <th>추천</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1003</td>
                        <td>첫 번째 게시물 제목</td>
                        <td>홍길동</td>
                        <td>2023-01-01</td>
                        <td>100</td>
                        <td>10</td>
                    </tr>
                    <tr>
                        <td>1004</td>
                        <td>두 번째 게시물 제목</td>
                        <td>이순신</td>
                        <td>2023-01-02</td>
                        <td>150</td>
                        <td>20</td>
                    </tr>
                    <tr>
                        <td>1005</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                   <tr>
                        <td>1006</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>1007</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <!-- 추가 게시물 행을 여기에 추가 -->
                </tbody>
            </table>

            <div class="pagination">
                <span>1</span>
                <span>2</span>
                <span>3</span>
                <span>4</span>
                <span>5</span>
                <span>6</span>
            </div>

            <div class="search-container">
                <input type="text" class="search-input">
                <button class="search-button">검색</button>
            </div>
        </div>


		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>