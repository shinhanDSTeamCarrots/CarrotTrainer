<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="xyz.teamcarrot.myct.member.MemberVO"%>
<%
MemberVO vo = (MemberVO) request.getSession().getAttribute("loginInfo");
if (vo == null) {
	throw new RuntimeException("세션에서 'id' 속성을 찾을 수 없습니다.");
}
String member_id = vo.getMember_id();
String member_birthday = vo.getMember_birthday();
int member_no = vo.getMember_no();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>개인정보 수정</title>
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
		<div class="container">
			<h2 class="title">개인정보 수정</h2>
			<form name="frm" id="frm" action="update" method="post">
				<div class="memberInfo">
					<table class="reg">
						<caption>회원가입</caption>
						<colgroup>
							<col width="20%" />
							<col width="*" />
						<tbody>
							<tr>
								<th>아이디</th>
								<td><input type="text" name="member_id" id="member_id"
									value="<%=member_id%>" style="float: left;" readonly></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="member_pw" id="member_pw"
									style="float: left;" placeholder="영문, 숫자, 특수문자 포함 8자 이상">
								</td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td><input type="password" name="member_pwCheck"
									id="member_pwCheck" style="float: left;"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="text" name="member_email"
									id="member_email" style="float: left;"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" name="member_birthday"
									id="member_birthday" value="<%=member_birthday%>"
									style="float: left;" readonly></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="member_name" id="member_name"
									style="float: left;"></td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td><input type="text" name="member_nickname"
									id="member_nickname" style="float: left;"></td>
							</tr>

							<tr>
								<th>핸드폰</th>
								<td><input type="text" name="member_hp" id="member_hp"
									style="float: left;" placeholder="'-'표시 생략"></td>
							</tr>
							<tr>
								<th rowspan="3">*주소</th>
								<td><input type="text" name="zipcode" id="zipcode" value=""
									maxlength="6" style="float: left;" readonly> <a
									href="javascript:zipcode();"
									style="float: left; width: auto; clear: none;">우편번호</a></td>
							</tr>
							<tr>
								<td><input type="text" name="member_addr" id="member_addr"
									value="" maxlength="15" style="float: left;" readonly></td>
							</tr>
							<tr>
								<td><input type="text" name="member_addrDetail"
									id="member_addrDetail" value="" maxlength="15"
									style="float: left;"></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" value="다음" onclick="return infoSave()" /> <input
						type="hidden" name="member_no" value="<%=member_no%>" />
				</div>
			</form>

			<div class="memberDel">
				<a href="${pageContext.request.contextPath}/member/memberDel">회원
					탈퇴하기</a>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>