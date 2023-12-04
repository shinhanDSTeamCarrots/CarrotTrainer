<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.post-title {
	font-size: 2rem; /* 제목 크기 증가 */
	margin-bottom: 30px; /* 여백 증가 */
	color: #333; /* 색상 변경 */
}

.post-info {
	margin-bottom: 40px; /* 여백 증가 */
}

.post-author {
	font-size: 1.2rem; /* 작성자 텍스트 크기 증가 */
	color: #666; /* 색상 변경 */
}

.post-content {
	border: 1px solid #ddd; /* 테두리 색상 변경 */
	padding: 20px; /* 패딩 증가 */
	margin-bottom: 40px; /* 여백 증가 */
	background: #fff; /* 배경색 변경 */
	border-radius: 5px; /* 테두리 둥글게 */
	font-size: 1.2rem; /* 내용 텍스트 크기 증가 */
	line-height: 1.6; /* 줄 간격 조정 */
	color: #333; /* 텍스트 색상 변경 */
}

.comments h3 {
	font-size: 1.8rem; /* 댓글 제목 크기 증가 */
	margin-bottom: 20px; /* 여백 증가 */
}

.comments textarea {
	width: 100%;
	height: 120px; /* 댓글 입력창 높이 증가 */
	padding: 15px; /* 패딩 증가 */
	margin-bottom: 20px; /* 여백 증가 */
	border-radius: 5px; /* 테두리 둥글게 */
	font-size: 1.2rem; /* 텍스트 크기 증가 */
}

.comments button {
	width: 100%;
	padding: 15px 0; /* 버튼 높이 증가 */
	font-size: 1.4rem; /* 버튼 텍스트 크기 증가 */
	border-radius: 5px; /* 테두리 둥글게 */
}

.comments-list {
    margin-top: 30px;
}

.comment {
    padding: 15px;
    margin-bottom: 10px;
    background-color: #f8f8f8;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.comment-author {
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}

.comment-body {
    font-size: 1rem;
    line-height: 1.5;
    color: #666;
}


/* 추가적인 스타일링이 필요한 경우 여기에 작성 */
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<h1 class="post-title">제목: 게시글의 제목입니다.</h1>
			<div class="post-info">
				<span class="post-author">작성자</span>
			</div>
			<div class="post-content">
				<p>게시글의 내용이 여기에 들어갑니다...</p>
			</div>
			<div class="comments">
				<h3>댓글쓰기</h3>
				<textarea placeholder="댓글을 입력하세요."></textarea>
				<button type="button">등록</button>
				<div class="comments-list">
					<div class="comment">
						<div class="comment-author">댓글 작성자 1</div>
						<div class="comment-body">댓글 내용이 여기에 들어갑니다.</div>
					</div>
					<div class="comment">
						<div class="comment-author">댓글 작성자 2</div>
						<div class="comment-body">또 다른 댓글의 내용입니다.</div>
					</div>
					<!-- 더 많은 댓글이 이곳에 추가될 수 있습니다. -->
				</div>

			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		// 댓글 제출 버튼 클릭 이벤트 리스너
		document.getElementById('submit-comment')
				.addEventListener(
						'click',
						function() {
							var commentInput = document
									.getElementById('comment-input');
							var comment = commentInput.value.trim();
							if (comment) {
								// TODO: AJAX를 사용하여 서버에 댓글 내용을 전송
								console.log('댓글을 서버로 전송:', comment);
								// 댓글 입력 필드 초기화
								commentInput.value = '';
								// 댓글 목록에 새 댓글 추가 (예시)
								var commentsList = document
										.getElementById('comments-list');
								var newComment = document.createElement('div');
								newComment.textContent = comment;
								commentsList.appendChild(newComment);
							} else {
								alert('댓글 내용을 입력해주세요.');
							}
						});
	</script>
	</div>
</body>
</html>