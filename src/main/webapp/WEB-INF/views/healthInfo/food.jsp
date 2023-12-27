<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>음식 정보</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/foodStyle.css" />
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/foodScript.jsp"></script>
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
			<!-- 리스트 -->
			<div class="info">
				<!-- 검색 -->
				<div class="search">
					<div class="foodInfo-title">
						<p class="foodInfo-title-text">FOOD</p>
					</div>
					<div class="title-division-line"></div>
					<div class="search-place">
						<div id="search-box"><input type="text" id="foodName" name="foodName"></div>
						<div id="search-text"><p>검색</p></div>
					</div>
					<div class="detail-division-line"></div>
					<div class="search-tag"></div>
				</div>
				<!-- 목록 -->
				<div class="list">
					<div class="list-title">
		                <c:if test="${null ne foodName}"> <!-- 검색 -->
		                    <p class="list-title-text">검색 목록</p>
		                </c:if>
		                <c:if test="${null eq foodName && empty loginInfo}"> <!-- 비로그인 && 미검색 -->
		                    <p class="list-title-text">목록</p>
		                </c:if>
		                <c:if test="${null eq foodName && !empty loginInfo}"> <!-- 로그인 && 미검색 -->
		                    <p class="list-title-text">즐겨찾기 목록</p>
		                </c:if>
		            </div>
					<div class="list-division-line">
						<img>
						<p>검색 결과: <span class="sql-text">${foodDic.size()}</span>개</p>
					</div>
					<div class="list-result">
						<table class="foodDic-list">
							<tbody id="foodTbody">
							<!-- 로그인 -->
							<c:if test="${null ne foodName && empty foodDic}"> <!-- 목록 없음 -->
								<colgroup>
									<col width="100%" />
								</colgroup>
	               				<tr><td class="empty-foodlist">검색 결과가 없습니다.</td></tr>	
							</c:if>
							<c:if test="${!empty loginInfo && empty foodDic}"> <!-- 로그인 && 목록 없음 -->
								<colgroup>
									<col width="100%" />
								</colgroup>
	               				<tr><td class="empty-foodlist">즐겨찾기 목록이 없습니다.</td></tr>	
							</c:if>
							<c:if test="${!empty foodDic}">
								<colgroup>
									<col width="10%" />
									<col width="70%" />
									<col width="20%" />
								</colgroup>
								<c:forEach var="foodDic" items="${retMap.list}">
									<tr class="food-info" data-no="${foodDic.no }" data-bookmarkno="${foodDic.bookmarkNo}">
										<td class="bookmark" style="color: ${foodDic.bookmarkNo ne null ? 'gold': ''};"
											data-color="${foodDic.bookmarkNo ne null ? 'gold': ''}">&#9733;
										</td>
										<td class="food">${foodDic.food }</td>
										<td class="calorie">${foodDic.calorie }kcal/hr</td>
									</tr>
								</c:forEach>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="pagenate clear">
			    <ul class='paging'>
			    <c:if test="${retMap.prev }">
			    	<li><a href="food?page=${retMap.startPage-1 }&foodName=${foodDic.foodName}"> << </a></li>
			    </c:if>
			    <c:forEach var="p" begin="${retMap.startPage}" end="${retMap.endPage}">
			    	<c:if test="${p == foodDic.page}">
			        <li><a href='#;' class='current'>${p}</a></li>
			        </c:if>
			        <c:if test="${p != foodDic.page}">
			        <li><a href='food?page=${p}&foodName=${foodDic.foodName}'>${p}</a></li>
			        </c:if>
			    </c:forEach>
			    <c:if test="${retMap.next }">
			    	<li><a href="food?page=${retMap.endPage+1 }&foodName=${foodDic.foodName}"> >> </a></li>
			    </c:if>
			    </ul> 
			</div>
			<!-- 기록란 -->
			<div class="add-info">
				<div class="add-info-content">
					<div class="add-info-title">
						<p class="foodInfo-title-text">ADD</p>
					</div>
					<div class="title-division-line"></div>
					<div>
						<div class="foodInfo">
							<div class="date">
								<select name="intake_time" id="intake_time">
			    					<option value="" disabled selected>[필수] 섭취 시간을 입력해주세요</option>
			    					<option value="1" ${foodInfo.intake_time == 1 ? 'selected' : ''}>아침</option>
			    					<option value="2" ${foodInfo.intake_time == 2 ? 'selected' : ''}>점심</option>
			    					<option value="3" ${foodInfo.intake_time == 3 ? 'selected' : ''}>저녁</option>
			    					<option value="4" ${foodInfo.intake_time == 4 ? 'selected' : ''}>간식</option>
			    				</select>
							</div>
							<div class="detail-division-line"></div>
							<div class="foodInfo-main-detail">
								<div class="foodInfo-image">
									<div class="foodInfo-image-detail"><p>+</p></div>
								</div>
								<div class="foodInfo-text-detail">
									<div id="foodInfo-text">
										<p><span class="sql-text" id="total-calTime">0</span>kcal 섭취</p>
									</div>
									<div id="foodInfo-graph"></div>
									<div id="foodInfo-total-data">
										<div id="foodInfo-total-carbs">
											<div class="foodInfo-color" id="carbs-color"></div>
											<div id="carbs-text">탄수화물</div>
											<div id="carbs-val"></div>
										</div>
										<div id="foodInfo-total-protein">
											<div class="foodInfo-color" id="protein-color"></div>
											<div id="protein-text">단백질</div>
											<div id="protein-val"></div>
										</div>
										<div id="foodInfo-total-fat">
											<div class="foodInfo-color" id="fat-color"></div>
											<div id="fat-text">지방</div>
											<div id="fat-val"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="foodInfo-cart"></div>
					<!-- foodInfo-cart에 들어가는 자바스크립트 입력 코드
					<div class="foodInfo-select">
						<div class="foodInfo-detail">
							<div class="bookmark">별</div>
							<div class="foodInfo-name">
								<div class="foodInfo-name-text">고구마</div>
								<div class="foodInfo-name-time">100g</div>
							</div>
							<div class="foodInfo-cals">124kcal</div>
							<div class="foodInfo-del">-</div>
						</div>
						<div class="detail-division-line"></div>
					</div>
					-->
					<button class="select-info" type="submit">기록하기</button>
					<%-- 이미 입력 값이 없으면
	                <c:if test="${ }}">
	                    <button class="select-info" type="submit" onclick="">기록 완료</button>
	                </c:if>
	                <c:if test="${ }">
	                    <button class="select-info" type="submit" onclick="">수정</button>
	                </c:if>
	                --%>
				</div>
			</div>
			<!-- 모달 팝업 -->
    		<div id="modalWrap">
    			<div id="modalContent">
    			  	<div id="modalBody">
    			  		<!-- 닫기 버튼 -->
    			  		<span id="closeBtn">&times;</span>
    			  		<!-- 팝업 내용 -->
    			  		<div id="modalBody-content">
    			  			<div id="modalBody-title">
    			  				<div id="modalBody-title-text"></div>
    			  				<div class="title-division-line"></div>
    			  			</div>
    			  			<div id="modalBody-main">
    			  				<div id="modalBody-exercise">
	    			  				<div class="modalBody-result" id="modalBody-time">
	    			  					<div class="modalBody-text">분량(g)</div>
	    			  					<div class="modalBody-input">
		    			  					<div id="minus-button"><p>-</p></div>
			    			  				<input id="gram">
			    			  				<div id="plus-button"><p>+</p></div>
		    			  				</div>
	    			  				</div>
	    			  			</div>
    			  				<div class="modalBody-result" id="modalBody-calorie">
    			  					<div class="modalBody-text">칼로리(kcal)</div>
    			  					<div class="modalBody-input"><input id="calorie" readonly="readonly"></div>
    			  				</div>
    			  			</div>
    			  			<div id="modalBody-sub">
    			  				<div id="modalBody-sub-detail">
	    			  				<div id="modalBody-carbs">
	    			  					<div id="modalBody-carbs-text">탄수화물(g)</div>
	    			  					<div class="modalBody-carbs-sql"></div>
	    			  					<div class="modalBody-graph" id="modalBody-carbs-graph"></div>
	    			  				</div>
	    			  				<div id="modalBody-protein">
	    			  					<div id="modalBody-protein-text">단백질(g)</div>
	    			  					<div class="modalBody-carbs-sql"></div>
	    			  					<div class="modalBody-graph" id="modalBody-protein-graph"></div>
	    			  				</div>
	    			  				<div id="modalBody-fat">
	    			  					<div id="modalBody-fat-text">지방(g)</div>
	    			  					<div class="modalBody-carbs-sql"></div>
	    			  					<div class="modalBody-graph" id="modalBody-fat-graph"></div>
	    			  				</div>
	    			  				<div id="modalBody-sugar">
	    			  					<div id="modalBody-sugar-text">당류(g)</div>
	    			  					<div class="modalBody-carbs-sql"></div>
	    			  					<div class="modalBody-graph" id="modalBody-sugar-graph"></div>
	    			  				</div>
	    			  				<div id="modalBody-salt">
	    			  					<div id="modalBody-salt-text">나트륨(mg)</div>
	    			  					<div class="modalBody-carbs-sql"></div>
	    			  					<div class="modalBody-graph" id="modalBody-salt-graph"></div>
	    			  				</div>
	    			  			</div>
	    			  			<div id="modalBody-sub-text">
	    			  				<p>*(%)영양성분 기준치 : 1일 영양성분 기준치에 대한 비율</p>
	    			  				<p>*나트륨은 WHO 및 우리나라 최대 섭취 권고량에 따릅니다.</p>
    			  				</div>
    			  			</div>
    			  			<div id="modalBody-button">
    			  				<button>기록 완료</button>
    			  			</div>
    			  		</div>
    			  	</div>
	    		</div>
	    	</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>

