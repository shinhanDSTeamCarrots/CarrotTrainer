<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- fmt 태그를 통해서 '년도/월/일' 형식으로 출력 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>문의게시판</title>
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
 
}

.container {
  max-width: 1200px;
  margin: 50px auto;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.board-title {
  font-size: 2.4rem;
  color: #748E63;
  margin-bottom: 20px;
  font-weight: bold;
}

table {
  width: 100%; 
  border-collapse: collapse;
  margin-top: 20px;
}

th, td {
  padding: 10px; 
  text-align: center;
  border-bottom: 1px solid #ddd;
  font-size: 1.4rem; 
}

.title-column {
    text-align: left;
  
}

th {
  background-color: #f9b572;
  color: white;
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
}


  .pageInfo{
      list-style : none;
      display: inline-block;
    margin: 50px 0 0 400px;      
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
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="board-title">문의게시판💭</div>
			
			<!-- 글쓰기 버튼 추가 -->
			<div class="write-btn-container">
			 <c:if test="${!empty loginInfo}">
				<a href="write?category_no=3" class="write-button">게시글 등록</a>
				</c:if>
			</div>

			<table>
				<thead>
					<tr>
					
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page}" var="vo">
						<c:if test="${vo.category_no == 3}">
							<tr>

								<td class="title-column">
								
								<c:choose>
									<c:when test="${list.board_private == 1}">
										<a href="javascript:void(0);"
											onclick="alert('비공개 처리 되었습니다.');location.href='/myct/board/Qnadetail?board_no=${list.board_no}'">
											[비공개 처리 되었습니다.] </a>
									</c:when>

									<c:otherwise>
										<a href="/myct/board/Qnadetail?board_no=${list.board_no}">
											<c:out value="${list.board_title}" />
										</a>
									</c:otherwise>
								</c:choose>
								
								<a href="javascript:void(0);" onclick="goToDetail(${vo.board_no});"> 
								<c:out value="${vo.board_title}" />
										 <c:if test="${vo.hasReply}">
											<span style="color: #ff3d71;">[답변완료]</span>
										</c:if>
								</a>
								
								</td>
								
								
								<td><c:out value="${vo.member_nickname}" /></td>

								<td><fmt:formatDate pattern="yyyy/MM/dd"
										value="${vo.board_rdate}" /></td>
								<td><c:out value="${vo.board_view}" /></td>
								<td><c:if test="${vo.file_name != null}">
										<a href="/myct/board/download?fileNo=${vo.file_no}"> <img
											src="/myct/img/ico_star_on.png" alt="첨부파일">
										</a>
									</c:if></td>
							</tr>

							<c:if test="${board.hasReply}">
								<tr>
									<td colspan="5" style="text-align: center;">답글 등록됨</td>
								</tr>
							</c:if>
						</c:if>
					</c:forEach>


				</tbody>
			</table>


<form action="${pageContext.request.contextPath}/board/qnaboard" method="get">
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
			<form id="moveForm" method="get">
			
			</form>

		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

	<script>
		$(document).ready(function() {

			let result = '<c:out value="${result}"/>';

			checkAlert(result);

			function checkAlert(result) {

				if (result === '') {
					return;
				}

				if (result === "enrol success") {
					alert("등록이 완료되었습니다.");
				}

				if (result === "modify success") {
					alert("수정이 완료되었습니다.");
				}

				if (result === "delete success") {
					alert("삭제가 완료되었습니다.");
				}
			}

		});


		function goToDetail(boardNo) {
	        location.href = '/myct/board/Qnadetail?board_no=' + boardNo;
	    }			    

		$(".pageInfo a").on("click", function(e) {

			e.preventDefault();
			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			moveForm.attr("action", "/myct/board/qnaboard");
			moveForm.submit();
		});
		

	</script>
</body>
</html>