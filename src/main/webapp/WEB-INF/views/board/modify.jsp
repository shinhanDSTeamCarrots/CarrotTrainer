<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글읽기</title>
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
	font-family: Arial, sans-serif;
}

.container {
	width: 100%;
	max-width: 800px; /* 컨테이너 너비 증가 */
	margin: 60px auto; /* 상하 여백 증가 */
	padding: 40px; /* 내부 패딩 증가 */
	box-sizing: border-box;
	background: #f9f9f9; /* 배경색 추가 */
	border-radius: 10px; /* 테두리 둥글게 */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
}

.input_wrap {
	padding: 5px 20px;
}

label {
	display: block;
	margin: 10px 0;
	font-size: 20px;
}

input {
	padding: 5px;
	font-size: 17px;
}

textarea {
	width: 800px;
	height: 200px;
	font-size: 15px;
	padding: 10px;
}

.btn {
	display: inline-block;
	font-size: 20px;
	padding: 6px 12px;
	background-color: #fff;
	border: 1px solid #ddd;
	font-weight: 600;
	width: 140px;
	height: 41px;
	line-height: 39px;
	text-align: center;
	margin-left: 30px;
	cursor: pointer;
}

.btn_wrap {
	padding-left: 80px;
	margin-top: 50px;
}

#delete_btn{
    background-color: #f3e3e7;
}

/* 추가적인 스타일링이 필요한 경우 여기에 작성 */
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">

			<form id="modifyForm" action="/myct/board/modify.do" method="post">
			
				<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>	
					
				<div class="input_wrap">
					<label>게시판 번호</label> <input name="board_no" readonly="readonly"
						value='<c:out value="${pageInfo.board_no}"/>'>
				</div>
				<div class="input_wrap">
					<label>게시판 제목</label> <input name="board_title"
						value='<c:out value="${pageInfo.board_title}"/>'>
				</div>
				<div class="input_wrap">
					<label>게시판 내용</label>
					<textarea rows="3" name="board_content"><c:out
							value="${pageInfo.board_content}" /></textarea>
				</div>

				<div class="btn_wrap">
					<a class="btn" id="list_btn">목록 페이지</a>
					 <a class="btn" id="modify_btn">수정 완료</a>
					  <a class="btn" id="delete_btn">삭제</a> 
					
				</div>
				
			</form>
			<form id="infoForm" action="/myct/board/modify.do" method="get">
				<input type="hidden" id="board_no" name="board_no"
					value='<c:out value="${pageInfo.board_no}"/>'>
					<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
				
			</form>
			
			<form id="cancleForm" action="/myct/board/cancle.do" method="get">
							<div class="btn_wrap">
						 <a class="btn" id="cancel_btn">수정 취소</a>
						 </div>
					<input type="hidden" id="board_no" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
					<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
			</form>
			
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		let form = $("#infoForm");
		let mForm = $("#modifyForm"); 
		let cForm = $("#cancleForm");

		
	    $("#list_btn").on("click", function(e) {
	        e.preventDefault(); 

	      
	        let categoryNo = $("#category_no").val();

	       
	        let actionUrl;
	        switch (categoryNo) {
	            case "1":
	                actionUrl = "/myct/board/noticeboard.do"; 
	                break;
	            case "2":
	                actionUrl = "/myct/board/freeboard.do"; 
	                break;
	            case "3":
	                actionUrl = "/myct/board/qnaboard.do"; 
	                break;
	          
	            default:
	                actionUrl = "/myct/board/freeboard.do"; 
	                break;
	        }

	        form.attr("action", actionUrl);
	        form.submit();
	    });

		/* 수정 하기 버튼 */
		$("#modify_btn").on("click", function(e) {
			
			mForm.submit();
		});

		/* 취소 버튼 */
		$("#cancel_btn").on("click", function(e) {
		    e.preventDefault(); 

		    let boardNo = $("#cancleForm").find("input[name='board_no']").val();
		    let categoryNo = $("#cancleForm").find("input[name='category_no']").val();

		  
		    let actionUrl;
		    switch (categoryNo) {
		        case "1":
		            actionUrl = `/myct/board/noticedetail.do?board_no=${boardNo}`; 
		            break;
		        case "2":
		            actionUrl = `/myct/board/freedetail.do?board_no=${boardNo}`; 
		            break;
		        case "3":
		            actionUrl = `/myct/board/Qnadetail.do?board_no=${boardNo}`; 
		            break;
		        default:
		            actionUrl = `/myct/board/freedetail.do?board_no=${boardNo}`; 
		            break;
		    }

		    cForm.attr("action", actionUrl);
		    cForm.submit();
		});

		
		 /* 삭제 버튼 */
	    $("#delete_btn").on("click", function(e){	
	        form.attr("action", "/myct/board/delete.do");
	        form.attr("method", "post");
	        form.submit();
	    });
	</script>
</body>
</html>