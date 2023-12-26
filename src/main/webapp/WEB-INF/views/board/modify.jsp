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
    background-color: #f5f5f5; /* Lighter background for overall page */
    margin: 0;
    padding: 0;
    color: #333;
}

.container {
    width: 100%;
    max-width: 800px;
    margin: 40px auto;
    padding: 40px;
    box-sizing: border-box;
    background: #ffffff; /* White background for container */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
}

/* Input Wraps */
.input_wrap {
    display: flex;
    align-items: center; /* Align items vertically */
    margin-bottom: 20px; /* Added spacing between input fields */
    gap: 10px; /* Space between label and input */
}

label {
    flex: 0 0 130px; /* Adjust the width of the label */
    margin: 0;
    font-size: 18px;
    color: #333;
}

input, textarea {
    flex: 1; /* Input takes up the remaining space */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

textarea {
    height: 150px; /* Adjusted for better space */
}

/* Button Styles */
.btn_wrap {
    display: flex; /* Align buttons in a row */
    align-items: center;
    margin-top: 30px; 
    gap: 10px; /* Space between buttons */
}

/* ...rest of your button styles... */


/* Buttons */
.btn {
    font-size: 16px;
    padding: 10px 20px; /* More padding for a larger clickable area */
    background-color: #007bff; /* Primary color for buttons */
    color: white; /* Text color */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.2s; /* Smooth transition for hover effect */
    margin-right: 10px; /* Spacing between buttons */
}

.btn:hover {
    background-color: #0056b3; /* Darker shade for hover state */
}

#delete_btn {
    background-color: #f44336; /* Red color for delete action */
}

#delete_btn:hover {
    background-color: #d32f2f; /* Slightly darker red for hover state */
}

/* Button Wrapper */
.btn_wrap {
    margin-top: 30px; /* More top margin for spacing */
    padding-left: 0; /* Align buttons with form fields */
}

/* 추가적인 스타일링이 필요한 경우 여기에 작성 */
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