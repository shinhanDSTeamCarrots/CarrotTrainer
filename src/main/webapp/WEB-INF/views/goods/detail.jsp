<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>상품상세</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goods/detail.css"/>
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	
	
	<!-- js -->
	<script>
	function cartbtn(){
		//로그인 여부 확인
		//로그인 여부확인 -> 장바구니 존재 여부확인 -> 장바구니에 담기
		//안돼있으면 로그인이 필요한 서비스입니다 (로그인 창으로 이동하시겠습니까?)
		var mem_no = "${sessionScope.loginInfo.member_no}";
		let goods_no="${item.goods_no}";
		let option_no=$("#selectedoption :selected").val();
		//옵션이 없는 상품의 경우
		if (!option_no) {
	        option_no = 0;
	    }
		console.log("${pageContext.request.contextPath}/cart/add");
		console.log("option_no: "+option_no);
		//로그인 여부 확인후
		if(mem_no!=""){
			//ajax호출
			//장바구니에 이미 담긴 상품인지 확인
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/cart/check",
				data:{mem_no:mem_no,
					goods_no:goods_no,
					},
				//이미 담긴 상품이면 장바구니로 이동
				success:function(result){
					if(result=="EXIST"){							
						var str="이미 장바구니에 담긴 상품입니다. 장바구니로 이동하시겠습니까?";
						if(confirm(str)){
							window.location.href="${pageContext.request.contextPath}/cart";
						}
					//장바구니에 안담겨 있을 시 장바구니 추가
					}else{
						$.ajax({
							type:"POST",
							url:"${pageContext.request.contextPath}/cart/add",
							data:{
								mem_no:mem_no,
								goods_no:goods_no,
								option_no:option_no,
								goods_count:1
							},
							success:function(data){
								console.log(data);
								if(data=="T"){																		
									var str="장바구니에 상품이 담겼습니다. 장바구니로 이동하시겠습니까?";
									console.log(str);
									if(confirm(str)){
										
										window.location.href="${pageContext.request.contextPath}/cart";
									}
								}
							},
							error:function(data){
					        	alert("필수 옵션을 선택해 주세요.");
							}
						});
					}
				},
				error:function(data){
					alert("장바구니 담기 실패ㅜ");
				}
			});
		}else{
			var str="로그인이 필요한 서비스입니다! 로그인 화면으로 이동하시겠습니까?";
			if(confirm(str)){
				window.location.href="${pageContext.request.contextPath}/member/login";
			}		
		}		
	}
	
	//상품상세에서 바로 구매하기 버튼 클릭시
	function purchaesbtn(){
		var mem_no = "${sessionScope.loginInfo.member_no}";
		let goods_no="${item.goods_no}";
		let option_no=$("#selectedoption :selected").val();
		let goods_cnt= 1;
		//옵션이 없는 상품의 경우
		if (!option_no) {
	        option_no = 0;
	    }
		
		//로그인 여부 확인후
		if(mem_no!=""){
			//옵션이 없는 상품이거나 옵션 선택을 한 경우
			if (option_no==0 || option_no !=="[필수]옵션을선택해주세요"){
				console.log("option_no: "+option_no);
				var url="${pageContext.request.contextPath}/pay/pay?goods_no="+goods_no+"&option_no="+option_no+"&goods_cnt="+goods_cnt;
				window.location.href=url;
			}else{
				alert("필수 옵션을 선택해 주세요.");
			}
		}else{
			var str="로그인이 필요한 서비스입니다! 로그인 화면으로 이동하시겠습니까?";
			if(confirm(str)){
				window.location.href="${pageContext.request.contextPath}/member/login";
			}		
		}		
	}
    
    //------------- 리뷰 ------------------ 
	function getReview(page, aligntype) {
		$.ajax({
			url: "${pageContext.request.contextPath}/review/shoppingReview",
			data: {
				goods_no: ${item.goods_no },
				alignType: aligntype,
				page_no: page,
				
			},
			success: function(res) {
				$("#detailReview").html(res);
			}
		});
	}
	
	$(function() {
		getReview(1,"");
	});
    
	
	//------------- 문의 -----------------
	
	//json타입의 시간을 년월일시분초로 변환해주는 함수
	function convertTimestampToFormattedDate(timestamp) {
		  var date = new Date(timestamp);
				
		  var year = date.getFullYear();
		  var month = ('0' + (date.getMonth() + 1)).slice(-2);
		  var day = ('0' + date.getDate()).slice(-2);


		  return year + '-' + month + '-' + day ;
	}
	
	//문의 list 가져오기
	function loadQnaList() {
	    var goods_no = "${item.goods_no}"; // 현재 상품의 번호
	    $.ajax({
	        type: "GET",
	        url: "${pageContext.request.contextPath}/detail/" + goods_no + "/qnaList",
	        dataType: "json",
	        cache:false,
	        success: function(qnaList) {
	            
	            console.log(qnaList); 
	            
	            var qnaTableBody = $("#qnaTableBody");
	            qnaTableBody.empty();

	            if (qnaList.length === 0) {
	                var row = $("<tr>");
	                row.append("<td class='first' colspan='8'>등록된 문의가 없습니다.</td>");
	                qnaTableBody.append(row);
	            } else {
	                for (var i = 0; i < qnaList.length; i++) {
	                    var qna = qnaList[i];
	                    var no=qnaList.length - i;
	                    var row = $("<tr>");
	                    row.append("<td class='no'>" + no + "</td>");
	                    row.append("<td class='title'>" + getTitleText(qna) + "</td>");
	                    row.append("<td class='writer'>" + qna.member_nickname + "</td>");
	                    row.append("<td class='date'>" + convertTimestampToFormattedDate(qna.inquiry_date) + "</td>");
	                    qnaTableBody.append(row);
	                }
	               
	           }
	        },
	        error:function(qnaList){
	            console.log(error);
	        }
	    });	    
	}
	
	//비밀글 여부에 따라 제목
	function getTitleText(qna){
		var inquiryType=qna.inquiry_type;
		var titleText="";
		if(qna.is_secret==1){
			titleText = "해당문의는 비밀글입니다";
		}else{
			switch (inquiryType) {
            case 0:
                titleText = "[상품문의] " + qna.title;
                break;
            case 1:
                titleText = "[배송문의] " + qna.title;
                break;
            case 2:
                titleText = "[환불문의] " + qna.title;
                break;
            case 3:
                titleText = "[기타문의] " + qna.title;
                break;
			}
		}
		return titleText;
	}
	
	
	//문의리스트에서 제목 클릭시
	$(document).on("click","#qnaTableBody td.title",function(){
		var inquiryNo = $(this).closest("tr").find("td.no").text();
		console.log(inquiryNo);
		openQnaForm(inquiryNo);
		console.log("문의 제목 클릭됨!")
	});	
	
	//문의상세보기 폼 열기
	function openQnaForm(inquiryNo){
		
		//비밀글 여부 확인 -> 로그인정보 작성자정보 일치여부 확인
		console.log(inquiryNo + "문의 상세보기 열기!");	
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/detail/qna/" + inquiryNo,
			dataType:"json",
			success:function(qnaDetail){	
				
				console.log("문의 상세보기 ajax 성공");
				console.log(qnaDetail);
				
				var isSecret = qnaDetail.is_secret;
				var memno="${sessionScope.loginInfo.member_no}";
				var qnaMemberNo = qnaDetail.member_no;
				
				if (isSecret){
					
					console.log(memno);
					
					//비밀글 작성자, 로그인된 사람 일치시에만 조회 가능
					if (memno == qnaMemberNo){
						editForm(qnaDetail);
					}else{
						alert("이 문의는 작성자만 볼 수 있는 비밀글입니다.");
					}
				//일반글	
				}else{
					if(memno==qnaMemberNo){
						editForm(qnaDetail);
					}else{
						//문의 상세보기
						showQnaDetail(qnaDetail);
					}
				}				
			},
			error:function(qnaDetil){
				console.log(qnaDetil);
			}
		});
		
	}
	
	//문의 상세보기
	function showQnaDetail(qnaDetail){
		
		var title=qnaDetail.title;
		var content=qnaDetail.content;
		var inquiryType = qnaDetail.inquiry_type;
	    var isSecret = qnaDetail.is_secret;
	    
		$("select[name='inquiry_type']").val(inquiryType).prop("readonly",true);
		$("input[name='is_secret']:checked").val(isSecret).prop("readonly",true);
		$("input[name='title']").val(title).prop("readonly",true);
		$("input[name='content']").val(content).prop("readonly",true);
	
		$(".writeform").slideDown();
		$(".donebtn, .closebtn").hide();
		$(".editbtn, .deletebtn").hide();
	
	
	}
	//수정가능한 폼으로 전환 함수
	function editForm(qnaDetail){
		var title=qnaDetail.title;
		var content=qnaDetail.content;
		var inquiryType = qnaDetail.inquiry_type;
	    var isSecret = qnaDetail.is_secret;
		$("select[name='inquiry_type']").val(inquiryType).prop("readonly",false);
		$("input[name='is_secret']:checked").val(isSecret).prop("readonly", false);
		$("input[name='title']").val(title).prop("readonly", false);
		$("input[name='content']").val(content).prop("readonly", false);
		$(".writeform").slideDown();
		
		showEDbtns(qnaDetail);
		$(".editbtn").on("click", function(){
			updateQna(qnaDetail.inquiry_no);
			loadQnaCnt();
		})
		//문의 삭제 버튼 클릭시
		$(".deletebtn").on("click", function(){
			console.log("문의 번호 : "+ qnaDetail.inquiry_no);
			console.log("삭제 버튼이 클릭됨!");
			if (confirm("문의를 삭제하시겠습니까?")){
				deleteQna(qnaDetail.inquiry_no);			
				$(".writeform").slideUp();
			}
			loadQnaCnt();
		});
	}
	
	//문의 수정하기
	function updateQna(inquiryNo){
		var mem_no="${sessionScope.logInfo.member_no}";
		var goods_no = "${item.goods_no}";
		
		var formData = {
		 	inquiry_no: inquiryNo,
	        member_no: mem_no,
	        inquiry_type: $("select[name='inquiry_type']").val(),
	        is_secret: $("input[name='is_secret']:checked").val(),
	        title: $("input[name='title']").val(),
	        content: $("input[name='content']").val()
	    };
		$.ajax({
	       type: "POST",
	       url: "${pageContext.request.contextPath}/detail/qnaUpdate",
	       data: JSON.stringify(formData),  // 데이터를 JSON 문자열로 변환
	       contentType: "application/json",
	       success: function (response) {
	    	   if (response == "success") {
	               // 수정 성공 시 처리
	               console.log("Q&A 수정 성공");
	               $(".writeform").slideUp();
	               alert("문의가 수정되었습니다.");
	               loadQnaList();
	           } else {
	               // 수정 실패 시 처리
	               console.log("Q&A 수정 실패");
	           }
	       },
	       error:function(error){
	    	   console.log(error);
			}
		});
	}
	
	
	//문의 삭제
	function deleteQna(inquiryNo){
		console.log(inquiryNo);
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/detail/qnaDelete/" + inquiryNo,
			success:function(response){
				if(response == "success"){
				//삭제 성공시
				console.log("Q&A 삭제 성공");
				alert("문의가 삭제되었습니다");
				loadQnaList();
				
				}else{
					console.log("Q&A 삭제 실패");
				}
			},
			error:function(error){
				console.log(error);
			}
		});
	}
	
	
	function showEDbtns(qnaDetail){
		$(".editbtn, .deletebtn").show();
		$(".donebtn, .closebtn").hide();
		
	}
	
	function showWriteButtons(){
		$(".donebtn, .closebtn").show();
		$(".editbtn, .deletebtn").hide();
	}
	
	//상품별 문의 갯수 가져오기
	function loadQnaCnt(){
		var goods_no = "${item.goods_no}"; // 현재 상품의 번호
		//문의 갯수 가져오기
	    $.ajax({
	    	type:"GET",
	    	url:"${pageContext.request.contextPath}/detail/" + goods_no + "/qnaCnt",
	    	dataType:"json",
	    	success:function(qnaCnt){
	    		console.log(qnaCnt);
	    		$(".qnaCnt span").text("총" + qnaCnt + "개");
	    	},
	    	error:function(qnaCnt){
	    		console.log("갯수 출력 실패");
	    	}
	    });
	}
	
	//페이지 로드시	
	$(document).ready(function(){
		loadQnaCnt();
		//문의목록 보이기
		loadQnaList();
		
		
		$(".writeform").hide();				
		
		//문의 작성하기 버튼 클릭시 로그인 여부 확인후 폼 보이기
		$(".writebtn").on("click",function(){
			var mem_no = "${sessionScope.loginInfo.member_no}";
			if(mem_no!=""){
				$(".writeform").slideDown();
				showWriteButtons();
				//취소버튼 클릭시 폼 닫기
				$(".closebtn").on("click",function(){
					$(".writeform").slideUp();
				});
				//완료버튼 클릭시 문의 insert
			    $(".donebtn").on("click", function () {
			    	console.log("Done button clicked");			    	
					let goods_no="${item.goods_no}";
			    	 var formData = {
	    				member_no:mem_no,
	    				goods_no:goods_no,
	    		        inquiry_type: $("select[name='inquiry_type']").val(),
	    		        is_secret: $("input[name='is_secret']:checked").val(),
	    		        title: $("input[name='title']").val(),
	    		        content: $("input[name='content']").val()
	    		    };
					$.ajax({
				       type: "POST",
				       url: "${pageContext.request.contextPath}/detail/qnaInsert",
				       data: formData,
				       success: function (response) {
				    	   if (response !== "error") {
				               // 등록 성공 시 처리
				               console.log("Q&A 등록 성공");
				               $(".writeform").slideUp();
				               alert("문의가 등록됐습니다.");
				               loadQnaList();
				           } else {
				               // 등록 실패 시 처리
				               console.log("Q&A 등록 실패");
				           }
				       },
				       error: function (error) {
				           console.log(error);
				       }
				   });
					loadQnaCnt();
		        });
			}else{
				var str="로그인이 필요한 서비스입니다! 로그인 화면으로 이동하시겠습니까?";
				if(confirm(str)){
					window.location.href="${pageContext.request.contextPath}/member/login";
				}
			}
		});					
	});

	</script>
	
</head>
<style>
/* 상품문의 Section Container */
.itemDetailQna {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    padding: 20px;
    margin-top: 20px;
    border-radius: 5px;
}

.qnaHeader {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.qnaHeader .sub_title {
    font-size: 24px;
    color: #333;
    margin: 0;
}

.qnaHeader .qnaCnt {
    font-size: 16px;
    color: #666;
}

.writebtn {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.writebtn:hover {
    background-color: #0056b3;
}

/* Form Styling */
.writeform {
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.writeform p {
    margin: 0;
    color: #333;
    margin-bottom: 5px;
}

.writeform input[type="text"], .writeform select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* Buttons in Form */
.qnabtns {
    text-align: right;
}

.qnabtns button {
    margin-left: 10px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.donebtn {
    background-color: #28a745;
    color: white;
}

.closebtn {
    background-color: #dc3545;
    color: white;
}

.donebtn:hover {
    background-color: #218838;
}

.closebtn:hover {
    background-color: #c82333;
}

/* QnA List Table Styling */
.qnaTable {
    width: 100%;
    border-collapse: collapse;
}

.qnaTable th, .qnaTable td {
    text-align: left;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.qnaTable th {
    background-color: #f0f0f0;
}

.qnaTable td {
    background-color: #ffffff;
}

.qnaTable tr:hover {
    background-color: #f2f2f2;
}

</style>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<!-- 카테고리 메뉴바(카테고리 + 카테고리명 + 검색창) -->
    		<div class="goods_header">
	    		<div class="category">	
	    			<ul class="depth1">
	    				<li>
		    				<a>카테고리</a>
		    				<ul class="depth2">
			    				<li><a href="${pageContext.request.contextPath}/goodsList/1">닭가슴살</a></li>
			    				<li><a href="${pageContext.request.contextPath}/goodsList/2">도시락</a></li>
			    				<li><a href="${pageContext.request.contextPath}/goodsList/3">샐러드</a></li>	    				
		    				</ul>
	    				</li>
	    			</ul>
	    		</div>   		
		    	<!-- 상품 카테고리명 & 검색창 -->
		   		<h1><c:out value="${item.category_name }"/></h1>
		
		   		<!-- 검색창 
		   		<div class="search_wrap">
		   			<div class="search_area">
		   				<input type="text" name="search_goods" value=""> 
		    			<button id="search">검색</button>
		    		</div>
		   		</div>-->
		    </div>
		    
		    <!-- 상품 디테일 페이지 -->
		    <div class="goodsDetail">		    	
	
				<div class="goodsImg">
					<img id="goodsImg" src="/myct/img/goods/${item.image }.jpg"/>
				</div>
				<div class="goodsInfo">
					<div class="goodsName">
						<p>${item.goods_name}</p>
					</div>
					<div class="goodsPrice">
						<p>${item.price}원</p>
					</div>
					<div class="title-division-line"></div>
					<div class="deliveryfee">
						<p>배송비 |  ${item.delivery_fee }원</p>
					</div>
					<div class="title-division-line"></div>
					<div class="option">
						<c:if test="${not empty detail}">
							<select name="selectOption"  id="selectedoption">
								<option disabled selected>[필수]옵션을선택해주세요</option>
								<c:forEach items="${detail}" var="detail">
						            <c:if test="${not empty detail.option_name}">
						                <option value="${detail.option_no }">${detail.option_name}	+${detail.price_updown}원</option>
						            </c:if>
						        </c:forEach>
							</select>
						</c:if>					
					</div>
					<div class="btns">	
						<button class="cartbtn" onclick="cartbtn()">장바구니</button>
						<button class="purchasebtn" onclick="purchaesbtn()">구매하기</button>						
					</div>			
				</div>
			</div>	
			<!-- 상품상세 페이지 메뉴 바 -->
			<div class="detailMenu" id="scroll-event">
  				<ul>
   				<li><a href="#detailImage">상세설명</a></li>
    			<li><a href="#detailPurchaseInfo">구매정보</a></li>
    			<li><a href="#detailReview">상품후기</a></li>
    			<li><a href="#detailQna">상품문의</a></li>
  				</ul>
   			</div>
		
		
			<!-- 상품 상세 정보들 -->
			<div class="detailMenuContent">
				<div class="itemDetailImage" id="detailImage">
					<div class="detailImages">
				        <c:forEach var="i" begin="1" end="5">
			                <c:set var="imageDetail" value="image_detail${i}" />
			                <c:if test="${not empty item[imageDetail]}">
			                    <img src="/myct/img/goods/${item[imageDetail]}.jpg">
			                </c:if>
			            </c:forEach>
				    </div>
				</div>
				<div class="itemDetailPurchaseInfo" id="detailPurchaseInfo">
					<p>구매정보</p>
					${item.purchase_info}
				</div>
				<div class="itemDetailReview" id="detailReview">
					<p>전체 리뷰</p>
					<%--<jsp:include page="/review/shoppingReview?goods_no=${item.goods_no }"/> --%>
				</div>
				
				
				
				<!-- 상 품 문 의 -->
				<div class="itemDetailQna" id="detailQna">						
		    		<div class="qnaHeader">
						<h1 class="sub_title">상품문의</h1>
						<p class="qnaCnt"><span>총 개</span></p>

						
					</div>
					
				 	<div class="qnaList">
				 		<!-- <h2>문의목록</h2> -->
				  		<table class="qnaTable">
							
							<tbody id="qnaTableBody">
								
							
							</tbody>
				 		</table>
					</div>
					<div class="wBtn">
						<button class="writebtn">작성하기</button>
					</div>
					<!-- 문의하기 작성 폼 -->					
					<form action="${pageContext.request.contextPath}/detail/qnaInsert" method="post" class="writeform" onsubmit="return false;">
						<input type="hidden" name="goods_no" value="${item.goods_no}" />
						<div class="qnawriter">
							<p>작성자</p>
							<p class="qnaWriter">${sessionScope.loginInfo.member_nickname}</p>
						</div>
						<div class="qnacate">
							<p>문의 유형</p>
							<select name="inquiry_type">
								<option value="0">상품</option>
								<option value="1">배송</option>
								<option value="2">환불</option>
								<option value="3">기타</option>
							</select>
						</div>
						<div class="issecret">
							<p>공개 여부</p>
						    <input type="radio" id="public" name="is_secret" value="0" checked>
						    <label for="public">공개</label>
						    <input type="radio" id="private" name="is_secret" value="1">
						    <label for="private">비밀</label>
						</div>
						<div class="qnatitle">
							<p>제목</p>
							<input type="text" name="title" class="qtitle">
						</div>
						<div class="qnacontent">
							<p>문의 내용</p>
							<input type="text" name="content" class="qcontent">
						</div>
						<div class="qnabtns">
							<button class="donebtn">작성완료</button>
							<button class="closebtn">취소</button>
							<button class="editbtn">수정</button>
							<button class="deletebtn">삭제</button>
        					
						</div>
					</form>
				</div>			
			</div>		   
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>


