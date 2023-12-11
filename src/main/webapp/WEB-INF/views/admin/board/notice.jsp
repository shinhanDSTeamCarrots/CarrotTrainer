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
  .notice-table {
    margin: 20px auto;
    width: 60%;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed; /* 컬럼 너비 고정 */
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
  }
  th {
    background-color: #f2f2f2;
  }
  .delete-btn, .write-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
  }
  .delete-btn {
    background-color: #f44336;
  }
  .buttons {
    text-align: right;
    margin-bottom: 10px;
  }
  th:nth-child(1), td:nth-child(1), th:nth-child(3), td:nth-child(3) {
    text-align: center;
  }
</style>
<script>
function deleteRow(btn) {
  // 해당 버튼이 속한 행을 찾아서 삭제
  var row = btn.parentElement.parentElement;
  row.remove();
}

</script>
<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	
    	<div class="notice-table">
  <div class="buttons">
    <button class="write-btn" onclick="writeNotice()"><a href="noticeWrite.do" class="write-button">글쓰기</a></button>
  </div>
  <table>
    <thead>
      <tr>
        <th>공지사항</th>
        <th>제목</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><input type="checkbox"></td>
        <td>공지사항입니다.</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
      <tr>
        <td><input type="checkbox"></td>
        <td>공지사항입니다.</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
      <!-- 추가 행은 여기에... -->
    </tbody>
  </table>
</div>
    	</div>
</body>
</html>