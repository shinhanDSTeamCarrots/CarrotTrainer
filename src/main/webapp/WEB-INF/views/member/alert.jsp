<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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