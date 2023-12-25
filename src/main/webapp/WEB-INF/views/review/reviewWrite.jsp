<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="xyz.teamcarrot.myct.review.ReviewVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div>개발자 리뷰 테스트</div>
<div>
	<%-- 상품정보 --%>
	<%--이미지 / 이름 옵션 종류 출력 --%>
	<strong>${gData.goods_name }</strong><br>
	<img alt="상품이미지" src="/myct/img/goods/${gData.image }.jpg"/>
</div>
<hr>
<form action="${pageContext.request.contextPath}/review/write" method="post" class="reviewForm form" onsubmit="OnSubmit()" id="reviewForm">
	<div>
		<%-- 이미지 --%>
		<input type="file" onchange="toBase64(event)" id="review_file" class="reviewFile_Btn" accept="image/*"/>
		<c:choose>
			<c:when test="${mode eq 'm' && not empty ReviewVO.image }">
				<img alt="리뷰이미지" id="reviewImage" src="${ReviewVO.blobToImage() }"/>
				<input type="hidden" name="imgstr" id="imageBase64" />
			</c:when>
			<c:otherwise>
				<img alt="리뷰이미지" id="reviewImage"/>
				<input type="hidden" name="imgstr" id="imageBase64"/>
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<%-- 별점. 나중에는 드래그방식이나 클릭으로 --%>
		<c:if test="${mode eq 'w' }">
		</c:if>
		<c:if test="${mode eq 'm' }">
		</c:if>
		<c:if test="${mode eq 'w' }">
			<input id="review_point" type="number" value="1" min="1" max="10" onchange="onChangeVal()" name="point" />
		</c:if>
		<c:if test="${mode eq 'm' }">
			<input id="review_point" type="number" value="${ReviewVO.point }" min="1" max="10" onchange="onChangeVal()" name="point" />
		</c:if>
	</div>
	<div>
		<%-- 리뷰 입력 --%>
		<textarea id="review_text" placeholder="리뷰를 입력해주세요" onchange="onChangeVal()" name="content" ><c:if test="${mode eq 'm' }">${ReviewVO.content }</c:if></textarea>
	</div>
	<input type="button" value="취소" class="reviewCancle cancle" id="btn_reviewCancle" onclick="OnCancle()"/>
	<input type="submit" value="등록" class="reviewSubmit submit" id="btn_reviewSubmit"/>
</form>

</body>

<script type="text/javascript">
	var point_ele;
	var text_ele;
	var btn_submit;
	var btn_cancle;
	var reviewForm;
	let issubmitable = false;
	$(window).ready(function(){
		point_ele = $('#review_point');
		text_ele = $('#review_text');
		btn_submit = $('#btn_reviewSubmit');
		btn_cancle = $('#btn_reviewCancle').get(0);
		reviewForm = $('#reviewForm'); 
	});
	function toBase64(event) {
		let reader = new FileReader();
		reader.readAsDataURL(event.target.files[0]);
		reader.onload = function(event) {
			var base64 = event.target.result;
			console.log("var: "+base64);
			$('#imageBase64').val(base64);
			$('#reviewImage').attr("src",event.target.result);
		}
	}
	function onChangeVal() {
		if(text_ele.get(0).value.trim() == "" || point_ele.get(0).value.trim() == ""){
			//버튼 승인 불가능하게
			issubmitable = false;
			btn_submit.attr("disabled",true);
		}else{
			issubmitable = true;
			btn_submit.removeAttr("disabled"); 
		}
	}
	function OnSubmit(){
		if(!issubmitable && "${mode}" == "C"){
			return false;
		}
		//goods_no 전송
		let goods_no = $("<input type='hidden' value='${goods_no}' name='goods_no' readonly>");
		//리뷰 수정모드/생성모드 체크
		let mode = $("<input type='hidden' value='${mode}' name='mode' readonly>");
		
		
		if("${mode}" == "m"){
			let reviewNo = $("<input type='hidden' value='${ReviewNo}' name='review_no' readonly>");
			reviewForm.append(reviewNo);
		}
		
		reviewForm.append(goods_no);
		reviewForm.append(mode);
		//reviewForm.submit();
	}
	function OnCancle(){
		alert("취소하셨습니다.");
		let href = "${pageContext.request.contextPath}";
		location.replace(href);
	}
</script>
</html>