<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title></title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
</head>
<style>
   body {
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            max-width: 800px;
            margin: 60px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        th {
            text-align: left;
            padding-right: 20px;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        textarea {
            height: 200px;
            resize: vertical;
        }

        input[type="file"] {
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

/* 추가적인 스타일링이 필요한 경우 여기에 작성 */
</style>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    	
    	
    	<table>
		<tr>
			<th class="w-px160">제목</th>
			 <td><input type="text" name="board_title" value="${board_title}"/></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="membet_no" class="need" /></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" class="need"></textarea></td>
		</tr>
		<tr>
			<th>파일 첨부</th>
			<td class="left">
				<label>
					<input type="file" name="file" id="attach-file" />
					<img src="img/select.png" class="file-img" />
				</label>
				<span id="file-name"></span>
				<span id="delete-file" style="color: red; margin-left: 20px;"><i class="fas fa-times font-img"/></i></span>
			</td>
		</tr>
	</table>
	
	

    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
