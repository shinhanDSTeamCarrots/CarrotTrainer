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
  .admin-table {
    margin: 0 auto;
    width: 60%; /* 또는 원하는 너비 */
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
  }
  .delete-btn {
    background-color: #f44336;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
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
    <div class="admin-table">
  <table>
    <thead>
      <tr>
        <th>체크박스</th>
        <th>카테고리</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><input type="checkbox"></td>
        <td>분류1</td>
        <td>게시글 제목</td>
        <td>작성자명</td>
        <td>2023-12-03</td>
        <td>100</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
      <!-- 추가 행은 여기에... -->
       <tr>
        <td><input type="checkbox"></td>
        <td>분류1</td>
        <td>게시글 제목</td>
        <td>작성자명</td>
        <td>2023-12-03</td>
        <td>100</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
       <tr>
        <td><input type="checkbox"></td>
        <td>분류1</td>
        <td>게시글 제목</td>
        <td>작성자명</td>
        <td>2023-12-03</td>
        <td>100</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
       <tr>
        <td><input type="checkbox"></td>
        <td>분류1</td>
        <td>게시글 제목</td>
        <td>작성자명</td>
        <td>2023-12-03</td>
        <td>100</td>
        <td><button class="delete-btn" onclick="deleteRow(this)">삭제</button></td>
      </tr>
    </tbody>
  </table>
</div>
		
	</div>
</body>
</html>