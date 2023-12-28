<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 QnA 관리</title>
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

th {
	background-color: #f2f2f2;
}

.title-column {
    text-align: left;
}

td {
   /*  background-color: #ffffff; */
    color: #333;
}

/* Hover effect for table rows */
tr:hover {
    background-color: #f5f5f5;
}

/* Table header style */
thead tr {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

.write-btn-container {
    text-align: right;
    margin: 20px 0;
}

.write-button {
     background: linear-gradient(to right, rgb(230, 30, 77) 0%, rgb(227, 28, 95) 50%, rgb(215, 4, 102) 100%);
                    color: #fff;
                
    color: white;
    padding: 14px 24px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.2rem;
    transition: box-shadow 0.2s ease 0s, -ms-transform 0.1s ease 0s, -webkit-transform 0.1s ease 0s, transform 0.1s ease 0s;	
    text-decoration: none; /* In case it's an anchor tag */
    display: inline-block; /* For proper alignment */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
     outline: none;
       line-height: 20px;
                    font-weight: 600;
}

.write-button:hover, .write-button:focus {
    background-color: #45a049;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.write-button:active {
    background-color: #3d8b40;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}



  .pageInfo{
      list-style : none;
      display: inline-block;
    margin: 50px 0 0 100px;      
  }
  .pageInfo li{
      float: left;
    font-size: 20px;
    margin-left: 18px;	
    padding: 7px;
    font-weight: 500;
  }
 a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: underline;}
   .active{
      background-color: #cdd5ec;
  }
  
  .search_area{
    display: inline-block;
    margin-top: 30px;
    margin-left: 0px;
  }
  .search_area input{
      height: 30px;
    width: 250px;
  }
  .search_area button{
     width: 100px;
    height: 36px;
    background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	font-size: 1.3rem; /* 버튼 글씨 크기 조정 */
  }
  
  .search_area select {
  	height: 35px;
  }
  
   .delete-btn, .write-btn, .reply-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
  }
  .delete-btn{
    background-color: #f44336;
  }
  
  .reply-btn {
   background-color: #60A5FA;
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
    	<div class="board-title">관리자 문의게시판</div>
			
	
			<div class="write-btn-container">
			 <c:if test="${!empty loginInfo}">
				<a href="write" class="write-button">게시글 등록</a>
				</c:if>
			</div>

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page}" var="vo">
					  <c:if test="${vo.category_no == 3}">
						<tr id="row-${vo.board_no}" data-category-no="${vo.category_no}">
							<td><c:out value="${vo.board_no}"/></td>
							<td class="title-column">
								
                <a href="javascript:void(0);" onclick="goToDetail(${vo.board_no});">
									<c:out value="${vo.board_title}" />
									<c:if test="${vo.hasReply}">
											<span style="color: green;" >[답변완료]</span>
										</c:if> 
								
								</a> 
							</td>
								<td><c:out value="${vo.member_nickname}" /></td>

								<td><fmt:formatDate pattern="yyyy/MM/dd" value="${vo.board_rdate}" /></td>
							
							<td>
									<div class="btn_wrap">
										 <button class="reply-btn" data-board-no="${vo.board_no}"
                                        onclick="goToQnaDetail(${vo.board_no})">답변</button>

										<button class="delete-btn" onclick="deleteBoard(${vo.board_no})">삭제</button>
									</div>
								</td>	
									
											
						</tr>
						
            <c:if test="${board.hasReply}">
                <tr>
                    <td colspan="5" style="text-align:center;">답글 등록됨</td>
                </tr>
            </c:if>
						</c:if>
					</c:forEach>

					
				</tbody>
			</table>
			
			<form action="${pageContext.request.contextPath}/board/qna" method="get">
    <div class="search-box">
        <!-- Ensure the input field has the name 'searchKeyword' -->
        <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하세요"/>
        <button type="submit">검색🔍</button>
    </div>
</form>
			
				<div class="pagination">
    <c:if test="${pageMaker.prev}"> <!-- 이전 페이지 그룹이 있는 경우 -->
        <a href="?page=${pageMaker.startPage - 1}">이전</a>
    </c:if>
    
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
        <a href="?page=${pageNum}" class="${pageNum eq pageMaker.cri.page ? 'active' : ''}">${pageNum}</a>
    </c:forEach>
    
    <c:if test="${pageMaker.next}"> <!-- 다음 페이지 그룹이 있는 경우 -->
        <a href="?page=${pageMaker.endPage + 1}">다음</a>
    </c:if>
</div>
			
			<form id="infoForm" action="/board/modify" method="get">
			<input type="hidden" id="board_no" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
			<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
		</form>

			
    </div>
    	</div>
    	
    	<script>
    	let form = $("#infoForm"); 
		let mForm = $("#modifyForm"); 

		
	    function deleteBoard(boardNo) {
	    	 console.log("deleteBoard called with boardNo: " + boardNo);
	        if(confirm("게시글을 삭제하시겠습니까?")) {
	          
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
		
	    function goToQnaDetail(boardNo) {
            location.href = '/myct/board/Qnadetail?board_no=' + boardNo;
        }
    	</script>
</body>
</html>