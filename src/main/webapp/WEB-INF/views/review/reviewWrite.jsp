<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="xyz.teamcarrot.myct.review.ReviewVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<style>
.container {
  max-width: 1200px;
  margin: 50px auto;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
/* Product Image Styling */
img[alt="상품이미지"] {
    max-width: 100%; /* Limits image width to the width of its container */
    max-height: 300px; /* Adjust this to fit your design */
    width: auto; /* Keeps image aspect ratio intact */
    height: auto; /* Keeps image aspect ratio intact */
    display: block; /* Ensures the image is on its own line */
    margin: 10px auto; /* Adds margin and centers image */
    border-radius: 5px; /* Optional: Rounds the corners of the image */
}

/* Product Name Styling */
div > strong {
    display: block; /* Makes it a block element to take the full width */
    margin: 20px 0; /* Adds some vertical spacing */
    font-size: 28px; /* Larger font size */
    color: #333; /* Optional: Sets a dark color for the text */
    text-align: center; /* Centers the text */
}

/* Form Styling */
.reviewForm {
    background-color: #fff; /* Light background for the form */
    padding: 20px; /* Padding around the form content */
    border-radius: 8px; /* Slightly rounded corners for the form */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    margin-top: 20px; /* Spacing from the previous content */
}

/* File Input Styling */
.reviewForm input[type="file"] {
    width: 17%;
    padding: 1px;
    margin-bottom: 15px; /* Spacing after the input */
    border: 2px dashed #ddd; /* Dashed border for the file input */
    border-radius: 5px;
    text-align: center;
    cursor: pointer;
    background-color: #f8f8f8;
}

/* Image Preview */
#reviewImage {
    max-width: 100%;
    max-height: 200px; /* Adjust as needed */
    height: auto;
    display: block;
    margin: 0 auto 20px; /* Centered with margin */
    border-radius: 5px;
}

/* Number Input for Rating */
.reviewForm input[type="number"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 15px;
}

/* Textarea for Review Content */
.reviewForm textarea {
    width: 100%;
    height: 150px; /* Adjustable height */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 15px;
    resize: vertical; /* Allows the user to resize vertically */
}

/* Button Styling */
.reviewForm input[type="button"],
.reviewForm input[type="submit"] {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin-right: 10px;
    transition: all 0.3s;
}

.reviewCancle {
    background-color: #f44336; /* Red color for cancel */
    color: white;
}

.reviewSubmit {
    background-color: #4CAF50; /* Green color for submit */
    color: white;
}

.reviewCancle:hover,
.reviewSubmit:hover {
    opacity: 0.8; /* Slight fade effect on hover */
}


</style>
<body>
<div class="wrap">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
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
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>

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