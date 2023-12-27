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

.alignList{
	background-color: red;
	list-style: none;
}
.alignList > li{
	float: left;
	margin-right: 5px;
	border: 1px solid black;
    color: #435334;
    font-size: 12px;
    font-weight: bold;
    text-align: center;
    width: 80px;
    height: 30px;
    cursor: pointer;
    border-radius: 10px;
    background-color: #CEDEBD;
}
progress{
appearance: none
}
/*사용자 평균 평점*/
.headUserAvgPointConst{
	display: flex;
	flex-direction: row;
}
.headUserAvgPointConst > progress{
	margin-left: 10px;
	margin-right: 10px;
}

progress::-webkit-progress-bar{
	background: #CEDEBD;
}
progress::-webkit-progress-value{
	background: #F9B572;
}
.reviewImg{
	width:120px;
	height:120px;
}

.points{
	margin-bottom: 5px;
	margin-right: 10px;
}

.likes > input[type='image']{
	width:50px;
	height:50px;
}
.eachItems{
	border-bottom: 1px solid black;
	margin-bottom: 5px;
}
.eachItemTexts{
	display: flex;
	flex-direction: row;
}
.nickname{
	margin-right: 10px;
}
.itemContentBtn{
	display: flex;
	flex-direction: row;
}
.itemBtns{
	justify-content: flex-end;
	line-height: 20px;
}
</style>
</head>
<body>
    <div>
        <strong>상품리뷰 ${map.total_cnt}건</strong>
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
    			<p>사용자 평균 평점</p><br>	
    			<progress min="0" max="5" value="${map.avg_point }" ></progress>
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
        <p>페이지 구현중입니다</p>
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