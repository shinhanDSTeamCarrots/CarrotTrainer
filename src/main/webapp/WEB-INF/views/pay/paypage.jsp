<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 진행</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function daumMapFunc() {
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
				$('#addr1').val(roadAddr);
			}
		}).open();
	}
</script>
<script type="text/javascript">
	let total_money = ${total_amt};
	let poststr = '${addrJsonStr}';
	let postobj = JSON.parse(poststr);
	function mileageChange(){
		let val = $('#mileage').val();
		if(val > ${mileage}){
			alert("최대 마일리지를 넘을 순 없습니다.");
			$('#mileage').val('${mileage}');
			return;
		}
		if(val > ${total_amt}){
			alert("최대 금액 이상으로 마일리지 사용할 수 없습니다.");
		}
		if(val <0){
			alert("0원 이하로 작성할 수 없습니다");
			$('#mileage').val(0);
			return;
		}		
	}
	console.log(postobj);
	function OnComboChange(value){
		let val = value;
		if(val == 0){
			$('#place_name').val("기본");
			$('#recevier_name').val("${sessionScope.loginInfo.member_name}");
			$('#phone').val("${sessionScope.loginInfo.member_hp}");
			$('#addr1').val("${sessionScope.loginInfo.member_addr}");
			$('#addr2').val("${sessionScope.loginInfo.member_addrDetail}");
			$('#zipcode').val("");
			$('#notice').val("부재시 경비실에 부탁드립니다");
		}else{
			//postobj
			$('#place_name').val(postobj[val-1].place_name);
			$('#recevier_name').val(postobj[val-1].recevier_name);
			$('#phone').val(postobj[val-1].phone);
			$('#addr1').val(postobj[val-1].addr1);
			$('#addr2').val(postobj[val-1].addr2);
			$('#zipcode').val(postobj[val-1].zipcode);
			$('#notice').val(postobj[val-1].notice);
		}
	}
	$(document).ready(function(){
		let mil = ${mileage};
		let fullamt = ${total_amt };
		let minval = Math.min(mil,fullamt);
		$('#mileage').val(minval);
		$('#place_name').val("기본");
		$('#recevier_name').val("${sessionScope.loginInfo.member_name}");
		$('#phone').val("${sessionScope.loginInfo.member_hp}");
		$('#addr1').val("${sessionScope.loginInfo.member_addr}");
		$('#addr2').val("${sessionScope.loginInfo.member_addrDetail}");
		$('#zipcode').val("");
		$('#notice').val("부재시 경비실에 부탁드립니다");
	});
	

</script>
<script type="text/javascript">
	let payMethod;
	let sumittable = false;
	let pg;
	let paytype;
	var payamount;
	var makeMerchantUid;
	function valdidateDeliver(){
		let recevier_nameDom = $('#recevier_name');
		let phoneDom = $('#phone');
		let addr1Dom = $('#addr1');
		let addr2Dom = $('#addr2');
		let zipcodeDom = $('#zipcode');
		if(recevier_nameDom.val().trim() == ""){
			alert("수신자 이름을 적어주세요!");
			recevier_nameDom.focus();
			return false;
		}
		if($.trim(phoneDom.val()) == ""){
			alert("핸드폰 번호를 적어주세요!");
			phoneDom.focus();
			return false;
		}
		if($.trim(addr1Dom.val()) == ""){
			alert("주소를 적어주세요!");
			addr1Dom.focus();
			return false;
		}
		if($.trim(addr2Dom.val()) == ""){
			alert("상세 주소를 적어주세요!");
			addr2Dom.focus();
			return false;
		}
		if($.trim(zipcodeDom.val()) == ""){
			alert("우편번호를 적어주세요!");
			zipcodeDom.focus();
			return false;
		}
		return true;
	}



	function kginicis() {
		if(!valdidateDeliver())
			return;
		//KG이니시스 결제
		$('#additionalPayInfo *').remove();
		payMethod = "card";
		pg="html5_inicis";
		pg+=".INIpayTest";
		paytype = "INICIS";
		requestPay();
	}
	
	function tosspay() {
		if(!valdidateDeliver())
			return;
		//토스 결제
		$('#additionalPayInfo *').remove();
		pg = "tosspay";
		pg += ".tosstest";
		payMethod = "trans";
		paytype = "TOSS";
		requestPay();
	}
	function kakaopay() {
		if(!valdidateDeliver())
			return;
		//카카오 결제
		$('#additionalPayInfo *').remove();
		pg = "kakaopay";
		pg+=".TC0ONETIME";
		paytype = "KAKAO";
		payMethod="";
		requestPay();
	}
	function bankpay() {
		if(!valdidateDeliver())
			return;
		//무통장 입금
		//입금자 명 받을 수 있는 div 추가
		$('#additionalPayInfo').append("<h2>입금자 명: </h2>"
		+"<input type='text'value='${sessionScope.loginInfo.member_name}'id='bankowner' name='bankowner'/>"
		+"<input type='button' value='제출'id='banksubmit'/>");
		paytype = "BANK";
		$('#banksubmit').click(function () {
			if($('#bankowner').val().trim()==""){
				alert("입금자 명을 작성해 주세요! ");
				return;
			}
			payamount = ${total_amt} - $('#mileage').val();
			$('#payform').submit();
		});
	}
	function payformSubmit(){
		let payStr = new Object();
		payStr.paytype = paytype;
		if(paytype == "BANK"){
			payStr.bankowner = $('#bankowner').val();
		}else{
			payStr.uid = "IMP"+makeMerchantUid;
			payStr.pgdata = pg;
			payStr.amount = payamount;
			payStr.payMethod = payMethod;
		}
		$('#payform').append("<input type='hidden' value='"+paytype+"' name='paytype'/>"
				+"<input type='hidden' value='"+JSON.stringify(payStr)+"' name='payStr'/>"
				+"<input type='hidden' value='"+payamount+"' name='pay_price'/>");
	}
	
	
	//결제
	var IMP = window.IMP;
	IMP.init("imp07700058");

	function requestPay(){
		let today = new Date();   
		let hours = today.getHours(); // 시
		let minutes = today.getMinutes();  // 분
		let seconds = today.getSeconds();  // 초
		let milliseconds = today.getMilliseconds();
		makeMerchantUid = hours +  minutes + seconds + milliseconds;
		let orderName = "${title_name}";
		payamount = ${total_amt} - $('#mileage').val();


		IMP.request_pay({
			pg: pg,
			pay_method: payMethod,
			merchant_uid: "IMP"+makeMerchantUid,   // 주문번호
			name: orderName,			   // 상품명
			amount: payamount,                         // 숫자 타입
			buyer_email:" ${sessionScope.loginInfo.member_email}",
			buyer_name: $('#recevier_name').val(),
			buyer_tel: $('#phone').val(),
			buyer_addr: $('#addr1').val() + $('#addr2').val(),
			buyer_postcode: $('#zipcode').val()
		},
		function (rsp){
			//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
			if (rsp.success) {
				$.ajax({
					type: 'POST',
					url: '${pageContext.request.contextPath}/pay/validation/' + rsp.imp_uid,
					data: {
						userIdNo: rsp.data,
					}
                }).done(function(data) {
                    if(rsp.paid_amount === data.response.amount){
                        alert("결제 성공");
						$('#payform').submit();
                    } else {
                        alert("결제 실패");
                    }
                });
			} else {
				alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
			}
		});
	}
</script>
<style type="text/css">
.container {
	width:100%;
	max-width:1200px;
	margin : 0 auto;
	display:flex;
	padding: 20px;
    box-sizing: border-box;
    flex-direction:column;
}

/* 장바구니 헤더 */
.cart_header{
	background-color: #EDF1D6;
	display:flex;	
	flex-direction:row;
	width:100%;
	heigth:40px;
	color:#435334;
	justify-content: space-between;
    align-items: center;
}
.cart_header > .rightAlign{
	text-align: right;
	display:flex;
	line-height:40px;
	margin-right:20px;
}
.cart_header > h1{
	line-height: 40px;
	margin-left: 20px;
	
}
.cart_header > .rightAlign > #cart_subtitle{
	font-weight: 600;	
	line-height: 40px;
	margin-right:20px;
	
}
.cart_header > .rightAlign > #cart_later{
	font-weight: 400;
	line-height: 40px;
}

/*구분선*/

.title-division-line {
	width:1160px;
	border-top: 1.5px solid #435334;
	margin : 0 auto;
}

.totalprice-division-line {
	width:1160px;
	border-top: 3px solid #435334;
	margin : 0 auto;
}
.totalPrice{
	margin: 15px;
	height:40px;
	font-size:20px;
	font-weight:400;
	display:flex;
	flex-direction:row;	
	justify-content: flex-end;
}
.priceText{
	display:flex;
	flex-direction:row;
}
.totalpurchase{
	margin-left:10px;
	font-weight: 500;
}

#goodsTable > tbody > tr{
	display:flex;
    flex-direction:row;
    margin:20px;
    margin-left:10px;
    width:100%;
}

</style>

</head>
<body>

<div class="wrap">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
<form action="${pageContext.request.contextPath}/pay/payComplete" method="post" id="payform" onsubmit="payformSubmit()">
	<div>
	<input type="hidden" name="buy_method" value="${buy_method}" />
		<div class="cart_header">
		    	<h1 id ="cart_title">주문/결제</h1>
		    	<div class="rightAlign">
			    	<h2 id="cart_later">1.장바구니 ></h2>
			    	<h2 id="cart_subtitle">2.주문/결제 </h2>
			    	<h2 id="cart_later">> 3.주문완료</h2>	 
			    </div>   
		    </div>
		<table id="goodsTable" class="goodsTable">
		<thead class="goodsThead">
			<tr>
				<th><p>썸네일</p></th>
				<th><p>상품명</p></th>
				<th><p>옵션</p></th>
				<th><p>개수</p></th>
				<th><p>총금액</p></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="gList" items="${goodsList }">
			<tr>
			<c:choose>
			<c:when test="${not empty gList.goods_thumnail}">
				<td rowspan="2"><img alt="상품 이미지" src="/myct/img/goods/${gList.goods_thumnail }.jpg" class="goodsImage"> </td>
			</c:when>
			<c:otherwise>
				<td rowspan="2"><div class="emptyGoodsImage"> </td>
			</c:otherwise>
			</c:choose>
				<td rowspan="2"><strong class="goodsName">${gList.goods_name }</p strong><input type="hidden" value="${gList.goods_no }" name="goods_no"/></td>
				<td><p class="goodsOption">${gList.option_name }</p><input type="hidden" value="${gList.option_no }" name="option_no"/></td>
				<td rowspan="2"><p class="goodsCnt">X${gList.goods_cnt } 개</p><input type="hidden" value="${gList.goods_cnt }" name="goods_cnt"/></td>
				<td><p class="goodsFinalPrice">${gList.goods_final_price }원</p><input type="hidden" value="${gList.goods_final_price }" name="goods_final_price"/></td>
			</tr>
			<tr>
				<td><p class="goodsOptionPrice">+${gList.option_price }</p> <input type="hidden" name="cart_no" value="${gList.cart_no }" /> </td>
				<td><p class="goodsDeliverPrice">배달비 0원</p></td>
			</tr>
			</c:forEach>
		</tbody>
		
		<tfoot>
		<tr>
			<td colspan="5">
	    	<div class="totalprice-division-line"></div>
			</td>
		</tr>
			<tr>
				<td colspan="2"></td>
				<td><strong class="goodsAllSumPrice">총 합계</strong></td>
				<td><input type="text" value="${total_amt }" class="amountReadOnlyText" readonly></td>
				<td><strong class="goodsAllSumPrice">원</strong></td>
			</tr>
		</tfoot>
		</table>
	</div>
    <div class="title-division-line"></div>

	<div>
		<h1>배송 정보</h1>
		<select id="deliver_combobox" onchange="OnComboChange(this.value)" class="deliverCombo">
			<option value="0">직접입력</option>
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
			<td><input type="text" id="addr1" onclick="daumMapFunc()" name="addr1" readonly/><br>
			<input type="text" id="addr2" name="addr2" />
			</td>
		</tr>
		<tr>
			<td><p>우편번호</p></td>
			<td><input type="text" id="zipcode" name="zipcode" onclick="daumMapFunc()" readonly/> </td>
		</tr>
		<tr>
			<td><p>배송 메시지</p></td>
			<td><input type="text" id="notice" name="notice"/> </td>
		</tr>
	</table>
    <div class="title-division-line"></div>
	</div>
	<div id="payInfo">
		<h1>결제 정보</h1>
		<%--마일리지 정보 --%>
		<h2>현재 마일리지</h2>
		<input type="number" value="0" onfocusout="mileageChange()" name="mileage" id="mileage"><p>/${mileage }원</p>
		<%-- 아임포트 --%>
		<input type="button" onclick="kginicis()" class="pay CreditPay"></input>
		<input type="button" onclick="tosspay()" class="pay TossPay"></input>
		<input type="button" onclick="kakaopay()" class="pay KakaoPay"></input>
		<input type="button" onclick="bankpay()" value="무통장입금" class="pay BankPay"/>
		<br><div id="additionalPayInfo"></div>
	</div>
</form>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>






</body>

</html>