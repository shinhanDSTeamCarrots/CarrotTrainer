<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function() {
    //검색
	$("#search-text").click(function() {
		search();
	});
	
	//북마크 클릭 시, db에 저장(로그인이 되어있을 경우에만)
	$(".bookmark").click(function(event) {
	  // 상위 이벤트 막기
	  event.stopPropagation(); // 또는 return false; 를 사용 가능

	  //확인용
	  console.log("no확인용:",$(this).closest(".food-info").data("no"));
	  
	  //세션에서 로그인 정보 불러옴
	  const userName = "${sessionScope.loginInfo.member_nickname}";

	  if(userName){
	  	//이미 등록되어있는 경우 > 색상이 골드색일 때
	  	console.log($(this).data("color"));
	  	if($(this).data("color") === "gold") {
	  		if(confirm("즐겨찾기에서 제거하시겠습니까?")) {
	  			delFoodBookmark(event);
	  		}
	  	} else {
	  		//등록되어있지 않은 경우
	  		if(confirm("즐겨찾기에 추가하시겠습니까?")) {
	  			addFoodBookmark(event);
	  		}
	  	}
	  } else {
	  	if(confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
	  		location.href="${pageContext.request.contextPath}/member/login";
	  	}
	  }  
	});

	/*-------------
		검색 함수
	-------------*/
	//검색 완료 시, 페이지 리로드
	function search() {
    	location.href = "/myct/food?foodName=" + $('#foodName').val();
    }
	
	/*-------------
		북마크 함수
	-------------*/
	function addFoodBookmark(e) {
	    // 클릭한 행에 대한 정보 가져오기
	    const foodNo = $(e.currentTarget).closest(".food-info").data("no");
	    console.log('foodNo:'+foodNo);
	    $.ajax({
	        url: '${pageContext.request.contextPath}/healthInfo/insertFoodBookmark',
	        type: 'POST',
	        data: { food_dic_no : foodNo },
	        success: function(res) {
	        	// 삭제 성공 시 처리
            	console.log('북마크 추가 성공:', res);
            	$(e.currentTarget).css("color", "gold");
	        },
	        error: function(error) {
	            console.error('북마크 추가 실패:', error);
	        }
	    });
	}
	function delFoodBookmark(e) {
	    // 클릭한 행에 대한 정보 가져오기
	    const bookmarkNo = $(e.currentTarget).closest(".food-info").data("bookmarkno");
	    console.log('bookmarkNo:'+bookmarkNo);
	    $.ajax({
	        url: '${pageContext.request.contextPath}/healthInfo/deleteFoodBookmark',
	        type: 'POST',
	        data: { food_bookmark_no : bookmarkNo },
	        success: function(res) {
	        	// 삭제 성공 시 처리
            	console.log('북마크 삭제 성공:', res);
            	$(e.currentTarget).css("color", "");
	        },
	        error: function(error) {
	            console.error('북마크 삭제 실패:', error);
	        }
	    });
	}
});