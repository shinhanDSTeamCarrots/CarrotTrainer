<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>로그인</title>
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
<script>
	function loginCheck() {
		if ($("#member_id").val() == '') {
			alert("아이디를 입력해 주세요.");
			$("#member_id").focus();
			return false;
		}
		if ($("#member_pw").val() == '') {
			alert("비밀번호를 입력해 주세요");
			$("#member_pw").focus();
			return false;
		}

		$("#board").submit();
	}
</script>
<style>
.wrap {
	margin: auto;
	text-align: center;
}

.container {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 10px;
	text-align: center;
	font-size: 1rem;
	padding-left: 10px;
}

table {
	width: 1000px;
}
td:nth-child(2) {
	padding-left: 50px;
	width: 10%;
	padding-right: 50px;
}

input[type="submit"] {
	height: 75px;
	width: 75px;
	padding-top: 20px;
	padding-bottom: 20px;
	margin-top: 30px;
}

input[type="submit"]:hover {
	background-color: #CEDEBD;
	
}

#board {
	display: flex;
	margin: auto;
	text-align: center;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
		<form action="login" method="post" id="board" name="board">
				<table class="reg">
					<caption>회원가입</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					<tbody>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="member_id" id="member_id"
								style="float: left;"></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="member_pw" id="member_pw"
								style="float: left;"></td>
						</tr>
					</tbody>
				</table>

				<input type="submit" value="로그인" onclick="return loginCheck();">
			</form>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		
	</div>
</body>
</html>