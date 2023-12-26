<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 리스트</title>
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
	function infoSave() {
		$("#frm").submit();
	}
</script>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<form name="frm" id="frm" action="regist.do" method="post">
			<table class="memberList">
				<colgroup>
					<col width="80px" />
					<col width="*" />
					<col width="100px" />
					<col width="200px" />
				</colgroup>
				<tbody>
					<th>회원번호</th>
					<th>아이디</th>
					<th>차단 여부</th>
					<c:if test="${!empty all }">
						<c:forEach var="vo" items="${all }">

							<tr>

								<td>${vo.member_no }</td>

								<td>${vo.member_id }</td>
								<td><select name="blocked" id="blocked">
										<c:choose>
											<c:when test="${vo.member_blocked == 1 }">
												<option value="1">1</option>
												<option value="0">0</option>
											</c:when>
											<c:otherwise>
												<option value="0">0</option>
												<option value="1">1</option>
											</c:otherwise>
										</c:choose>
								</select></td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			<input type="submit" value="수정사항 반영" onclick="return infoSave()" />
		</form>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>