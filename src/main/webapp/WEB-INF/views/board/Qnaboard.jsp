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
.container {
	width: 100%; /* 컨테이너의 너비를 100%로 설정 */
	max-width: 1200px; /* 최대 너비를 600px로 설정하여 요소들의 너비를 줄임 */
	margin: 50px auto; /* 상하 마진을 0으로, 좌우 마진을 auto로 설정하여 중앙 정렬 */
	padding: 20px; /* 내부 여백 */
	box-sizing: border-box; /* padding을 포함한 너비로 계산 */
}

.board-title {
	font-size: 2.4rem;
	font-weight: 700;
	margin-bottom: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

th, td {
    border: 1px solid #e1e1e1;
    padding: 12px 15px;
    text-align:center;
    font-size: 1.2rem;
}

th {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
    
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

/* Zebra striping for rows */
tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
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
    text-align: right;
    margin: 20px 0;
}

.write-button {
    background-color: #4CAF50;
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1.2rem;
    transition: background-color 0.3s, box-shadow 0.3s;
    text-decoration: none; /* In case it's an anchor tag */
    display: inline-block; /* For proper alignment */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
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
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="board-title">문의게시판</div>
			
			<!-- 글쓰기 버튼 추가 -->
			<div class="write-btn-container">
			 <c:if test="${!empty loginInfo}">
				<a href="write" class="write-button">게시판 등록</a>
				</c:if>
			</div>

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page}" var="vo">
					  <c:if test="${vo.category_no == 3}">
						<tr>
							<td><c:out value="${vo.board_no}"/></td>
							<td class="title-column">
								
                <a href="javascript:void(0);" onclick="goToDetail(${vo.board_no});">
									<c:out value="${vo.board_title}" />
									
									<c:if test="${vo.hasReply}">
											<span style="color: #ff3d71;">[답변완료]</span>
										</c:if>
								</a> 
							</td>
								<td><c:out value="${vo.member_nickname}" /></td>

								<td><fmt:formatDate pattern="yyyy/MM/dd" value="${vo.board_rdate}" /></td>
							
							<td><c:if test="${vo.file_name != null}">
										<a href="/myct/board/download?fileNo=${vo.file_no}">
										 <img src="/img/ico_star_on.png" alt="첨부파일">
										</a>
									</c:if></td>					
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
					reutrn;
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