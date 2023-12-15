<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

<script>
<c:if test="${cmd eq 'move'}">
	alert('${msg}');
	location.href='${url}';
</c:if>
<c:if test="${cmd == 'back'}">
	alert('${msg}');
	history.back();
</c:if>



</script>