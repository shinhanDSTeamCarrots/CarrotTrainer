<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title></title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goods/cart.css"/>
	<script src="js/script.js"></script>
	
	<!-- js -->
	<script>
	$(document).ready(function () {
	    // 전체 선택 체크박스 클릭하면
	    $("#selectAll").change(function () {
	        // 모든 장바구니 내 상품들 전체 선택, 해제
	        $(".each_cartitem input[type='checkbox']").prop('checked', $(this).prop("checked"));
	        // 선택된 애들 최종 가격 합산
	        calculateTotalPrice();
	        // 삭제 버튼의 활성화/비활성화 처리
	        toggleDeleteButton();
	    });

	    // 개별 상품 체크박스 클릭시
	    $(".each_cartitem input[type='checkbox']").change(function () {
	        // 모든 개별 상품이 선택 돼있는지 체크
	        var allChecked = $(".each_cartitem input[type='checkbox']:checked").length === $(".each_cartitem input[type='checkbox']").length;
	        // 전체 선택 체크박스 상태 변경
	        $("#selectAll").prop('checked', allChecked);

	        // 선택되 애들 최종 가격 합산
	        calculateTotalPrice();
	        // 삭제 버튼의 활성화/비활성화 처리
	        toggleDeleteButton();
	    });

	    function calculateTotalPrice() {
	        var totalPrice = 0;
	        var totalDeliveryfee = 0;
			
	        $('.selectItem').each(function(index){
	        	console.log($(this));
	        	console.log(index);
	        	if($(this).prop('checked')){
	        		var itemPrice=$('.price').eq(index).val();	        		
	        		var itemCnt=$('.cnt').eq(index).val();
	        		
	        		console.log(itemPrice);
	        		totalPrice+=itemPrice*itemCnt;
	        		console.log(totalPrice);
	        	}
	        });	
	        
	        $('.calc').text('주문금액 '+totalPrice+'원 + 배송비 '+totalDeliveryfee+'원 = ');
	        $('.totalpurchase').text('총 결제금액 '+(totalPrice+totalDeliveryfee)+'원');
	    }
	 	

	    // 페이지 로딩 시 초기 계산
	    calculateTotalPrice();

	    // 삭제 버튼 클릭시 선택 상품들 삭제
	    $("#deleteSelected").click(function () {
	        var selectedItems = $(".each_cartitem input[type='checkbox']:checked");
	        if (selectedItems.length > 0) {
	            var selectedCartNos = [];
	            selectedItems.each(function () {
	                selectedCartNos.push($(this).val());
	            });

	            // ajax로 삭제할 값 넘기기
	            $.ajax({
	                type: "POST",
	                url: "${pageContext.request.contextPath}/cart/remove",
	                traditional: true, // 배열전송을 위한 설정
	                data: { cartNos: selectedCartNos },
	                success: function (result) {
	                    console.log(result);
	                    alert("선택된 상품이 삭제되었습니다.");

	                    location.reload();
	                },
	                error: function (result) {
	                    alert("상품 삭제 중 오류가 발생했습니다.");
	                }
	            });
	        } else {
	            alert("선택된 상품이 없습니다.");
	        }
	    });

	    // 삭제 버튼의 활성화/비활성화 처리
	    function toggleDeleteButton() {
	        var selectedItems = $(".each_cartitem input[type='checkbox']:checked");
	        $("#deleteSelected").prop('disabled', selectedItems.length === 0);
	    }
	});
	
	
	//결제하기 버튼 클릭시 결제창에 넘겨주기
	$(".purchase").click(function(){
		var selectedItems = $(".each_cartitem input[type='checkbox']:checked");
        if (selectedItems.length > 0) {
            var selectedCartNos = [];
            selectedItems.each(function () {
                selectedCartNos.push($(this).val());
            });
            
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/pay/cart",
                traditional: true, // 배열전송을 위한 설정
                data: { cartNos: selectedCartNos },
                success: function (result) {
                    console.log(result);
                },
                error: function (result) {
                }
            });
        } else {
            alert("선택된 상품이 없습니다.");
        }
    });
	
	</script>
	
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    	
		    <!--  장바구니 진행 위치 -->
		    <div class="cart_header">
		    	<h1 id ="cart_title">장바구니</h1>
		    	<div class="rightAlign">
			    	<h2 id="cart_subtitle">1.장바구니 ></h2>
			    	<h2 id="cart_later"> 2.주문/결제 > 3.주문완료</h2>	 
			    </div>   
		    </div>
		    
		    <!-- 전체 선택 삭제 -->
		    <div class="select_all">
		    	<input type="checkbox" id = "selectAll" checked="checked">
		    	<label for ="selectAll">전체 선택</label>
		    	<button id="deleteSelected"><img src="/myct/img/trashcan.png"></button>
		    </div>
		    
		    <!-- 장바구니 담긴 목록 보여주기 -->
		    <div class="cart_list">
		    	<div class="each_cartitem">
		    		<ul>
						<c:forEach items="${cartList}" var="cartList">
						<input type="hidden" class="price" value="${cartList.final_price}">
						<input type="hidden" class="cnt" value="${cartList.goods_count}">
						<div class="title-division-line"></div>
						<li>
						<div class="eachItem">
							<div class="">
								<input type="checkbox" class = "selectItem" value="${cartList.cart_no }" checked="checked">
							</div>
							<div class="goodsImg">
								<img id="cartgoodsImg" src="/myct/img/goods/${cartList.image }.jpg"/>
							</div>
							<div class="itemInfo">
								<div class="goodsName">
									${cartList.goods_name}
								</div>	
								<div class="optionInfo">
									<c:if test="${not empty cartList.option_no}">
										<div class="goodsOption">
											선택옵션 : ${cartList.option_name}
										</div>
										<div class="rightalign">
											<div class="itemCnt">
												${cartList.goods_count}
											</div>
											<div class="itemPrice">
												${cartList.final_price}원
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						</li>						
						</c:forEach>
	   				</ul>	    	
		    	</div>	    
		    </div>
		    
		    
		    <div class="totalprice-division-line"></div>
		    
		    <!-- 총 가격 합산 -->
			<div class="totalPrice">
				<div class="priceText">
					<div class="calc"></div>
        			<div class="totalpurchase"></div>
				</div>
			</div>	 
		    <div class="title-division-line"></div>
		    
		    <!-- 결제하기 버튼 -->
		    <div class="purchaseButton">
		    	<button class="purchase">결제하기</button>
		    </div>
		    
	    
	    
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
