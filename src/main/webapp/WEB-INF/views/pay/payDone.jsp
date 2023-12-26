<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제가 완료되었습니다!</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
</head>
<body>
 <div class="wrap">
   	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<p>결제 번호: ${order }</p>
	<p>결제가 완료되었습니다!</p>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>