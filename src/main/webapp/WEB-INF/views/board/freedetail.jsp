
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
    font-family: 'Roboto', Arial, sans-serif;

    margin: 0;
    padding: 0;
    color: #333;
}

.container {
    width: 100%;
    max-width: 960px;
    margin: 20px auto;
    padding: 40px;
    background: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.input_wrap {
    display: flex;
    align-items: center;
    padding: 10px 20px;
    background-color:#f9f9f9;
    border: 1px solid #e1e1e1;
    margin-bottom: 10px;
    border-radius: 4px;
    
}

.input_wrap label {
    flex: 0 0 150px; /* Adjust label width here */
    margin-right: 20px; /* Spacing between label and input */
}

.input_wrap input {
    flex: 1; /* Takes the remaining space */
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.btn_wrap {
    padding: 20px;
    background-color: #f8f8f8;
    border: 1px solid #e1e1e1;
    margin-bottom: 20px;
    border-radius: 4px;
}

label {
    display: block;
    margin-bottom: 10px;
    font-weight: 700;
    font-size: 20px;
}

input, textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

textarea {
    height: 150px;
}

.btn {
    display: inline-block;
    background-color: #609966;
    color: #ffffff;
    padding: 10px 20px;
    text-align: center;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-decoration: none;
    margin-right: 10px;

}

.btn:hover {
    background-color: #40513B;
}

.comment-section {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}

.comment-list {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.comment-submit {

                    display: inline-block;
                    outline: none;
                    cursor: pointer;
                    font-weight: 500;
                    border: 1px solid transparent;
                    border-radius: 2px;
                    height: 36px;
                    line-height: 34px;
                    font-size: 14px;
                    color: #ffffff;
                    background-color: #007c89;
                    transition: background-color 0.2s ease-in-out 0s, opacity 0.2s ease-in-out 0s;
                    padding: 0 18px;
                    :hover {
                        color: #ffffff;
                        background-color: #006570;
                    }
                
}

.reply {
    background: #f9f9f9;
    border: 1px solid #e1e1e1;
    padding: 15px;
    border-radius: 8px;
    margin-top: 10px;
    transition: background-color 0.3s;
}

.reply:hover {
    background-color: #f3f3f3;
}

.reply p {
    margin: 5px 0;
    color: #333;
}

.comment-author {
    font-weight: bold;
    color: #007bff;
}

.comment-content {
    color: #555;
}

.comment-date {
    font-size: 0.9em;
    color: #888;
}

</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="input_wrap">
				<label>카테고리</label>
				
			<c:if test="${pageInfo.board_private == 1}">
    <script type="text/javascript">
        alert("비공개 처리된 게시글입니다.");
        window.history.back(); 
    </script>
</c:if>
			
				
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
				<label>제목</label> <input name="board_title" readonly="readonly"
					value='<c:out value="${pageInfo.board_title}"/>'>
			</div>
			<%-- <div class="input_wrap">
		<label>추천수</label>
		<input name="board_recom" readonly="readonly" value='<c:out value="${pageInfo.hit_count}"/>' >
	</div> --%>
			<div class="input_wrap">
				<label>내용</label>
				<%-- 2023.12.28 전성욱 p 태그 처리
				<textarea rows="3" name="board_content" readonly="readonly"><c:out
						value="${pageInfo.board_content}" /></textarea>
				 --%>
				 <div class="boardContent" id="boardContentDiv"></div>
			</div>
			
				

			<div class="btn_wrap">
			
					<a class="btn" id="list_btn">조회 페이지</a> 
					
				<c:choose>
    <c:when test="${pageInfo.member_no == loginInfo.member_no }">
        <a class="btn" id="modify_btn">수정 하기</a>
    </c:when>
    
    <c:otherwise>
        <!-- 현재 사용자가 작성자가 아니므로 수정 버튼을 표시하지 않음 -->
    </c:otherwise>
</c:choose>

			
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
									<c:out value="${reply.member_nickname}" /> 
								</p>
								<p>
									내용:
								<%-- 	<c:out value="${reply.reply_content}" escapeXml="false" /> --%>
								
									  <div class="cont">${reply.reply_content }</div>
								</p>
								<p>
									작성일:
									<fmt:formatDate value="${reply.reply_rdate}"
										pattern="yyyy-MM-dd HH:mm:ss" />
								</p>
								<!-- 현재 로그인한 사용자가 댓글 작성자와 동일한 경우, 삭제 버튼 표시 -->
								<c:if test="${loginInfo.member_no == reply.member_no}">
									<button class="delete-comment" data-reply-id="${reply.reply_no}">삭제</button>
								</c:if>
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
				value='<c:out value="${pageInfo.category_no}"/>'>
				
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

	
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/myct/board/modify");
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
	        url: "/myct/board/getReplies", 
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
	            url: "/myct/board/insertReply", 
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

	    /*2023.12.28 전성욱 html 태그 추가*/
	    $('#boardContentDiv').append("${pageInfo.board_content}");
	    
	});

</script>
</body>
</html>