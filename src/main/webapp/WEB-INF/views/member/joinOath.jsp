<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오/네이버 회원가입</title>
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
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>


<script>
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "cqlFYY_wCYU5ntDTTBWE", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl : "http://localhost:8090/myct/", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup : false,
		callbackHandle : true
	});

	naverLogin.init();
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="joinOath">
		<a id="naverIdLogin_loginButton" href="javascript:;"> <span>네이버
				로그인</span>
		</a>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>