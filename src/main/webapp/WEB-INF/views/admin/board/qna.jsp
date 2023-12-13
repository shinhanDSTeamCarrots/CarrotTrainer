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
  .qna-table {
    margin: 0 auto;
    width: 60%;
    border-collapse: collapse;
  }
  .qna-table th, 
  .qna-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  .qna-table th {
    background-color: #f2f2f2;
  }
  .qna-table th, .qna-table td {
    text-align: center;
  }
  .answer-link {
    color: #007bff;
    text-decoration: none;
    cursor: pointer;
  }
  .answer-link:hover {
    text-decoration: underline;
  }
  .manage-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
  }
  .answer-btn, .delete-btn {
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
  }
  .answer-btn {
    background-color: #4CAF50;
    color: white;
  }
  .delete-btn {
    background-color: #f44336;
    color: white;
  }
  .answer-btn:hover {
    background-color: #45a049;
  }
  .delete-btn:hover {
    background-color: #d32f2f;
  }
</style>
<script>
  function answerQuestion(questionId) {
    // 이곳에 답변 페이지로 이동하는 로직을 구현합니다.
    window.location.href = `answer-question.html?questionId=${questionId}`;
  }

  function deleteQuestion(button, questionId) {
	    if(confirm('이 질문을 삭제하시겠습니까?')) {
	      // TODO: 서버에 삭제 요청을 보내는 AJAX 코드를 여기에 추가
	      console.log('Deleting question with ID:', questionId);
	      
	      // DOM에서 해당 행을 삭제
	      var row = button.parentNode.parentNode.parentNode;
	      row.parentNode.removeChild(row);
	    }
	  }
</script>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    <table class="qna-table">
  <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일자</th>
      <th>관리</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1001</td>
      <td><a href="answer-question.html?questionId=1001" class="answer-link">문의 있습니다</a></td>
      <td>사용자1</td>
      <td>2023.10.10</td>
      <td>
        <div class="manage-buttons">
          <button class="answer-btn"><a href="qnaReply.do?questionId=1001" class="write-button">답변</a></button>
          <button onclick="deleteQuestion(this, 1001)" class="delete-btn">삭제</button>
        </div>
      </td>
    </tr>
    <!-- 다른 QnA 항목들 -->
  </tbody>
</table>

    	</div>
</body>
</html>