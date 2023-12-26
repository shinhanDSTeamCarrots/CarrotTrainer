<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>자유게시판</title>
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
 .write-form {
    margin: 0 auto;
    width: 60%;
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  th {
    background-color: #f2f2f2;
    width: 20%;
  }
  td {
    width: 80%;
  }
  input[type="text"], textarea {
    width: 95%;
    padding: 5px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
  }
  textarea {
    height: 300px; /* 조정된 높이 */
  }
  
  input[type="file"] {
    margin-bottom: 10px;
  }
  .submit-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
  }
  .button-group {
    text-align: right;
    padding-top: 10px;
  }
</style>
</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    	<div class="write-form">
  <form action="/submit-news" method="post" enctype="multipart/form-data">
    <table>
      <caption>건강뉴스 글쓰기</caption>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" required></td>
      </tr>
      <tr>
        <th>작성자</th>
        <td><input type="text" name="author" required></td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea name="content" rows="5" required></textarea></td>
      </tr>	
      <tr>
        <th>첨부파일</th>
        <td><input type="file" name="attachment"></td>
      </tr>
      <tr>
        <td colspan="2" class="button-group">
          <input type="submit" value="저장" class="submit-btn">
          <input type="button" value="취소" class="submit-btn" onclick="history.back();">
        </td>
      </tr>
    </table>
  </form>
</div>
    	</div>
</body>
</html>