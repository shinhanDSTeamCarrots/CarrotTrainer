<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<title>글쓰기</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<!-- CKEditor CDN 추가 -->
    <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<title>Insert title here</title>
</head>
<style>
.container {
  max-width: 1200px;
  margin: 50px auto;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    	
    	<h3>파일 업로드 테스트</h3>
		<hr>
		<form action="/myct/healthnews/uploadImages" method="post" enctype="multipart/form-data">
			<%-- <input type="hidden" name="board_no" value="${board_no}" /> --%>
			<input type="file" name="pics" accept="image/*" multiple><br>
			<input type="file" name="pics" accept="image/*" multiple><br>
			<input type="file" name="pics" accept="image/*" multiple><br>
			<button>전송</button>			
		</form>
		<hr>
		<c:forEach items="${list }" var="vo">
			<div>
				<img src="/upload/${vo }" width="400px" height="400px" style="object-fit:cover">
			</div>
		</c:forEach>
    	
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>