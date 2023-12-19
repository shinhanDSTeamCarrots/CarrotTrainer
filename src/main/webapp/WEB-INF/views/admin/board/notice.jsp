<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>자유게시판</title>
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
  .notice-table {
    margin: 20px auto;
    width: 60%;
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
  .delete-btn, .write-btn {
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
  
  
  .buttons {
    text-align: right;
    margin-bottom: 10px;
  }
  th:nth-child(1), td:nth-child(1), th:nth-child(3), td:nth-child(3) {
    text-align: center;
  }
  
  
</style>
<script>
function deleteRow(btn) {
  // 해당 버튼이 속한 행을 찾아서 삭제
  var row = btn.parentElement.parentElement;
  row.remove();
}

</script>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    	<div class="notice-table">
  <div class="buttons">
    <button class="write-btn" onclick="writeNotice()">
   		 <a href="write.do" class="write-button">게시판 등록</a>
    </button>
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
						<c:if test="${vo.category_no == 1}">
							<tr>
								<td><c:out value="${vo.board_no}" /></td>
								<td>
									<!-- 링크 수정: JavaScript 함수 호출 --> <a href="javascript:void(0);"
									onclick="goToDetail(${vo.board_no});"> <c:out
											value="${vo.board_title}" /> <c:if test="${vo.hasReply}">
											<span style="color: green;">답변완료</span>
										</c:if>
								</a>
								</td>
								<td><c:out value="${vo.member_nickname}" /></td>

								<td><fmt:formatDate pattern="yyyy/MM/dd"
										value="${vo.board_rdate}" /></td>

								<td>
									<div class="btn_wrap">
										 <button class="delete-btn" id="modify_btn" onclick="deleteRow(this)">수정</button>
									     <button class="delete-btn" id="delete_btn" onclick="deleteBoard(${vo.board_no})">삭제</button>
									</div>
								</td>


							</tr>

							<c:if test="${board.hasReply}">
								<tr>
									<td colspan="5" style="text-align: center;">답글 등록됨</td>
								</tr>
							</c:if>
						</c:if>
					</c:forEach>

					<!-- 추가 게시물 행을 여기에 추가 -->
				</tbody>
			</table>
		</div>

		<form id="infoForm" action="/board/modify" method="get">
			<input type="hidden" id="board_no" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
			<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
		</form>
		
		
 	</div>

<script>
		let form = $("#infoForm"); // 페이지 이동 form(리스트 페이지 이동, 조회 페이지 이동)
		let mForm = $("#modifyForm"); // 페이지 데이터 수정 from

		

		$("#modify_btn").on("click", function(e){
			form.attr("action", "/myct/board/modify.do");
			form.submit();
		});	
	
	
	    /* $("#delete_btn").on("click", function(e){	
	        form.attr("action", "/myct/board/delete.do");
	        form.attr("method", "post");
	        form.submit();
	    });
	    
	    
	    
	    function deleteBoard(boardNo) {
	    	if(confirm("게시글을 삭제하시겠습니까?") {
	    		$.ajax({
	    			url: 'myct/board/delete.do',
	    			type: 'POST',
	    			data: {board_no: boardNo},
	    			success: function(response) {
	    				if(response === 'success') {
	    					alert("게시글 삭제되었습니다.");
	    					$("#row-" + boardNo).remove();
	    				} else {
	    				alert("게시글 삭제에 실패했습니다.");
	    			}
	    		},
	    		
	    		error: function() {
	    			alert("게시글 삭제 중 오류 발생"');
	    		  }
	    		});
	    	}
	    } 
	</script>
</body>
</html>