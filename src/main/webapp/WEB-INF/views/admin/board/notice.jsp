<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 공지사항 관리</title>
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

<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    	<div class="notice-table">
    	
    		<h1>관리자 공지사항</h1>
  <div class="buttons">
    <button class="write-btn" onclick="writeNotice()">
   		 <a href="write.do" class="write-button">게시판 등록</a>
   		
    </button>
     
   		 <button onclick="deleteSelectedBoards()" class="write-btn">선택 삭제</button>
        <button onclick="modifySelectedBoard()" class="write-btn">선택 수정</button>
  </div>
	
			<table>
				<thead>
					<tr>
						<th>선택</th>
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
							 <tr id="row-${vo.board_no}" data-category-no="${vo.category_no}">
							 
							 	<td>
                           		 <input type="checkbox" class="board-checkbox" data-board-no="${vo.board_no}" />

                      		    </td>
                      		    
								<td><c:out value="${vo.board_no}" /></td>
								<td>
									 <a href="javascript:void(0);"
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
										<button class="delete-btn" data-board-no="${vo.board_no}"
											data-category-no="${vo.category_no}"
											onclick="modifyBoard(this)">수정</button>

										<button class="delete-btn" onclick="deleteBoard(${vo.board_no})">삭제</button>
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

				
				</tbody>
			</table>
		</div>

		<form id="infoForm" action="/board/modify" method="get">
			<input type="hidden" id="board_no" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
			<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
		</form>
		
		
 	</div>

<script>
		let form = $("#infoForm");
		let mForm = $("#modifyForm"); 

		

	    
	    function modifyBoard(button) {
	       
	        var boardNo = $(button).data("board-no");
	        var categoryNo = $(button).data("category-no");

	        
	        $("#board_no").val(boardNo);
	        $("#category_no").val(categoryNo);

	        
	        form.attr("action", "/myct/board/modify.do");
	        form.submit();
	    }

	    
	    
	    function deleteBoard(boardNo) {
	        if(confirm("게시글을 삭제하시겠습니까?")) {
	           
	            var categoryNo = $("#row-" + boardNo).data("category-no");

	            $.ajax({
	                url: '/myct/board/delete.do',
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
	                url: '/myct/board/deleteSelected.do',
	                type: 'POST',
	                contentType: 'application/json', 
	                data: JSON.stringify({ board_nos: selectedBoards }), 
	                dataType: 'text',
	                success: function(response) {
	                    if(response === 'success') {
	                        alert("게시글이 삭제되었습니다.");
	                        location.reload(); 
	                    } else {
	                        alert("게시글 삭제에 실패했습니다.");
	                    }
	                },
	                error: function(xhr) {
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
	        form.attr("action", "/myct/board/modify.do");
	        form.submit();
	    }

	    



	</script>
</body>
</html>