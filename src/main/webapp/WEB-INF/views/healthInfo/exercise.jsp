<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>운동 정보</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/exerciseStyle.css" />
	<script src="${pageContext.request.contextPath}/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/js/healthInfo/exerciseScript.jsp"></script>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<!-- 리스트 -->
			<div class="info">
				<!-- 검색 -->
				<div class="search">
					<div class="healthInfo-title">
						<p class="healthInfo-title-text">EXERCISE</p>
					</div>
					<div class="title-division-line"></div>
					<div class="search-place">
						<div id="search-box"><input type="text" id="healthName" name="healthName"></div>
						<div id="search-text"><p>검색</p></div>
					</div>
					<div class="detail-division-line"></div>
					<div class="search-tag"></div>
				</div>
				<!-- 목록 -->
				<div class="list">
					<div class="list-title">
		                <c:if test="${null ne healthName}"> <!-- 검색 -->
		                    <p class="list-title-text">검색 목록</p>
		                </c:if>
		                <c:if test="${null eq healthName && empty loginInfo}"> <!-- 비로그인 && 미검색 -->
		                    <p class="list-title-text">목록</p>
		                </c:if>
		                <c:if test="${null eq healthName && !empty loginInfo}"> <!-- 로그인 && 미검색 -->
		                    <p class="list-title-text">즐겨찾기 목록</p>
		                </c:if>
		            </div>
					<div class="list-division-line">
						<img>
						<c:if test="${null ne healthName}"> <!-- 검색 -->
							<p>검색 결과: <span class="sql-text">${healthDic.count}</span>개</p>
						</c:if>
					</div>
					<div class="list-result">
						<table class="healthDic-list">
							<tbody id="healthTbody">
							<!-- 로그인 -->
							<c:if test="${null ne healthName && empty healthDic.list}"> <!-- 목록 없음 -->
								<colgroup>
									<col width="100%" />
								</colgroup>
	               				<tr><td class="empty-healthlist">검색 결과가 없습니다.</td></tr>	
							</c:if>
							<c:if test="${!empty loginInfo && empty healthDic.list}"> <!-- 로그인 && 목록 없음 -->
								<colgroup>
									<col width="100%" />
								</colgroup>
	               				<tr><td class="empty-healthlist">즐겨찾기 목록이 없습니다.</td></tr>	
							</c:if>
							<c:if test="${!empty healthDic.list}">
								<colgroup>
									<col width="10%" />
									<col width="70%" />
									<col width="20%" />
								</colgroup>
								<c:forEach var="healthDic" items="${healthDic.list}">
									<tr class="health-info" data-healthno="${healthDic.no }" data-bookmarkno="${healthDic.bookmarkNo}">
										<td class="bookmark" style="color: ${healthDic.bookmarkNo ne null ? 'gold': ''};"
											data-color="${healthDic.bookmarkNo ne null ? 'gold': ''}">&#9733;
										</td>
										<td class="health">${healthDic.health }</td>
										<td class="calorie">${healthDic.calorie }kcal/hr</td>
									</tr>
								</c:forEach>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<c:if test="${null ne healthName || empty loginInfo}"> <!-- 비로그인, 검색 여부 상관없음 && 로그인, 검색 시 -->
				<!-- 페이징 -->
				<div class="pagenate clear">
				    <ul class='paging'>
				    <c:if test="${healthDic.prev }">
				    	<li><a href="exercise?page=${healthDic.startPage-1 }&healthName=${healthDic.healthName}"> << </a></li>
				    </c:if>
				    <c:forEach var="p" begin="${healthDic.startPage}" end="${healthDic.endPage}">
				    	<c:if test="${p == page}">
				        	<li><a href=";" class="current">${p}</a></li>
				        </c:if>
				        <c:if test="${p != page}">
				        	<li><a href="exercise?page=${p}&healthName=${healthName}">${p}</a></li>
				        </c:if>
				    </c:forEach>
				    <c:if test="${healthDic.next }">
				    	<li><a href="exercise?page=${healthDic.endPage+1 }&healthName=${healthName}"> >> </a></li>
				    </c:if>
				    </ul> 
				</div>
				</c:if>
			</div>
			<!-- 기록란 -->
			<div class="add-info">
				<div class="add-info-content">
					<div class="add-info-title">
						<p class="healthInfo-title-text">ADD</p>
					</div>
					<div class="title-division-line"></div>
					<div class="date">
						<!-- autocomplte는 <input> 태그를 클릭했을때 이전 데이터가 뜨는 것을 막기 위해 -->
						<!-- readonly는 추가해준 이유는 datepicker을 통해 삽입된 날짜 데이터를 사용자가 잘못된 형식으로 수정하지 못하도록 하기 위함 -->
						<input id="health_date" name="health_date" autocomplete="off" readonly="readonly" value="[필수] 날짜를 선택해주세요 ▼">
					</div>
					<div class="detail-division-line"></div>
					<div class="healthInfo">
						<div id="healthInfo-text">
							<p>총 <span class="sql-text" id="total-exerciseTime">0</span>분 운동 진행</p>
							<p><span class="sql-text" id="total-calTime">0</span>kcal 소비</p>
						</div>
						<div id="healthInfo-graph"></div>
						<div class="healthInfo-cart"></div>
						<!-- healthInfo-cart에 들어가는 자바스크립트 입력 코드
						<div class="healthInfo-select">
							<div class="healthInfo-detail">
								<div class="bookmark">별</div>
								<div class="healthInfo-name">
									<div class="healthInfo-name-text">걷기</div>
									<div class="healthInfo-name-time">60분</div>
								</div>
								<div class="healthInfo-cals">124kcal</div>
								<div class="healthInfo-del">-</div>
							</div>
							<div class="detail-division-line"></div>
						</div>
						-->
					</div>
					<button id="select-info" type="submit">기록하기</button>
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
	    			  					<div class="modalBody-text">운동시간(분)</div>
	    			  					<div class="modalBody-input">
		    			  					<div id="minus-button"><p>-</p></div>
			    			  				<input id="minute">
			    			  				<div id="plus-button"><p>+</p></div>
		    			  				</div>
	    			  				</div>
	    			  			</div>
    			  				<div class="modalBody-result" id="modalBody-calorie">
    			  					<div class="modalBody-text">칼로리(kcal)</div>
    			  					<div class="modalBody-input"><input id="calorie" readonly="readonly"></div>
    			  				</div>
    			  			</div>
    			  			<input id="no" type="hidden">
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
