<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
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
        margin-top: 10px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        font-size: 1.2rem;
    }
	
	.title-column {
    text-align: left;
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
			<div class="board-title">공지사항</div>
			
			<!-- 글쓰기 버튼 추가 -->
			<div class="write-btn-container">
			 <c:if test="${!empty loginInfo}">
				<a href="write.do" class="write-button">게시판 등록</a>
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
					  <c:if test="${vo.category_no == 1}">
						<tr>
							<td><c:out value="${vo.board_no}"/></td>
							<td class="title-column">
							
                <a href="javascript:void(0);" onclick="goToDetail(${vo.board_no});">
									<c:out value="${vo.board_title}" />
									
									<c:if test="${vo.hasReply}">
											<span style="color: green;">답변완료</span>
										</c:if>
								</a> 
								</td>
								<td><c:out value="${vo.member_nickname}" /></td>

								<td><fmt:formatDate pattern="yyyy/MM/dd" value="${vo.board_rdate}" /></td>
							
							<td><c:if test="${vo.file_name != null}">
										<a href="/myct/board/download.do?fileNo=${vo.file_no}">
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
	        location.href = '/myct/board/Qnadetail.do?board_no=' + boardNo;
	    }			    

		$(".pageInfo a").on("click", function(e) {

			e.preventDefault();
			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			moveForm.attr("action", "/myct/board/qnaboard.do");
			moveForm.submit();
		});
		

	</script>
</body>
</html>