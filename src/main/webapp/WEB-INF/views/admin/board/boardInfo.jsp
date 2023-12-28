<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 게시판관리</title>
<META name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</head>
<style>
body {
	font-family: 'Roboto', sans-serif;
	color: #333;
	background-color: #f4f4f4;
}

.container {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.board-title {
font-size: 2.0rem;
	font-weight: 700;
	margin-bottom: 10px;
}


table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed; /* 컬럼 너비 고정 */
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

/* Hover effect for table rows */
tr:hover {
    background-color: #f5f5f5;
}

th {
	background-color: #f2f2f2;
}

.delete-btn, .write-btn {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
}

.delete-btn {
	background-color: #f44336;
}

.Private-btn {
	background-color: #6d58a6;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
}

.buttons {
	text-align: right;
	margin-bottom: 10px;
}

th:nth-child(1), td:nth-child(1), th:nth-child(3), td:nth-child(3) {
	text-align: center;
}

.pageInfo {
	list-style: none;
	display: inline-block;
	margin: 50px 0 0 400px;
}

.pageInfo li {
	float: left;
	font-size: 20px;
	margin-left: 18px;
	padding: 7px;
	font-weight: 500;
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

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

.active {
	background-color: #cdd5ec;
}

.search_area {
	display: inline-block;
	margin-top: 30px;
	margin-left: 0px;
}

.search_area input {
	height: 30px;
	width: 250px;
}

.search_area button {
	width: 100px;
	height: 36px;
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	font-size: 1.3rem; /* 버튼 글씨 크기 조정 */
}

.search_area select {
	height: 35px;
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

.search-box input[type="text"] {
    flex: 1; /* 검색창이 남은 공간을 모두 차지하도록 합니다. */
    padding: 8px; /* 패딩 추가 */
    border: 2px solid #ddd; /* 경계선 설정 */
    border-radius: 4px; /* 모서리 둥글게 설정 */
    font-size: 16px; /* 글자 크기 설정 */
}

.search-box button {
    padding: 8px 16px; /* 버튼 내부 여백 설정 */
    margin-left: 8px; /* 검색창과의 간격 설정 */
    margin-top: 8px;
    border: none; /* 기본 경계선 제거 */
    background-color: #007bff; /* 배경 색상 설정 */
    color: white; /* 글자 색상 설정 */
    cursor: pointer; /* 커서를 손가락 모양으로 설정 */
    border-radius: 4px; /* 모서리 둥글게 설정 */
    font-size: 16px; /* 글자 크기 설정 */
}

.search-box button:hover {
    background-color: #0056b3; /* 버튼에 마우스를 올렸을 때 색상 변경 */
}
</style>

<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>

		<div class="container">

			<div class="board-title">관리자 게시판 관리</div>
			<div class="buttons">
				<button class="write-btn" onclick="writeNotice()">
					<a href="write" class="write-button">게시글 등록</a>

				</button>

				<button onclick="deleteSelectedBoards()" class="write-btn">선택
					삭제</button>
				<button onclick="modifySelectedBoard()" class="write-btn">선택
					수정</button>
			</div>

			<table>
				<thead>
					<tr>
						<th>선택</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page}" var="vo">

						<tr id="row-${vo.board_no}" data-category-no="${vo.category_no}">

							<td><input type="checkbox" class="board-checkbox"
								data-board-no="${vo.board_no}"
								data-category-no="${vo.category_no}" /></td>

							<td><c:choose>
									<c:when test="${vo.category_no == 1}">공지사항</c:when>
									<c:when test="${vo.category_no == 2}">자유게시판</c:when>
									<c:when test="${vo.category_no == 3}">문의게시판</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose></td>

							<td>
								 <a href="javascript:void(0);"
								onclick="goToDetail(${vo.board_no});"> <c:out
										value="${vo.board_title}" /> <c:if test="${vo.hasReply}">
								
									</c:if>
							</a>
							</td>
							<td><c:out value="${vo.member_nickname}" /></td>

							<td><fmt:formatDate pattern="yyyy/MM/dd"
									value="${vo.board_rdate}" /></td>

							<td>
								<div class="btn_wrap">
									<button class="Private-btn" data-board-no="${vo.board_no}"
										data-category-no="${vo.category_no}"
										onclick="modifyBoard(this)">비공개</button>


									<button class="delete-btn"
										onclick="deleteBoard(${vo.board_no})">삭제</button>
								</div>
							</td>


						</tr>

						<c:if test="${board.hasReply}">
							<tr>
								<td colspan="5" style="text-align: center;">답글 등록됨</td>
							</tr>
						</c:if>

					</c:forEach>

					
				</tbody>
			</table>
			
			
			
		<form action="${pageContext.request.contextPath}/board/boardInfo" method="get">
    <div class="search-box">
        <!-- Ensure the input field has the name 'searchKeyword' -->
        <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하세요"/>
        <button type="submit">검색🔍</button>
    </div>
</form>


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


		<form id="moveForm" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
		</form>
	</div>

	</div>

	<script>
		let form = $("#infoForm");
		let mForm = $("#modifyForm"); 
	    
	    function modifyBoard(buttonElement) {
	    	 var boardNo = $(buttonElement).data("board-no");
	    	    var categoryNo = $(buttonElement).data("category-no"); 

	    	  
	    	    console.log("게시글 번호: " + boardNo + ", 카테고리 번호: " + categoryNo);
	        var isPrivate = confirm("이 게시글을 비공개 처리하시겠습니까?");
	        if(isPrivate) {
	            $.ajax({
	                url: '/myct/board/updatePrivate',
	                type: 'POST',
	                data: {
	                    board_no: boardNo,	               
	                    board_private: 1
	                },
	                success: function(response) {
	                    if(response === 'success') {
	                        alert("비공개 처리 되었습니다.");
	                        location.reload();  
	                    } else {
	                        alert("비공개 처리 실패했습니다.");
	                    }
	                },
	                error: function() {
	                    alert("오류 발생");
	                }
	            });
	        }
	    }


	    
	    
	    function deleteBoard(boardNo) {
	        if(confirm("게시글을 삭제하시겠습니까?")) {
	            // category_no 가져오기
	            var categoryNo = $("#row-" + boardNo).data("category-no");

	            $.ajax({
	                url: '/myct/board/delete',
	                type: 'POST',
	                data: {
	                    board_no: boardNo,
	                    category_no: categoryNo
	                },
	                success: function(response) {
	                    alert("삭제 되었습니다.");
	                    location.reload(); 
	                },
	                error: function() {
	                    alert("게시글 삭제 중 오류 발생");
	                }
	            });
	        }
	    }
	    
	  	/* 다중 선택 삭제 (미완성) */
	    function deleteSelectedBoards() {
	        var selectedBoards = $(".board-checkbox:checked").map(function() {
	            return $(this).data("board-no");
	        }).get();

	        if (selectedBoards.length === 0) {
	            alert("삭제할 게시글을 선택하세요.");
	            return;
	        }

	        if (confirm("선택한 게시글을 삭제하시겠습니까?")) {
	            $.ajax({
	                url: '/myct/board/deleteSelected',
	                type: 'POST',
	                data: { board_nos: selectedBoards },
	                success: function(response) {
	                    if(response === 'success') {
	                        alert("게시글이 삭제되었습니다.");
	                        location.reload();  
	                    } else {
	                        alert("게시글 삭제에 실패했습니다.");
	                    }
	                },
	                error: function(xhr, status, error) {
	                    alert("게시글 삭제 중 오류 발생: " + xhr.responseText);
	                }
	            });
	        }
	    }



	    function modifySelectedBoard() {
	        var selectedBoards = $(".board-checkbox:checked");

	        if (selectedBoards.length !== 1) {
	            alert("수정할 게시글을 하나만 선택하세요.");
	            return;
	        }

	        var boardNo = selectedBoards.data("board-no");
	        var categoryNo = selectedBoards.data("category-no");

	       
	        $("#board_no").val(boardNo);
	        $("#category_no").val(categoryNo);
	        form.attr("action", "/myct/board/modify");
	        form.submit();
	    }

	    

		$(".pageInfo a").on("click", function(e) {

			e.preventDefault();
			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			moveForm.attr("action", "/myct/board/boardInfo");
			moveForm.submit();

		});
		

	    $(".search_area button").on("click", function(e){
	        e.preventDefault();
	        
	        let type = $(".search_area select").val();
	        let keyword = $(".search_area input[name='keyword']").val();
	        
	        if(!type){
	            alert("검색 종류를 선택하세요.");
	            return false;
	        }
	        
	        if(!keyword){
	            alert("키워드를 입력하세요.");
	            return false;
	        }        
	        
	        moveForm.find("input[name='type']").val(type);
	        moveForm.find("input[name='keyword']").val(keyword);
	        moveForm.find("input[name='pageNum']").val(1);
	        moveForm.submit();
	    });


	</script>
</body>
</html>