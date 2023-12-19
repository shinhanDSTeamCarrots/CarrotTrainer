	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script src="js/script.js"></script>

</head>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4; /* Light grey background */
    margin: 0;
    padding: 0;
}

.container {
    width: 100%;
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    background-color: #ffffff; /* White background */
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.input_wrap {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-size: 16px;
    color: #333333; /* Dark grey for text */
}

input, textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #dddddd;
    border-radius: 4px;
    box-sizing: border-box;
}

textarea {
    height: 150px;
    resize: vertical; /* Allows resizing vertically */
}

.btn_wrap {
    text-align: right;
    margin-top: 30px;
}

.btn {
    background-color: #4CAF50;
    color: white;
    padding: 10px 15px;
    text-decoration: none; /* If the button is a link */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #45a049;
}

/* Comment Section Styles */
.comment-section {
    margin-top: 40px;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* Comment Submission Button */
.comment-submit {
    background-color: #4CAF50; /* Primary color */
    color: white; /* Text color */
    border: none; /* Removes border */
    padding: 10px 15px; /* Vertical and horizontal padding */
    font-size: 16px; /* Text size */
    border-radius: 4px; /* Rounded corners */
    cursor: pointer; /* Cursor changes to indicate clickable */
    display: block; /* Makes the button a block element */
    width: 100%; /* Full width */
    margin-top: 10px; /* Spacing above the button */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    transition: background-color 0.3s; /* Smooth transition for hover effect */
}

.comment-submit:hover {
    background-color: #369456; /* Slightly darker shade on hover */
}

/* Comment List */
.comment-list {
    list-style-type: none; /* Removes default list styling */
    padding: 0; /* Resets padding */
    margin-top: 20px; /* Space above the list */
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.comment-list li {
    background: #f9f9f9; /* Slightly off-white background for each comment */
    padding: 15px; /* Padding inside each comment box */
    border-radius: 6px; /* Rounded corners for comment boxes */
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05); /* Subtle shadow for depth */
    border-left: 4px solid #4CAF50; /* Accent border on the left */
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.comment-author, .comment, .comment-date {
    margin: 0; /* Resets margin for p elements */
}

.comment-author {
    font-weight: bold;
    color: #333; /* Dark color for emphasis */
    font-size: 16px;
}

.comment {
    color: #555; /* Standard text color */
    font-size: 14px;
}

.comment-date {
    font-size: 12px;
    color: #777; /* Subdued color for date */
    align-self: flex-end; /* Align date to the right */
}


</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
		 <div class="input_wrap">
		<label>게시판 카테고리</label>
		<c:choose>
			<c:when test="${pageInfo.category_no == 1 }">
				<input name="category_no" readonly="readonly" value="공지사항">
			</c:when>
			<c:when test="${pageInfo.category_no == 2 }">
				<input name="category_no" readonly="readonly" value="자유게시판">
			</c:when>
			<c:when test="${pageInfo.category_no == 3 }">
				<input name="category_no" readonly="readonly" value="문의게시판">
			</c:when>
		</c:choose>
	</div> 
			<div class="input_wrap">
		<label>게시판 번호</label>
		<input name="board_no" readonly="readonly" value='<c:out value="${pageInfo.board_no}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 제목</label>
		<input name="board_title" readonly="readonly" value='<c:out value="${pageInfo.board_title}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 내용</label>
		<textarea rows="3" name="board_content" readonly="readonly"><c:out value="${pageInfo.board_content}"/></textarea>
	</div>
	
	
	
		
	<div class="btn_wrap">
		 <a class="btn" id="list_btn">조회 페이지</a> 
		<a class="btn" id="modify_btn">수정 하기</a>
		<a class="btn" id="reply_btn" href="<c:url value='/board/qnareply.do?board_title=${pageInfo.board_title}' />">답변</a>
	</div>
	
	 <!-- 댓글 섹션 시작 -->
            <div class="comment-section">
               

				<c:if test="${!empty loginInfo}">
					<!-- 로그인한 사용자에게만 답글 입력 영역 표시 -->
					<div class="reply-input-area">
						<textarea class="comment-input" rows="3"
							placeholder="댓글을 입력하세요..."></textarea>
						<button class="comment-submit">댓글 등록</button>
					</div>
				</c:if>

				<%-- 댓글 목록 --%>
				<ul class="comment-list">
					<c:if test="${!empty replyList}">
						<c:forEach items="${replyList}" var="reply">
							<div class="reply">
								<p>
									작성자:
									<c:out value="${reply.member_no}" />
								</p>
								<p>
									내용:
									<c:out value="${reply.reply_content}" />
								</p>
								<p>
									작성일:
									<fmt:formatDate value="${reply.reply_rdate}"
										pattern="yyyy-MM-dd HH:mm:ss" />
								</p>
							</div>
						</c:forEach>
					</c:if>

				</ul>
			</div>
            <!-- 댓글 섹션 끝 -->
        </div>

	<form id="infoForm" action="/board/modify" method="get">
		<input type="hidden" id="board_no" name="board_no" value='<c:out value="${pageInfo.board_no}"/>'>
		<input type="hidden" id="category_no" name="category_no" value='<c:out value="${pageInfo.category_no}"/>'>
	</form>	
	
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	
	<script>
	let form = $("#infoForm");

	$("#list_btn").on("click", function(e) {
	    e.preventDefault(); // 기본 이벤트 방지

	    let categoryNo = $("#category_no").val(); // category_no 값을 가져옴
	    let actionUrl;

	    // category_no에 따라 URL 설정
	    switch (categoryNo) {
	        case "1":
	            actionUrl = "/myct/board/noticeboard.do"; // 공지사항 게시판 URL
	            break;
	        case "2":
	            actionUrl = "/myct/board/freeboard.do"; // 자유게시판 URL
	            break;
	        case "3":
	            actionUrl = "/myct/board/qnaboard.do"; // 문의게시판 URL
	            break;
	        default:
	            actionUrl = "/myct/board/freeboard.do"; // 기본값으로 자유게시판 URL 설정
	            break;
	    }

	    form.attr("action", actionUrl);
	    form.submit();	
	});

	
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/myct/board/modify.do");
		form.submit();
	});	
	
	
	
	// AJAX를 사용하여 특정 게시글의 댓글 목록을 불러오는 함수
	function loadComments(boardNo) {
	    $.ajax({
	        url: "/myct/board/getReplies.do", // Controller URL to get replies
	        type: "GET",
	        data: { board_no: boardNo },
	        success: function(replies) {
	            var commentsHtml = '';
	            $.each(replies, function(index, reply) {
	                commentsHtml += '<li class="reply">' +
	                                 '<p class="comment-author">작성자: ' + reply.member_no + '</p>' +
	                                 '<p class="comment">' + reply.reply_content + '</p>' +
	                                 '<p class="comment-date">' + reply.reply_rdate + '</p>' +
	                                 '</li>';
	            });
	            $(".comment-list").html(commentsHtml);
	        },
	        error: function(xhr, status, error) {
	            alert("댓글 실패");
	        }
	    });
	}

	$(document).ready(function() {
	    // 특정 게시글을 클릭할 때 댓글 목록을 불러오기
	    $(".move").click(function(e) {
	        e.preventDefault();
	        var boardNo = $(this).attr("href");
	        loadComments(boardNo);
	    });

	    // 댓글 등록 로직
	    $(".comment-submit").click(function() {
	        var boardNo = $("#board_no").val(); // 게시글 번호
	        var commentContent = $(".comment-input").val(); // 댓글 내용
	        var data = {
	            board_no: boardNo, // 'board_no' 필드에 매핑
	            reply_content: commentContent // 'reply_content' 필드에 매핑
	        };

	        $.ajax({
	            url: "/myct/board/insertReply.do", // Controller URL
	            type: "POST",
	            data: data,
	            success: function(response) {
	                if(response === "success") {
	                    alert("댓글이 등록되었습니다.");
	                   /*  window.location.href = "/myct/board/qnaboard.do"; */ // 성공 시 Qnaboard로 리디렉션
	                   location.reload(); // 현재 페이지 새로고침
	                } else {
	                    alert("댓글 실패");
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("댓글 실패");
	            }
	        });
	    });
	});




</script>
</body>
</html>