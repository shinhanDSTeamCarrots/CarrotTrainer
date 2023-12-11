<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회원가입</title>
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
		if ($("#member_id").val().trim() == '') {
			alert('아이디를 입력해 주세요.');
			return false;
		}
		

		/* 왜 return이 아니라 return false로 해줘야 하는지? */
		var idVal = document.getElementById("member_id").value;
		if (idVal.length<5|| idVal.length>= 20) {
			alert("아이디는 5자 이상 20자 미만으로 입력해 주세요.");
			return false;
		}

		//중복확인 안 누르고 다음 버튼 눌렀을때, 중복 아이디 이미 있을때 어떻게 할지 생각
		if ($("#member_pw").val().trim() == '') {
			alert('비밀번호를 입력해 주세요.');
			return false;
		}
		if ($("#member_pwCheck").val().trim() == '') {
			alert('비밀번호를 확인해 주세요.');
			return false;
		}
		if ($("#member_pw").val().trim() != $("#member_pwCheck").val().trim()) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		var reg = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,}$/;
		var txt = $("#member_pw").val();
		if (txt.match(reg) == null) {
			alert("비밀번호는 영문,숫자,특수문자를 조합해서 8자이상 입력하세요");
			return false;
		}
		var nicknameVal = document.getElementById("member_nickname").value;
		if (nicknameVal.length > 10) {
			alert("닉네임은 10자 이하로 입력해 주세요.");
			return false;
		}

		$("#frm").submit();
		
	}
	var dupCheck = false;
	var dupCheckNumber = 0;
	$(function() {
		$("#idCheck").click(function() {
			dupCheckNumber++;
			$.ajax({
				url : 'idCheck.do',
				data : {
					id : $('#member_id').val()
				},
				success : function(res) {
					console.log(res);
					if (res == 'true') {
						alert('중복된 아이디입니다.');
						$("#member_id").val('');
						$("#member_id").focus();
					} else {
						
						alert('사용가능한 아이디입니다.');
						dupCheck = true;
					}
				}
			})
		})
	})
	/* 중복확인 왜 안되는지 확인해보기 */
</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function zipcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				/*
				document.getElementById('sample4_postcode').value = data.zonecode;
				document.getElementById("sample4_roadAddress").value = roadAddr;
				document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
				 */
				$('#zipcode').val(data.zonecode);
				$('#member_addr1').val(roadAddr);
			}
		}).open();
	}
</script>
<style>
/*******나중에 컨테이너 부분 수정해야 함(지금 내용은 임시책)*******/
.container {
	display: flex;
	flex-direction: row;
	justify-content: center;
	height: 1600px;
	text-align: center;
}

.menu {
	text-align: center;
}

table.reg tbody tr th {
	margin-bottom: 10px;
	text-align: center;
}

table.reg tbody tr td input {
	margin-bottom: 10px;
	width: 250px;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="menu">
				<h1 class="title">회원가입</h1>
				<a href="join_naverKakao">네이버/카카오 아이디로 회원가입하실 분은 여기를 클릭해 주세요</a>
				<form name="frm" id="frm" action="join.do" method="get">
					<table class="reg">
						<caption>회원가입</caption>
						<colgroup>
							<col width="20%" />
							<col width="*" />
						<tbody>
							<tr>
								<th>아이디</th>
								<td><input type="text" name="member_id" id="member_id"
									style="float: left;"> <a href="javascript:;"
									style="float: left; width: auto; clear: none;" id="idCheck">중복확인</a>

								</td>
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
									id="member_birthday" style="float: left;"
									placeholder="YYYYMMDD 형식으로 입력"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="member_name" id="member_name"
									style="float: left;"></td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td><input type="text" name="member_nickname"
									id="member_nickname" style="float: left;"
									placeholder="10자 미만으로 입력"></td>
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
								<td><input type="text" name="member_addr1"
									id="member_addr1" value="" maxlength="15" style="float: left;"
									readonly></td>
							</tr>
							<tr>
								<td><input type="text" name="member_addr2"
									id="member_addr2" value="" maxlength="15" style="float: left;"></td>
							</tr>
						</tbody>
					</table>
					<input type = "submit" value = "다음" onclick = "return infoSave()"/>
				</form>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>