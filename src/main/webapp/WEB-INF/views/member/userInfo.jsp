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
<style>
.wrap { 
    	margin:auto; 
        text-align:center;
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
  
  font-size: 0.8rem; 
  padding-left: 50px; 
  
	
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class = "container">
		<form name="frm" id="frm" action="userInfo" method="post">
			<table class="memberList">
				<colgroup>
					<col width="80px" />
					<col width="*" />
					<col width="100px" />
					<col width="200px" />
				</colgroup>
				<tbody>
				<!-- 20231227 회원차단 여부 바꿨을때 db에 연동하는 법 -->
					<th>회원번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>차단 여부</th>
					<c:if test="${!empty all }">
						<c:forEach var="vo" items="${all }">
							<tr>
								<td>${vo.member_no }</td>
								<td>${vo.member_id }</td>
								<td>${vo.member_name }</td>
								<td><select name="blocked" id="blocked">
										<c:choose>
											<c:when test="${vo.member_blocked == 0 }">
												<option value="X">X</option>
												<option value="O">O</option>
											</c:when>
											<c:otherwise>
												<option value="O">O</option>
												<option value="X">X</option>
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
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>