
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ page import="xyz.teamcarrot.myct.member.MemberVO" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
    // category_no와 카테고리 이름 매핑
    Map<String, String> categoryNames = new HashMap<>();
    categoryNames.put("1", "공지사항");
    categoryNames.put("2", "자유게시판");
    categoryNames.put("3", "문의게시판");
    categoryNames.put("4", "웰니스 뉴스");

    // URL로부터 category_no 받기
    String categoryNo = request.getParameter("category_no");
    String categoryName = categoryNames.getOrDefault(categoryNo, "Unknown"); // 기본값 설정
%>
	
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
<script src="${pageContext.request.contextPath}/js/script.js"></script>

<script src="/myct/smarteditor2-2.8.2.3/js/HuskyEZCreator.js"></script>
</head>
<style>
/* General Page Styles */
body {
    font-family: 'Arial', sans-serif;
  
    margin: 0;
    padding: 0;
    color: #333;
}

.container {
    width: 100%;
    max-width: 1000px;
    margin: 40px auto;
    padding: 40px;
    box-sizing: border-box;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}



/* Form Group Styling */
.form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
}

.form-group label {
    margin-bottom: 8px;
    font-size: 1.6rem;
    color: #609966; /* Shade of label color */
    font-weight:bold;
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
    height: 200px; /* Adjust based on preference */
}

/* Button Styling */
.form-group button {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s;
}

.form-group button:hover {
    background-color: #0056b3;
}

/* File Input Styling */
#attach-file {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    height: 40px;
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


			<form action="/myct/board/insert" method="post"
				enctype="multipart/form-data" onsubmit="return submitForm();">


				<div class="form-group">
    <label for="category_no">카테고리</label>
    <input type="text" id="category_name" value="<%=categoryName %>" readonly>
    <!-- 실제로 데이터를 전송하기 위한 hidden 필드 -->
    <input type="hidden" name="category_no" value="<%=categoryNo %>">
</div>

				<div class="form-group">
					<label for="board_title">글제목</label> <input type="text" id="title"
						name="board_title">
				</div>

				<div class="form-group">
					<label for="member_no">작성자</label>
					<% MemberVO member = (MemberVO) session.getAttribute("loginInfo"); %>
					<% if (member != null) { %>
					<input type="hidden" name="member_no"
						value="<%= member.getMember_no() %>"> <input type="text"
						value="<%= member.getMember_nickname() %>" readonly>
					<% } else { %>

					<% } %>
				</div>

				<div class="form-group">
					<textarea id="content" name="board_content"></textarea>
				</div>

				<div class="form-group">
					<input type="file" name="file" id="attach-file" />
				</div>


				<div class="form-group">
					<button>등록</button>
				</div>	
			</form>


			<!-- <form action="/myct/healthnews/uploadFile.do" method="post"
				enctype="multipart/form-data">
				<div class="form-group">
					<label for="uploadFile">이미지 파일:</label> <input type="file"
						name="uploadFile" id="uploadFile" />
				</div>
				<button type="submit">업로드</button>
			</form> -->
		<!-- <h3>파일 업로드 테스트</h3>
		<hr>
		<form action="/myct/healthnews/imageUpload" method="post" enctype="multipart/form-data">
			<input type="file" name="pics" accept="image/*" multiple><br>
			<input type="file" name="pics" accept="image/*" multiple><br>
			<input type="file" name="pics" accept="image/*" multiple><br>
			<button>전송</button>			
		</form> -->
	
		<c:forEach items="${list }" var="vo">
			<div>
				<img src="/upload/${vo }" width="400px" height="400px" style="object-fit:cover">
			</div>
		</c:forEach>


		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>



</body>
</html>