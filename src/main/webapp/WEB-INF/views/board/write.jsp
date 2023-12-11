
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글쓰기</title>
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
<!-- CKEditor CDN 추가 -->
<script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
</head>
<style>
.container {
	width: 100%;
	max-width: 1000px; /* 전체 폭을 늘림 */
	margin: 40px auto; /* 더 큰 상하 여백을 제공하여 요소들을 중앙에 배치 */
	padding: 40px; /* 컨테이너 내부의 여백을 늘림 */
	box-sizing: border-box;
}

.board-title {
	font-size: 2.4rem;
	font-weight: 700;
	margin-bottom: 30px;
}

.form-group label {
	display: block;
	margin-bottom: 10px; /* 라벨과 입력 필드 사이의 여백을 늘림 */
	font-size: 1.8rem; /* 라벨의 글씨 크기를 키움 */
}

.form-group input[type="text"], .form-group textarea
	{
	width: 100%; /* 요소의 너비를 컨테이너에 맞춤 */
	padding: 15px; /* 입력 필드의 내부 여백을 늘림 */
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-bottom: 20px; /* 요소들 사이의 마진을 늘림 */
	font-size: 1.6rem; /* 입력 필드의 글씨 크기를 키움 */
}
.form-group select{
	width: 100%; /* 요소의 너비를 컨테이너에 맞춤 */
	height: 100%;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 1rem; /* 입력 필드의 글씨 크기를 키움 */
}

.form-group textarea {
	height: 300px; /* textarea의 높이를 늘림 */
}

.form-group button {
	padding: 10px 15px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 1.4rem;
	margin-top: 10px;
}

.editor {
	border: 1px solid #ddd;
	border-radius: 5px;
	height: 400px; /* 위지윅 에디터의 높이를 늘림 */
}
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">


			<form action="/myct/board/insert.do" method="post">
				<div class="board-title">자유게시판</div>
				
				<div class="form-group">
    <label for="category_no">카테고리 선택</label>
    <select name="category_no" id="category_no">
        <option value="1">공지사항</option>
        <option value="2">자유게시판</option>
        <option value="3">문의게시판</option>
    </select>
</div>


				<div class="form-group">
					<label for="member_no">작성자</label> <input type="text" id="title"
						name="member_no">
				</div>

				<div class="form-group">
					<label for="board_title">글제목</label> <input type="text" id="title"
						name="board_title">
				</div>

				<div class="form-group">
					<label for="board_content">글 내용</label>
					<textarea id="content" name="board_content"></textarea>
					<script>
						CKEDITOR.replace('content');
					</script>
				</div>
	
				<div class="form-group">
                    <button>등록</button>
                </div>
			</form>


			<!-- CKEditor를 활성화하기 위한 스크립트 -->

		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>


	<script>
		CKEDITOR.replace('content');

		// 폼 제출 함수
		function submitForm() {
			// 에디터 내용을 textarea에 업데이트
			CKEDITOR.instances.content.updateElement();

			// 폼 데이터 검증 (필요한 경우)

			// 폼 제출
			document.getElementById('writeForm').submit();
		}
	
	</script>

	</script>
</body>
</html>