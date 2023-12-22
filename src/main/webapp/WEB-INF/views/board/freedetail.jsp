
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
	width: 600px;
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

/* 댓글 섹션 스타일링 */
.comment-section {
	margin-top: 40px;
	background: #f7f7f7;
	border: 1px solid #e1e1e1;
	border-radius: 4px;
	padding: 20px;
}

.comment-input {
	width: calc(100% - 20px);
	border: 1px solid #ccc;
	border-radius: 4px;
	padding: 10px;
	margin-bottom: 10px;
	resize: none;
}

.comment-submit {
	width: 100%;
	padding: 10px 0;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

.comment-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.comment-list li {
	background: white;
	border-bottom: 1px solid #e1e1e1;
	padding: 10px;
	border-radius: 4px;
	margin-top: 8px;
}

.comment {
	color: #555;
	font-size: 14px;
	line-height: 1.5;
}

.comment-author {
	font-weight: bold;
	color: #000;
	margin-bottom: 5px;
}

.comment-date {
	font-size: 12px;
	color: #999;
	margin-top: 10px;
}

/* 추가적인 스타일링이 필요한 경우 여기에 작성 */
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
				<label>게시판 번호</label> <input name="board_no" readonly="readonly"
					value='<c:out value="${pageInfo.board_no}"/>'>
			</div>
			<div class="input_wrap">
				<label>게시판 제목</label> <input name="board_title" readonly="readonly"
					value='<c:out value="${pageInfo.board_title}"/>'>
			</div>
			<%-- <div class="input_wrap">
		<label>추천수</label>
		<input name="board_recom" readonly="readonly" value='<c:out value="${pageInfo.hit_count}"/>' >
	</div> --%>
			<div class="input_wrap">
				<label>게시판 내용</label>
				<textarea rows="3" name="board_content" readonly="readonly"><c:out
						value="${pageInfo.board_content}" /></textarea>
			</div>




			<div class="btn_wrap">
				<a class="btn" id="list_btn">조회 페이지</a> <a class="btn"
					id="modify_btn">수정 하기</a> <a class="btn" id="reply_btn"
					href="<c:url value='/board/qnareply.do?board_title=${pageInfo.board_title}' />">답변</a>
				<a class="btn" id="recom_btn" href="javascript:void(0);"
					onclick="RecomCount(${list.board_no});">추천</a>
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
			<input type="hidden" id="board_no" name="board_no"
				value='<c:out value="${pageInfo.board_no}"/>'> <input
				type="hidden" id="category_no" name="category_no"
				value='<c:out value="${pageInfo.category_no}"/>'> <input
				type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
			<input type="hidden" name="amount"
				value='<c:out value="${cri.amount}"/>'> <input type="hidden"
				name="type" value="${cri.type }"> <input type="hidden"
				name="keyword" value="${cri.keyword }">
		</form>

	</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
	let form = $("#infoForm");

	$("#list_btn").on("click", function(e) {
	    e.preventDefault(); 

	    let categoryNo = $("#category_no").val(); 
	    let actionUrl;

	    // category_no에 따라 URL 설정
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

	
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/myct/board/modify.do");
		form.submit();
	});	
	
	// 추천수 메서드 호출
	function RecomCount(boardNO) {
	       $.ajax({
	            url: '/myct/board/updateRecomCount',
	            type: 'POST',
	            data: { board_no: boardNo },
	            success: function(response) {
	            	
	                if(response === 'success') {
	                	 alert("추천이 완료되었습니다.");
	                	 location.reload();  
	                } else {
	                    alert('조회수 증가에 실패했습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("Error incrementing view count");

	            }
	        });
	    
	}
	
	// AJAX를 사용하여 특정 게시글의 댓글 목록을 불러오는 함수
	function loadComments(boardNo) {
	    $.ajax({
	        url: "/myct/board/getReplies.do", 
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
	            alert("댓글을 불러오는 데 실패했습니다.");
	        }
	    });
	}

	$(document).ready(function() {
	  
	    $(".move").click(function(e) {
	        e.preventDefault();
	        var boardNo = $(this).attr("href");
	        loadComments(boardNo);
	    });

	  
	    $(".comment-submit").click(function() {
	        var boardNo = $("#board_no").val(); 
	        var commentContent = $(".comment-input").val(); 
	        var data = {
	            board_no: boardNo, 
	            reply_content: commentContent 
	        };

	        $.ajax({
	            url: "/myct/board/insertReply.do", 
	            type: "POST",
	            data: data,
	            success: function(response) {
	                if(response === "success") {
	                    alert("댓글이 등록되었습니다.");
	                   
	                    location.reload();  
	                } else {
	                    alert("댓글 등록에 실패했습니다.");
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("댓글 등록에 실패했습니다.");
	            }
	        });
	    });
	});


</script>
</body>
</html>