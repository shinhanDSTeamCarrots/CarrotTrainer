
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="xyz.teamcarrot.myct.member.MemberVO" %>
	
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

<script src="/myct/smarteditor2-2.8.2.3/js/HuskyEZCreator.js"></script>
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
 <script>
    var oEditors = [];
    $(function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "content",
            sSkinURI: "/myct/smarteditor2-2.8.2.3/SmartEditor2Skin.html",    
            htParams : {
                bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                fOnBeforeUnload : function(){
                }
            }, //boolean
            fOnAppLoad : function(){
                //예제 코드
                //oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
            },
            fCreator: "createSEditor2"
        });
    })
    function goSave() {
    	oEditors.getById['content'].exec('UPDATE_CONTENTS_FIELD',[]);
    	$("#frm").submit();
    }
    
    function submitForm() {
        // 스마트에디터 내용을 textarea에 업데이트하는 코드
        // 예시: oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

        // 폼 제출
        document.getElementById('writeForm').submit();
    }

    </script>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">


			<form action="/myct/board/insert.do" method="post" enctype="multipart/form-data" onsubmit="return submitForm();">


				<div class="form-group">
					<label for="category_no">카테고리 선택</label>
					<select name="category_no" id="category_no">
						<option value="1">공지사항</option>
						<option value="2">자유게시판</option>
						<option value="3">문의게시판</option>
					</select>
				</div>

				<div class="form-group">
					<label for="board_title">글제목</label> 
					<input type="text" id="title" name="board_title">
				</div>

				 <div class="form-group">
                    <label for="member_no">작성자</label>
                   <% MemberVO member = (MemberVO) session.getAttribute("loginInfo"); %>
<% if (member != null) { %>
    <input type="hidden" name="member_no" value="<%= member.getMember_no() %>">
    <input type="text" value="<%= member.getMember_nickname() %>" readonly>
<% } else { %>
    <!-- 로그인하지 않은 경우의 처리 -->
<% } %>


                </div>

				<div class="form-group">
					<label for="board_content">글 내용</label>
					<textarea id="content" name="board_content"></textarea>
					
				</div>

				<div class="form-group">

					<label for="file">파일 첨부</label>
            <input type="file" name="file" id="attach-file" />

				</div>


				<div class="form-group">
                    <button>등록</button>
                </div>
			</form>




		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>



</body>
</html>