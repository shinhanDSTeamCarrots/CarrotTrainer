<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
	<script>
		function memberDel(){
			if($("#pw").val()==''){
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			var del = confirm("정말 탈퇴하시겠습니까?");
			if (del){
				alert("정상적으로 탈퇴 처리되었습니다.");
			//db에서 삭제하는 방법 생각해 보기
			}
		}
	</script>
	<style>
	.container {
	display: flex;
	flex-direction: row;
	justify-content: center;
	height: 1600px;
	text-align: center;
}
	</style>
</head>

<body>
	<div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class = "menu">
    			<h2 class = "title">탈퇴하기</h2>
    			<h3 class = "title">아래 칸에 비밀번호를 입력하시면 탈퇴됩니다.</h3>
    			<form name="frm"  id="frm" action="" method="post">
    				<input type = "password" name = "pw" id = "pw">
    				<h3 class = "title" style = "color:red;">(주의) 탈퇴 시 회원님의 마일리지는 자동으로 소멸되며, 이후 복구할 수 없습니다.</h3> 
    			</form>
    			<input type = "button" value = "탈퇴하기" onClick ="memberDel()">
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>