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
    font-family: 'Arial', sans-serif;
  
    color: #333;
    margin: 0;
    padding: 0;
}

.container {
    width: 100%;
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    background: #ffffff; /* White background for container */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Input Wrapper */
.input_wrap {
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    background-color: #f9f9f9; /* Light gray background for inputs */
    padding: 10px;
    border-radius: 4px;
}

.input_wrap label {
    width: 20%;
    min-width: 130px;
    font-size: 18px;
    color: #333; /* Dark color for text */
}

.input_wrap input,
.input_wrap textarea {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    color: #555; /* Slightly lighter color for input text */
    background-color: #ffffff; /* White background for text area */
}

textarea {
    height: 200px;
    resize: vertical;
}

/* Button Styles */
.btn_wrap {
    text-align: center;
    margin-top: 20px;
}

.btn {
    padding: 10px 15px;
    font-size: 16px;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
    text-decoration: none; /* Removes underline from links */
    transition: background-color 0.2s;
}

#list_btn {
    background-color: #007bff;
}

#modify_btn {
    background-color: #28a745;
}

#delete_btn {
    background-color: #dc3545;
}

#cancel_btn {
    background-color: #6c757d;
}

.btn:hover {
    opacity: 0.9; /* Slight transition for hover effect */
}

@media (max-width: 768px) {
    .container {
        width: 90%;
    }

    .input_wrap label {
        width: 100%; /* Full width on small screens */
    }

    .input_wrap input,
    .input_wrap textarea {
        width: 100%;
    }
}


</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">

			<form id="modifyForm" action="/myct/board/modify" method="post">
			
				<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>	
				
				<input type="hidden" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
				
					
				<div class="input_wrap">
            <label for="board_title">게시판 제목</label>
            <input id="board_title" name="board_title" value='<c:out value="${pageInfo.board_title}"/>'>
        </div>
        <div class="input_wrap">
            <label for="board_content">게시판 내용</label>
            <textarea id="board_content" rows="3" name="board_content"><c:out value="${pageInfo.board_content}"/></textarea>
        </div>
        <div class="btn_wrap">
            <a class="btn" id="list_btn">목록 페이지</a>
            <a class="btn" id="modify_btn">수정 완료</a>
            <a class="btn" id="delete_btn">삭제</a>
      		<a class="btn" id="cancel_btn">수정 취소</a>
					
        </div>
				
			</form>
			<form id="infoForm" action="/myct/board/modify" method="get">
				<input type="hidden" id="board_no" name="board_no"
					value='<c:out value="${pageInfo.board_no}"/>'>
					<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
				
			</form>
			
			<form id="cancleForm" action="/myct/board/cancle" method="get">
							
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
	                actionUrl = "/myct/board/noticeboard"; 
	                break;
	            case "2":
	                actionUrl = "/myct/board/freeboard"; 
	                break;
	            case "3":
	                actionUrl = "/myct/board/qnaboard"; 
	                break;
	          
	            default:
	                actionUrl = "/myct/board/freeboard"; 
	                break;
	        }

	        form.attr("action", actionUrl);
	        form.submit();
	    });

	    /* 수정 완료 버튼 */
	    $("#modify_btn").on("click", function(e) {
	       
	        mForm.submit();  // 수정 폼 제출
	    });

		/* 취소 버튼 */
		$("#cancel_btn").on("click", function(e) {
		    e.preventDefault(); 

		    let boardNo = $("#cancleForm").find("input[name='board_no']").val();
		    let categoryNo = $("#cancleForm").find("input[name='category_no']").val();

		  
		    let actionUrl;
		    switch (categoryNo) {
		        case "1":
		            actionUrl = `/myct/board/Qnadetail?board_no=${boardNo}`; 
		            break;
		        case "2":
		            actionUrl = `/myct/board/freedetail?board_no=${boardNo}`; 
		            break;
		        case "3":
		            actionUrl = `/myct/board/Qnadetail?board_no=${boardNo}`; 
		            break;
		        default:
		            actionUrl = `/myct/board/freedetail?board_no=${boardNo}`; 
		            break;
		    }

		    cForm.attr("action", actionUrl);
		    cForm.submit();
		});

		
		 /* 삭제 버튼 */
	    $("#delete_btn").on("click", function(e){	
	        form.attr("action", "/myct/board/delete");
	        form.attr("method", "post");
	        form.submit();
	    });
	</script>
</body>
</html>