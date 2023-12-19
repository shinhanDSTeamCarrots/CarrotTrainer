<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제해줄께</title>
<script type="text/javascript">
	var 
</script>
<script type="text/javascript">
	let total_money = ${total_amt};
	function OnChecked(checkbox) {
		//해제 된거면
		if(checkbox.checked== false){
			//가격 설정
		}
		//등록 된거면
		else{
			
		}
	}
	function mileageChange(){
		let val = $('#mileage').val();
		if(val > ${mileage}){
			alert("최대 마일리지를 넘을 순 없습니다.");
			$('#mileage').val('${mileage}');
			return;
		}
		
		if(val <0){
			alert("0원 이하로 작성할 수 없습니다");
			$('#mileage').val(0);
			return;
		}		
	}
	function OnComboChange(value){
		let val = value;
		if(val == 0){
			$('#place_name').val("");
			$('#recevier_name').val("${sessionScope.loginInfo.member_name}");
			$('#phone').val("${sessionScope.loginInfo.member_hp}");
			$('#addr1').val("${sessionScope.loginInfo.addr}");
			$('#addr2').val("${sessionScope.loginInfo.addrDetail}");
			$('#zipcode').val("");
			$('#notice').val("부재시 경비실에 부탁드립니다");
		}else{
			
		}
	}
	

</script>
</head>
<body>

<div>
<form action="" method="post">
	<div>
		<h1>구매 정보</h1>
		<table>
		<thead>
			<tr>
				<th><p>썸네일</p></th>
				<th><p>상품명</p></th>
				<th><p>옵션</p></th>
				<th><p>개수</p></th>
				<th><p>총금액</p></th>
				<th><p>구매</p></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="gList" items="${goodsList }">
			<tr>
				<td rowspan="2"><img alt="상품 이미지" src=""> </td>
				<td rowspan="2"><p>${gList.goods_name }</p></td>
				<td><p>${gList.option_name }</p></td>
				<td rowspan="2"><p>X${gList.goods_cnt } 개</p></td>
				<td><p>${gList.goods_final_price }원</p></td>
				<td rowspan="2"><input type="checkbox" value="${gList.cart_no }" checked onchange="OnChecked(this)"></td>
			</tr>
			<tr>
				<td><p>+${gList.option_price }</p></td>
				<td><p>배달비 0원</p></td>
			</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3"></td>
				<td><strong>총 합계</strong></td>
				<td><input type="text" value="${total_amt }" readonly></td>
				<td><strong>원</strong></td>
			</tr>
		</tfoot>
		</table>
	</div>


	<div>
		<h1>배송 정보</h1>
		<select id="deliver_combobox" onchange="OnComboChange(this.value)">
			<option value="0" }>직접입력</option>
		<c:forEach var="addr" items="${addrList }">
			<option value="${addr.rownum }">${addr.place_name }</option>
		</c:forEach>
		</select>
	</div>
	<div>
	<table id="deliverTable">
		<tr>
			<td><p>배송지 명</p></td>
			<td><input type="text" id="place_name"/> </td>
		</tr>
		<tr>
			<td><p>수신자 명</p></td>
			<td><input type="text" id="recevier_name" name="recevier_name"/> </td>
		</tr>
		<tr>
			<td><p>번호</p></td>
			<td><input type="text" id="phone" name="phone"/> </td>
		</tr>
		<tr>
			<td><p>주소</p></td>
			<td><input type="text" id="addr1" onclick="" name="addr1" readonly/><br>
			<input type="text" id="addr2" name="addr2" />
			</td>
		</tr>
		<tr>
			<td><p>우편번호</p></td>
			<td><input type="text" id="zipcode" name="zipcode"/> </td>
		</tr>
		<tr>
			<td><p>배송 메시지</p></td>
			<td><input type="text" id="notice" name="notice"/> </td>
		</tr>
	</table>
	</div>
	<div>
		<h1>결재 정보</h1>
		<%--마일리지 정보 --%>
		<h2>현재 마일리지</h2>
		<input type="number" value="${mileage }" onchange="mileageChange()" name="mileage" id="mileage"><p>/${mileage }원</p>
		<%-- 아임포트 --%>
		
	</div>
</form>
</div>






</body>
</html>