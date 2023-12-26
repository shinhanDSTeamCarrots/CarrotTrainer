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
  body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f4f4f4;
  }
  .container {
    max-width: 800px;
    margin: 0 auto;
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  h1 {
    text-align: center;
  }
  form {
    display: flex;
    flex-direction: column;
  }
  label {
    margin-top: 10px;
  }
  input[type="text"],
  textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border-radius: 4px;
    border: 1px solid #ccc;
  }
  textarea {
    height: 150px;
  }
  .button-group {
    margin-top: 20px;
    text-align: right;
  }
  button {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    background-color: #007bff;
    color: white;
    cursor: pointer;
  }
  button:hover {
    background-color: #0056b3;
  }
</style>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    <div class="container">
  <h1>QnA 답변</h1>
  <form action="submitAnswer" method="post">
    <label for="title">제목</label>
    <!-- 예를 들어 PHP에서 데이터를 불러온다면 아래와 같이 사용할 수 있습니다. -->
    <input type="text" id="title" name="title" readonly value="<?php echo $questionTitle; ?>">

    <label for="author">작성자</label>
    <!-- 작성자 이름을 서버에서 가져와서 표시합니다. -->
    <input type="text" id="author" name="author" readonly value="<?php echo $authorName; ?>">

    <label for="content">내용</label>
    <!-- 작성자의 질문 내용을 서버에서 가져와서 표시합니다. -->
    <textarea id="content" name="content" readonly><?php echo $questionContent; ?></textarea>

    <label for="reply">답변</label>
    <textarea id="reply" name="reply" required placeholder="답변을 여기에 작성하세요."></textarea>

    <div class="button-group">
      <button type="submit">저장</button>
      <button type="button" onclick="window.history.back();">취소</button>
    </div>
  </form>
</div>
    	</div>
</body>
</html>