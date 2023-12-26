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
				var url="${pageContext.request.contextPath}/pay/pay?=goods_no="+goods_no+"&option_no="+option_no+"&goods_cnt="+goods_cnt;
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

	
	//문의 작성 버튼 클릭시 폼 나타나기
	
	$(document).ready(function(){
		$(".writeform").hide();
		
		//문의 작성하기 버튼 클릭시 로그인 여부 확인후 폼 보이기
		$(".writebtn").on("click",function(){
			var mem_no = "${sessionScope.loginInfo.member_no}";
			if(mem_no!=""){
				$(".writeform").slideDown();
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

	    		    // Ajax 요청
			    	 $.post("${pageContext.request.contextPath}/detail/qnaInsert", formData, function (response) {
			    	        // 성공적으로 처리된 경우의 동작
			    	        console.log("Ajax Success:", response);
			    	        // 추가적인 동작 구현 가능

			    	        // 문의가 등록된 후 상품 상세 페이지로 이동
			    	        window.location.href = "${pageContext.request.contextPath}/detail/" + goods_no;
			    	    })
			    	    .fail(function (error) {
			    	        // 오류 발생 시의 동작
			    	        console.error("Ajax Error:", error);
			    	        // 추가적인 동작 구현 가능
			    	    });
		    
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
					<jsp:include page="/review/shoppingReview?goods_no=${item.goods_no }"/>
				</div>
				
				
				
				<!-- 상 품 문 의 -->
				<div class="itemDetailQna" id="detailQna">						
		    		<div class="qnaHeader">
						<h1 class="sub_title">상품문의</h1>
						<p class="qnaCnt"><span>총 <c:out value="${qnaCount}" />개</span></p>
						<button class="writebtn">작성하기</button>
					</div>
					<!-- 문의하기 작성 폼 -->
					<form action="${pageContext.request.contextPath}/detail/qnaInsert" method="post" class="writeform">
						<div class="qnawriter">
							<p>작성자</p>
							<input type="text" value="${qna.member_nickname }" name="member_nickname" readonly>
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
							<button class="donebtn" type="submit">작성완료</button>
							<button class="closebtn">취소</button>
						</div>
					</form>
				 	<div class="qnaList">		
				  		<table class="qnaTable">
							<thead>
								<tr>	    					
									<th>글번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>	    					
								</tr>
							</thead>
							<tbody>
							<c:if test="${empty qna}">
								<tr>
									<td class="none" colspan="4">등록된 문의가 없습니다</td>
								</tr>	    					
							</c:if>
							<c:forEach var="qna" items="${qna}">
								<tr>
									<td class="no">${qna.inquiry_no }</td>
									<td class="title">${qna.title }</td>
									<td class="writer">${qna.member_nickname }</td>
									<td class="date">${qna.inquiry_date }</td>
								</tr>
							</c:forEach>
							</tbody>
				 		</table>
					</div>
				</div>			
			</div>		   
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>


