<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="header">
            <div class="size">
            	<!-- 이미지, 글씨 클릭 시 메인으로 이동 -->
            	<div class="title">
	           		<div class="title-text">
	            		<a id="mct" href="${pageContext.request.contextPath}">나당트</a>
	            		<a id="my-carrot-trainer" href="${pageContext.request.contextPath}">나의 당근 트레이너</a>
	           		</div>
	           		<div class="title-img">
           				<a href="${pageContext.request.contextPath}"><img id="carrot" src="${pageContext.request.contextPath}/img/carrot-removebg-preview.png"></a>
           			</div>
           		</div>
           		
           		<c:choose>
           		<c:when test="${sessionScope.loginInfo==null}">
	                <div class="login">
	               		<a href="/myct/member/login">로그인</a> |
	                    <a href="/myct/member/join">회원가입</a>
	                </div>
           		</c:when>
           		<c:otherwise>
	                <div class="login">
	               		<a href="/myct/member/login">마이페이지</a> |
	                    <a href="/myct/member/logout">로그아웃</a>
	                </div>
           		</c:otherwise>
           		</c:choose>
                
            </div>
        </div>
        <div class="menu">
            <ul class="depth1">
                <li>
                    <a href="#">건강뉴스</a>
                    <ul class="depth2">
                        <li><a href="/myct/healthnews/cardboard">웰니스 뉴스</a></li>
                        <li><a href="#">MENU1-2</a></li>
                        <li><a href="#">MENU1-3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">건강정보</a>
                    <ul class="depth2">
                        <li><a href="${pageContext.request.contextPath}/bmi">일일 권장량 계산</a></li>
                        <li><a href="${pageContext.request.contextPath}/food">음식 정보</a></li>
                        <li><a href="${pageContext.request.contextPath}/exercise">운동 정보</a></li>
                        <li><a href="${pageContext.request.contextPath}/diary">다이어리</a></li>
                        <li><a href="${pageContext.request.contextPath}/bodyReport">리포트</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">커뮤니티</a>
                    <ul class="depth2">
                        <li><a href="/myct/board/noticeboard">공지사항</a></li>
                        <li><a href="/myct/board/freeboard">자유게시판</a></li>
                        <li><a href="/myct/board/qnaboard">문의게시판</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">쇼핑</a>
                    <ul class="depth2">
                        <li><a href="${pageContext.request.contextPath}/chickenList">닭가슴살</a></li>
                        <li><a href="#">도시락</a></li>
                        <li><a href="#">샐러드</a></li>
                    </ul>
                </li>
            </ul>
        </div>