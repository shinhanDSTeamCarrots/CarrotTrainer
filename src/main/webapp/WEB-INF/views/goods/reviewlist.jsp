<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function alignTypeBtnClicked(alignType) {
		let href = "${pageContext.request.contextPath}"+ "/review/shoppingReview.do?";
		href += "goods_no=${map.goods_no}";
		href += "&alignType="+alignType;
		href += "&page_no=1"
		location.replace(href);
	}

	function PageBtnClicked(pagecnt) {
		let href = "${pageContext.request.contextPath}"+ "/review/shoppingReview.do?";
		href += "goods_no=${map.goods_no}";
		href += "&alignType="+"${map.alignType}";
		href += "&page_no="+pagecnt;
		location.replace(href);
	}
</script>
</head>
<body>
    <div>
        <strong>상품리뷰 ${map.total_cnt}건</strong>
    </div>
	<!-- 정렬 선택 -->
    <ul>
        <li><a onclick="alignTypeBtnClicked('regist_desc')">최신순</a></li>
        <li><a onclick="alignTypeBtnClicked('regist_asc')">오래된순</a></li>
        <li><a onclick="alignTypeBtnClicked('point_desc')">평점 높은순</a></li>
        <li><a onclick="alignTypeBtnClicked('point_asc')">평점 낮은순</a></li>
        <li><a onclick="alignTypeBtnClicked('like_desc')">공감 순</a></li>
    </ul>
    <div>
    </div>
    <ul>
        <c:if test="${map.total_cnt != 0 }">
    	<!-- 평균 데이터 -->
    	<li>
    		<div>
    			<p>사용자 평균 평점</p><br>	
    			<progress min="0" max="5" value="${map.avg_point }" ></progress>
    			<p>${map.avg_point }</p>
    			<br>
    		</div>
    		<div>
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
    		</div>
    	</li>
	        <!-- 실제 데이터 -->
	        <c:forEach var="vo" items="${map.list }">
				        <!-- 위 정보 -->
		        <li>
		        	<!-- 평점 -->
		        	<div>
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
		        	<br>
		        	<p>${vo.regist_date }</p>
		        	<p>${vo.content }</p>
	        	</li>
	        </c:forEach>
        </c:if>
        <c:if test="${map.total_cnt eq 0 }">
        <strong>리뷰가 없습니다. 당신이 첫 리뷰의 주인공이 되어주세요!</strong>
        </c:if>
    </table>
    <div>
    <!-- 페이지 -->
    
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