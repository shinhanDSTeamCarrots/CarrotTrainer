<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>운동 정보</title>
	<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/healthInfo/exerciseStyle.css" />
	<script src="js/script.js"></script>
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
						<div id="search-box"><input type="text" name="healthName" value=""></div>
						<div id="search-text"><p>검색</p></div>
					</div>
					<div class="detail-division-line"></div>
					<div class="search-tag"></div>
				</div>
				<!-- 목록 -->
				<div class="list">
					<div class="list-title">
						<p class="list-title-text">목록</p>
						<%-- 로그인 했을 때,
		                <c:if test="${ }">
		                    <p class="list-title-text">즐겨찾기 목록</p>
		                </c:if>
		                검색하면 (검색결과부터 구현)
		                <c:if test="${ }">
		                    <p class="list-title-text">검색 결과</p>
		                </c:if>
		                --%>
		                <button class="select" type="submit" onclick="">선택</button>
		            </div>
					<div class="list-division-line">
						<img>
						<p>검색 결과: <span class="sql-text">${healthDic.size()}</span>개</p>
					</div>
					<div class="list-result">
						<table class="healthDic-list">
							<tbody>
							<colgroup>
								<col width="10%" />
								<col width="70%" />
								<col width="20%" />
							</colgroup>
							<%-- 즐찾목록있으면 > 없으면 전체
		               		<c:if test="">
							</c:if>
							-->
							검색하면
							<c:if test="">
							</c:if>
							 --%>
							<c:forEach var="healthDic" items="${healthDic}">
								<tr class="item-division-line">
									<td style="text-align: center;"><input type="checkbox" id="cb" name="healthCheck" value="${healthDic.no }"></td>
									<td id="health" style="text-align: left;">${healthDic.health }</td>
									<td id="calorie" style="text-align: center;">${healthDic.calorie }kcal/hr</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- 기록란 -->
			<div class="add-info">
				<div class="add-info-content">
					<div class="add-info-title">
						<p class="healthInfo-title-text">ADD</p>
					</div>
					<div class="title-division-line"></div>
					<div class="date">
						<p>날짜</p>
					</div>
					<div class="detail-division-line"></div>
					<div class="healthInfo">
						<div id="healthInfo-text">
							<p>
								총 <span class="sql-text">00</span>분 운동 진행
							</p>
							<p>
								<span class="sql-text">000</span>kcal 소비
							</p>
						</div>
						<div id="healthInfo-graph"></div>
						<div class="healthInfo-select"></div>
					</div>
					<button class="select-info" type="submit" onclick="">기록 완료</button>
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
    			  		<div id="modalBody-main">
    			  			<div id="modalBody-title">
    			  				<div id="modalBody-title-text">걷기</div>
    			  				<div class="title-division-line"></div>
    			  			</div>
    			  			<div id="modalBody-main">
    			  				<div id="modalBody-exercise">
	    			  				<div id="">
	    			  					<div>운동강도</div>
		    			  				<input id="">
	    			  				</div>
	    			  				<div id="">
	    			  					<div>운동시간(분)</div>
	    			  					<div id="minus-button">-</div>
		    			  				<input id="">
		    			  				<div id="plus-button">+</div>
	    			  				</div>
	    			  				<div class="list-division-line"></div>
	    			  			</div>
    			  				<div id="modalBody-result">
    			  					<div>칼로리(kcal)</div>
	    			  				<input id="">
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
