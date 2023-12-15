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
/* .container{
    		text-align : center;
    	
    	} */
.container {
	display: flex;
	flex-direction: row;
	justify-content: center;
	/* 추가: 수직 가운데 정렬 */
	height: 1600px;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<form action="login.do" method="post" id="board" name="board">
			<div class="container">
				<div class="menu">
					<h1 class="login">로그인</h1>
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
								<td><input type="password" name="member_pw" id="member_pw"></td>
							</tr>

						</tbody>
						<input type="checkbox" name="loginSave" id="loginSave"/> 로그인 정보 저장
					</table>
					<div class="loginSuccess">
						<input type="submit" value="로그인" onclick="return loginCheck();">
					</div>
					
				</div>
			</div>
		</form>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>