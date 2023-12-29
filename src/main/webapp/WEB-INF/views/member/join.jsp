<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		if ($("#member_pw").val().trim() == '') {
			alert('비밀번호를 입력해 주세요.');
			return false;
		}
		if ($("#member_pwCheck").val().trim() == '') {
			alert('비밀번호를 확인해 주세요.');
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
		$("#idCheck").click(
				function() {
					var memberId = $('#member_id').val().trim();
					 if (memberId !== '') {
					$.ajax({
						url : 'idCheck',
						data : {
							id : $('#member_id').val()
						},
						success : function(res) {
							console.log(res);
							if (res == 'true') {
								// 중복된 아이디
								$("#idCheckMessage").text('아이디가 중복되었습니다.').css(
										'color', 'red');
								$("#idCheckMessage").text('아이디가 중복되었습니다.').css('font-size', '1rem');
								$("#member_id").val('');
								$("#member_id").focus();
							} else {
								// 사용 가능한 아이디
								$("#idCheckMessage").text('사용 가능한 아이디입니다.')
										.css('color', 'green');
								$("#idCheckMessage").text('사용 가능한 아이디입니다.').css('font-size', '1rem');
							}
						}
					});
					 }
				});
	})
	
	$(function() {
		$("#nicknameCheck").click(
				function() {
					var memberNickname = $('#member_nickname').val().trim();
					if (memberNickname !== '') {
					$.ajax({
						url : 'nicknameCheck',
						data : {
							nickname : $('#member_nickname').val()
						},
						success : function(res) {
							console.log(res);
							if (res == 'true') {
								// 중복된 아이디
								$("#nicknameCheckMessage").text('닉네임이 중복되었습니다.').css(
										'color', 'red');
								$("#nicknameCheckMessage").text('닉네임이 중복되었습니다.').css('font-size', '1rem');
								$("#member_nickname").val('');
								$("#member_nickname").focus();
							} else {
								// 사용 가능한 아이디
								$("#nicknameCheckMessage").text('사용 가능한 닉네임입니다.')
										.css('color', 'green');
								$("nicknameCheckMessage").text('사용 가능한 닉네임입니다.').css('font-size', '1rem');
							}
						}
					});
					}
				});
	})
	
	function validateId(){
		var id = document.getElementById("member_id").value;
		var isValid = id.length>=5 && id.length<=20;
		if(!isValid){
			document.getElementById("error-id").style.display = "block";
		} else{
			document.getElementById("error-id").style.display = "none";
		}
	}

	function validatePw() {
		var pw = document.getElementById("member_pw").value;
		var isValid = /^(?=.*[a-zA-Z0-9!@#$%^&*()_+])(.{8,})$/.test(pw);

		if (!isValid) {
			document.getElementById("error-pw").style.display = "block";
		} else {
			document.getElementById("error-pw").style.display = "none";
		}
	}

	function validatePwCheck() {
		var pw = document.getElementById("member_pw").value;
		var pwCheck = document.getElementById("member_pwCheck").value;
		var isValid = pw == pwCheck;

		if (!isValid) {
			document.getElementById("error-pwCheck").style.display = "block";
		} else {
			document.getElementById("error-pwCheck").style.display = "none";
		}
	}

	function validatePhoneNumber() {
		var phoneNumber = document.getElementById("member_hp").value;
		var isValid = /^010\d{8}$/.test(phoneNumber);

		if (!isValid) {
			document.getElementById("error-hp").style.display = "block";
		} else {
			document.getElementById("error-hp").style.display = "none";
		}
	}

	function validateNickname() {
		var nickname = document.getElementById("member_nickname").value;
		var isValid = nickname.length >= 1 && nickname.length <= 10;

		if (!isValid) {
			document.getElementById("error-nickname").style.display = "block";
		} else {
			document.getElementById("error-nickname").style.display = "none";
		}
	}
</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function zipcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress;
				var extraRoadAddr = ''; // 참고 항목 변수

				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}

				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}

				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				$('#zipcode').val(data.zonecode);
				//
				$('#member_addr').val(roadAddr);
			}
		}).open();
	}
</script>
<style>
/*******나중에 컨테이너 부분 수정해야 함(지금 내용은 임시책)*******/
/*
.container {
	display: flex;
	flex-direction: row;
	justify-content: center;
	height: 1600px;
	text-align: center;
	position: relative;
	float: right;
}
*/
.wrap { 
    	margin:auto; 
        text-align:center;
        } 
.container {
    max-width: 600px; /* Adjust as necessary */
    margin: auto;
    padding: 20px;
    background-color: #f7f7f7; /* Soft background */
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1); /* Subtle shadow */
}

/* Styling for the form and its elements */
form {
    margin-top: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    padding: 12px;
    text-align: left;
}
/* Error messages */
.error-message {
    color: red;
    font-size: 0.875rem;
    display: none; /* Hide by default, show when needed */
}

/* Adjust link appearance */
a {
    color: #007bff;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

/* Specific styles for registration elements */
.reg input {
    width: auto; /* Adjust width for individual inputs */
    padding: 8px;
    margin-right: 10px; /* Spacing between input and check button */
}

.reg a {
    display: inline-block; /* Align with input */
    margin: 0 5px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .container {
        width: 90%; /* More width on smaller screens */
    }
}
 
 input[type="text"],
input[type="password"] {
    width: calc(100% - 24px); /* Full width minus padding */
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    
}

 input[type="submit"] {
    width: 100%;
    padding: 10px;
    margin-top: 20px;
    border: none;
    border-radius: 4px;
    background-color: #f9b572;
    color: white;
    font-size: 1rem;
    cursor: pointer;
}

input[type="submit"]:hover {
    background-color: #ffa954;
}

/* Button-like styles for links */
.button {
    display: inline-block;
    padding: 8px 15px;
    margin: 10px 5px 10px 0; /* Adjust as needed */
    background-color: #9DC08B; /* Primary button color */
    color: white; /* White text color */
    text-align: center;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none; /* Remove underline from links */
    font-size: 0.875rem; /* Smaller font size for buttons */
    transition: background-color 0.2s; /* Smooth transition for hover effect */
}

.button:hover {
   
    color: white; /* Ensure text color remains white on hover */
}

/* Rest of your styles remain unchanged */


</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			
				<div class="registry">
					<h2 class="title">회원가입</h2>
				</div>
					<form name="frm" id="frm" action="regist" method="post">
						<table class="reg">
							<caption>회원가입</caption>
							<colgroup>
								<col width="20%" />
								<col width="*" />
							<tbody>
							
								<tr>
									<th>아이디</th>
									<td>
									
									<input type="text" name="member_id" id="member_id"
										placeholder="5자 이상 20자 미만" style="float: left;"
										oninput="validateId()"> <a href="javascript:;"
										style="float: left; width: auto; clear: none;" id="idCheck" class="button">중복확인</a>

									</td>
								</tr>
								<tr>
									<th></th>
									<td><div id="error-id" class="error-message" style="display: none;">입력값이
											올바르지 않습니다.</div><span id="idCheckMessage"></span></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" name="member_pw" id="member_pw"
										style="float: left;" placeholder="영문, 숫자, 특수문자 포함 8자 이상"
										oninput="validatePw()">
										
								</tr>
								<tr>
									<th></th>
									<td><div id="error-pw" class="error-message" style="display: none;">입력값이
											올바르지 않습니다.</div></td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td><input type="password" name="member_pwCheck"
										id="member_pwCheck" style="float: left;"
										oninput="validatePwCheck()">
										</td>
								</tr>
								<tr>
									<th></th>
									<td><div id="error-pwCheck" class="error-message"
											style="display: none;">비밀번호를 다시 확인해 주세요.</div><span id="passwordCheckMessage"></span></td>
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
										placeholder="YYYYMMDD 형식으로 입력" oninput="validateBirthday()"></td>
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
										placeholder="10자 미만으로 입력" oninput="validateNickname()">
										<a href="javascript:;"
										style="float: left; width: auto; clear: none;" id="nicknameCheck" class="button">중복확인</a></td>
										
											
								</tr>
								<tr>
									<th></th>
									<td><div id="error-nickname" class="error-message"
											style="display: none;">입력값이 올바르지 않습니다.</div><span id="nicknameCheckMessage"></span></td>
								</tr>
								<tr>
									<th>핸드폰</th>
									<td><input type="text" name="member_hp" id="member_hp"
										style="float: left;" placeholder="'-'표시 생략"
										oninput="validatePhoneNumber()">
									</td>

								</tr>
								<tr>
									<th></th>
									<td><div id="error-hp" class="error-message" style="display: none;">입력값이
											올바르지 않습니다.</div></td>
								</tr>
								<tr>
									<th rowspan="3">주소</th>
									<td><input type="text" name="zipcode" id="zipcode"
										value="" maxlength="6" style="float: left;" readonly>
										<a href="javascript:zipcode();"
										style="float: left; width: auto; clear: none;" class="button">우편번호</a></td>
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
						<input type="submit" value="다음" onclick="return infoSave()" />
					</form>
		</div>		
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
		
</body>
</html>