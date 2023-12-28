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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
<script>
	var mem_no = "${sessionScope.loginInfo.member_no}";
	
	function alignTypeBtnClicked(alignType) {
		/*let href = "${pageContext.request.contextPath}"+ "/review/shoppingReview?";
		href += "goods_no=${map.goods_no}";
		href += "&alignType="+alignType;
		href += "&page_no=1"
		location.replace(href);*/
		getReview(1,alignType);
	}

	function PageBtnClicked(pagecnt) {
		/*let href = "${pageContext.request.contextPath}"+ "/review/shoppingReview?";
		href += "goods_no=${map.goods_no}";
		href += "&alignType="+"${map.alignType}";
		href += "&page_no="+pagecnt;
		location.replace(href);*/

		getReview(pagecnt,${map.alignType});
	}
	function onLikeClicked(review_no,e){
	//로그인 되어있는지 확인
		//로그인 되어있으면
		console.log("{"+review_no+"}");
		if(mem_no != ""){
			//ajax 호출하고
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/review/like",
				data: {mem_no: mem_no,
					   review_no: review_no},
				success: function(data){
					if(data == "T"){
						$(e).attr("src","${pageContext.request.contextPath}/img/ico_like2.png");
						$(e).attr("onclick","onLikeCancled("+review_no+",this)");
					}else if(data =="F"){
						alert("이미 처리되었습니다.")
					}else{//F
						alert("좋아요 처리 안됨");
					}
				},
				error: function(data){
					alert("처리하지 못하였습니다.");
				}
			});
		}
		else{
			alert("로그인 후 이용해주세요!");
		}
		//안되어있으면
		//반응 안함
	}
	function onLikeCancled(review_no,e){
		//로그인 되어있는지 확인
		//로그인 되어있으면
		console.log("{"+review_no+"}");
		if(mem_no!=""){
			//ajax 호출하고
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/review/dislike",
				data: {mem_no: mem_no,
					   review_no: review_no},
				success: function(data){
					if(data == "T"){
						$(e).attr("src","${pageContext.request.contextPath}/img/ico_like.png");
						$(e).attr("onclick","onLikeClicked("+review_no+",this)");
					}else if(data =="D"){
						alert("이미 처리하였습니다.");
					}else{//F
						alert("처리하지 못하였습니다.");
					}
				},
				error: function(data){
					alert("처리하지 못하였습니다.");
				}
			});
		}
		else{
			alert("로그인 후 이용해주세요!");
		}
		
	}
	function onEditBtnClicked(review_no){
		let href = "${pageContext.request.contextPath}"+ "/review/modify?";
		href += "review_no="+review_no;
		location.replace(href);		
	}
	function onDeleteBtnClicked(review_no){
		//삭제할건지 alert 띄움
		let returnVal = confirm('해당 리뷰를 삭제하시겠습니까?');
		if(returnVal){
			//리뷰 삭제 실행 후 리로드
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/review/delete",
				data: {review_no: review_no},
				success: function(data){
					if(data == "T"){
						alert("삭제 완료 됨");
						//리로드
					}else{//F
						alert("처리하지 못하였습니다.");
					}
				},
				error: function(data){
					alert("처리하지 못하였습니다.");
				}
			});
		}
		//아무것도 안함
	}
</script>
<style type="text/css">
/*정렬들*/
body {
    font-family: 'Arial', sans-serif;
    line-height: 1.5;
    color: #333;
    padding: 20px;
    background-color: #f4f4f4;
}


.alignList {
    display: flex;
    justify-content: start; 
    gap: 10px;
    list-style: none; 
    padding: 0; 
    margin-bottom: 20px;
}

.alignList > li {
    background-color: #CEDEBD;
    color: #435334;
    font-size: 14px; 
    font-weight: bold;
    text-align: center;
    padding: 10px 15px; 
    cursor: pointer;
    border-radius: 10px; 
    transition: background-color 0.2s; 
    margin-right: 10px; 
}

.alignList > li:hover {
    background-color: #b0c9a7; 
}


progress {
    -webkit-appearance: none;
    appearance: none;
    width: 100%;
    height: 15px; 
    border-radius: 5px;
}

progress::-webkit-progress-bar {
    background-color: #CEDEBD;
    border-radius: 5px;
}

progress::-webkit-progress-value {
    background-color: #F9B572;
    border-radius: 5px;
}


.reviewImg {
    width: 100px; 
    height: 100px; 
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}


.points, .likes > input[type='image'] {
    margin: 5px 0;
}

.likes > input[type='image'] {
    width: 40px; 
    height: 40px;
    transition: transform 0.3s ease;
}

.likes > input[type='image']:hover {
    transform: scale(1.1);
}


.eachItems {
    background-color: #fff;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.eachItemTexts, .itemContentBtn {
    margin-bottom: 10px;
}

.nickname, .itemContentBtn .itemBtns {
    font-weight: bold;
}

.itemContentAndBtns {
    display: flex;
    justify-content: space-between; 
    align-items: center; 
}

.itemContentAndImg {
 
    flex-grow: 1; 
}

.itemBtns {
    
    display: flex;
    justify-content: flex-end;
    align-items: center;
}


.likes > input[type='image'] {
   
    cursor: pointer; 
}


@media (max-width: 768px) {
    .eachItems, .alignList {
        padding: 10px;
    }
}
.productReviewTitle {
    font-size: 24px;
   
}

.point {
	font-size: 24px;
}


</style>
</head>
<body>
    <div>
        <strong class="productReviewTitle">상품리뷰 ${map.total_cnt}건</strong>
    </div>
    
	<%-- 정렬 선택 --%>
    <ul class="alignList">
        <li><a onclick="alignTypeBtnClicked('regist_desc')">최신순</a></li>
        <li><a onclick="alignTypeBtnClicked('regist_asc')">오래된순</a></li>
        <li><a onclick="alignTypeBtnClicked('point_desc')">평점 높은순</a></li>
        <li><a onclick="alignTypeBtnClicked('point_asc')">평점 낮은순</a></li>
        <li><a onclick="alignTypeBtnClicked('like_desc')">공감 순</a></li>
    </ul>
    
    <br>
    <br>
    <ul>
        <c:if test="${map.total_cnt != 0 }">
    	<%-- 평균 데이터 --%>
    	<li>
    		<div class="headUserAvgPointConst">
    			<p class="point">사용자 평균 평점</p><br>	
    			<%--progress min="0" max="5" value="${map.avg_point }" ></progress--%>
    			<input type="hidden" value="${map.avg_point_display }"/>
    			<div class="points">
						<c:if test="${map.avg_point_display == 1}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${map.avg_point_display > 1}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${map.avg_point_display < 1 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${map.avg_point_display == 3}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${map.avg_point_display > 3}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${map.avg_point_display < 3 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${map.avg_point_display == 5}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${map.avg_point_display > 5}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${map.avg_point_display < 5 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${map.avg_point_display == 7}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${map.avg_point_display > 7}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${map.avg_point_display < 7 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${map.avg_point_display == 9}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${map.avg_point_display > 9}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${map.avg_point_display < 9 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        	</div>
    			<p>${map.avg_point }</p>
    			<br>
    		</div>
    		<%--
    		<div class="headPointRatio">
    		<p>평점 비율 </p>
	    		<ul>
		    		<li>
		    			<progress min="0" max="${map.total_cnt }" value="${map.point_5}"></progress>
			    		<p>${map.point_5 }명</p><br>
			    		<p>5점</p>
		    		</li>
		    		<li>
		    			<progress min="0" max="${map.total_cnt }" value="${map.point_4}"></progress>
		    			<p>${map.point_4 }명</p>
		    			<p>4점</p>
	    			</li>
		    		<li>
		    			<progress min="0" max="${map.total_cnt }" value="${map.point_3}"></progress>
		    			<p>${map.point_3 }명</p>
		    			<p>3점</p>
	    			</li>
		    		<li>
		    			<progress min="0" max="${map.total_cnt }" value="${map.point_2}"></progress>
		    			<p>${map.point_2 }명</p>
		    			<p>2점</p>
	    			</li>
		    		<li>
		    			<progress min="0" max="${map.total_cnt }" value="${map.point_1}"></progress>
		    			<p>${map.point_1 }명</p>
		    			<p>1점</p>
	    			</li>
	    		</ul>
    		</div> --%>
    	</li>
	        <%-- 실제 데이터 --%>
	        <c:forEach var="vo" items="${map.list }">
		        <li class="eachItems">
		        	<%-- 평점 --%>
		        	<div class="eachItemTexts">
		        	<div class="points">
						<c:if test="${vo.point == 1}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${vo.point > 1}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${vo.point < 1 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${vo.point == 3}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${vo.point > 3}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${vo.point < 3 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${vo.point == 5}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${vo.point > 5}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${vo.point < 5 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${vo.point == 7}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${vo.point > 7}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${vo.point < 7 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        		<c:if test="${vo.point == 9}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_half.png" alt="star_half">
		        		</c:if>
		        		<c:if test="${vo.point > 9}">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_on.png" alt="star_on">
		        		</c:if>
		        		<c:if test="${vo.point < 9 }">
		        		<img src="${pageContext.request.contextPath}/img/ico_star_off.png" alt="star_off">
		        		</c:if>
		        	</div>
		        	<p class="nickname">${vo.member_name }</p>
		        	<p>${vo.regist_date }</p>
		        	</div>
		        	<div class="itemContentBtn">
		        	<div class="itemContentAndImg">
		        	<p>${vo.content }</p>
		        	<c:choose>
		        		<%-- 이미지 출력 --%>
		        		<c:when test="${not empty vo.image }">
		        			<img alt="" src="${vo.blobToImage() }" class="reviewImg">
		        		</c:when>
		        	</c:choose>
		        	</div>
		        	<div class="itemBtns">
		        	<c:choose>
		        		<c:when test="${ empty sessionScope.loginInfo.member_no  || vo.member_no ne sessionScope.loginInfo.member_no}">
		        			<div class="likes">
		        			<%-- 내 글이 아니고 --%>
		        			<c:choose>
		        				<c:when test="${vo.self_like eq 0 }">
		        					<%-- 좋아요 안눌렀으면 --%>
		        					<input type="image" alt="이 리뷰가 좋아요"  src="${pageContext.request.contextPath}/img/ico_like.png" onclick="onLikeClicked(${vo.review_no},this)"/>
		        				</c:when>
		        				<c:otherwise>
		        					<%-- 좋아요 누른 상태면 --%>
		        					<input type="image" alt="좋아요 취소" src="${pageContext.request.contextPath}/img/ico_like2.png" onclick="onLikeCancled(${vo.review_no},this)" />
		        				</c:otherwise>
		        			</c:choose>
       						</div>
		        		</c:when>
		        		<c:otherwise>
		        		<div class="eachItemVal">
		        			<%-- 내 글이면 수정하고  --%>
		        			<input type="button" alt="수정버튼" value="수정" onclick="onEditBtnClicked(${vo.review_no})"/>
		        			<input type="button" alt="삭제버튼" value="삭제" onclick="onDeleteBtnClicked(${vo.review_no})"/>
	        			</div>
		        		</c:otherwise>
		        	</c:choose>
		        	</div>
		        	</div>
	        	</li>
	        </c:forEach>
        </c:if>
        <c:if test="${map.total_cnt eq 0 }">
        <strong>리뷰가 없습니다. 당신이 첫 리뷰의 주인공이 되어주세요!</strong>
        </c:if>
    </table>
    <div>
    <%-- 페이지 --%>
        <c:if test="${map.total_cnt > 0 }">
        <c:set var="first_page" value="${map.page / 5 }"></c:set>
       
        <ul>
        	<c:if test="page <= 5">
        		<li><a onclick="PageBtnClicked('${map.prev_page}'">&lt;</a></li>
        	</c:if>
        	<c:forEach var="page_num" items="${map.page_list }">
        		<li><a onclick="PageBtnClicked('${page_num}')">${page_num }</a></li>
        	</c:forEach>
        	<c:if test="${map.nextpageable }">
        		<li><a onclick="PageBtnClicked('${map.next_page}'">&gt;</a></li>
        	</c:if>
        </ul>
        </c:if>
    </div>
</body>
</html>