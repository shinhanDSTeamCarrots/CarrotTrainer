<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function() {
	calendarHandler();
	bookmarkHandler();
	loadCartItems();
	calculateTotal();
	
    //검색
	$("#search-text").click(function() {
		search();
	});
	
	//음식 클릭 시, 장바구니로 이동
	$(".food-info").click(function () {
		// 세션에 저장
		cartMove(event);
		calculateTotal();
	});
	
	//입력
	$("#select-info").click(function (e) {
		//세션에서 로그인 정보 불러옴
		const userName = "${sessionScope.loginInfo.member_nickname}";
	
		if (userName) {
			if (confirm("입력하시겠습니까?")) {
				// 세션에 저장된 데이터 가져오기
				let foodInfo = sessionStorage.getItem("foodData");
	
				// 세션 데이터가 있으면 분리하여 입력 필드에 할당
				if (foodInfo) {
					let foodData = JSON.parse(foodInfo);
	
					if (foodData.hasOwnProperty(key)) {
						// 새로운 폼 엘리먼트 생성
						let form = $('<form>', {
							'class': 'foodInfo-cart',
							'action': '${pageContext.request.contextPath}/healthInfo/insertFoodDiary',
							'method': 'post'
						});
	
						// 숨겨진 입력 필드 생성 및 세션 값 할당
						createHiddenInput(form, "intake_date", healthData[key].intake_date);
						createHiddenInput(form, "intake_time", Number(healthData[key].intake_time));
						createHiddenInput(form, "image", Number(healthData[key].minute));
						createHiddenInput(form, "total_calorie", Number(healthData[key].total_calorie));
						createHiddenInput(form, "total_carbs", healthData[key].total_carbs);
						createHiddenInput(form, "total_protein", Number(healthData[key].total_protein));
						createHiddenInput(form, "total_fat", Number(healthData[key].total_fat));
						createHiddenInput(form, "total_sugar", Number(healthData[key].total_sugar));
						createHiddenInput(form, "total_salt", Number(healthData[key].total_salt));
	
						// 폼을 body에 추가하고 제출
						form.appendTo('body').submit().remove();
					}
				} else {
					alert("저장할 음식 목록이 없습니다.");
				}
			} else {
				if (confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
					location.href = "${pageContext.request.contextPath}/member/login";
				}
			}
		}
	});
});
// 숨겨진 입력 필드 생성 및 세션 값 할당하는 함수
function createHiddenInput(form, inputId, sessionValue) {
    $('<input>', {
        'type': 'hidden',
        'id': inputId,
        'name': inputId,
        'value': sessionValue || ''
    }).appendTo(form);
}

/*-------------
	검색 함수
-------------*/
//검색 완료 시, 페이지 리로드
function search() {
	location.href = "/myct/food?foodName=" + $('#foodName').val();
}

/*----------
	북마크
----------*/
function bookmarkHandler() {
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
}
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

/*-------------------
	장바구니 관련 함수
-------------------*/
//진행 운동 목록 생성 함수
function addfoodToCart(foodData) {
	//받은 데이터로 운동 목록에 값 생성
	const foodInfoSelect = $('<div class="foodInfo-select"></div>');

	const foodInfoDetail = $('<div class="foodInfo-detail"></div>');
	foodInfoDetail.append('<div class="foodInfo-name"><div class="foodInfo-name-text">' + foodData.food + '</div><div class="foodInfo-name-time">' + foodData.minute + '분</div></div>');
	foodInfoDetail.append('<div class="foodInfo-cals">' + foodData.calorie + 'kcal</div>');
	foodInfoDetail.append('<div class="foodInfo-del"><div id="delButton"><p>-</p></div></div>'); //빼기 이미지
	
	// no 값을 data-no 속성으로 설정
    foodInfoSelect.attr('data-no', foodData.no);
    
	foodInfoSelect.append(foodInfoDetail);

	$('.foodInfo-cart').append(foodInfoSelect);
	modalHandler();
	
	//빼기 버튼 클릭 시, 세션에서 삭제
	$(".foodInfo-del").click(function (e) {
		// 세션에 저장
		console.log($(this).closest(".foodInfo-select").data("no"));
		
		// 빼기 버튼에 설정된 data-no 속성 값을 가져옴
    	const no = $(this).closest(".foodInfo-select").data("no");
		// 세션에서 삭제
		delfoodToCart(no);
	});
}
//진행 운동 목록 삭제 함수
function delfoodToCart(no) {
	// 세션 스토리지에서 현재 운동 목록 가져오기
    let existingData = sessionStorage.getItem("foodData");
    let existingfoodData = {};

    // 기존 데이터가 있으면 파싱
    if (existingData) {
        existingfoodData = JSON.parse(existingData);
    }

    // 운동 삭제
    if (existingfoodData.hasOwnProperty(no)) {
        delete existingfoodData[no];
        // 세션에 데이터 갱신
        sessionStorage.setItem("foodData", JSON.stringify(existingfoodData));
        
        // UI 갱신 (운동 목록에서 삭제)
    	//$(`.foodInfo-select[data-no="${no}"]`).remove();
    	$(".foodInfo-cart").empty();

    	loadCartItems();
		calculateTotal();
    }
}
//클릭 시, 진행 운동 계산 함수
function calculateTotal() {
	let totalMinute = 0;
	let totalCalorie = 0;

	$('.foodInfo-detail').each(function () {
		const minuteText = $(this).find('.foodInfo-name-time').text();
		const calorieText = $(this).find('.foodInfo-cals').text();

		// 분 추출
		const minute = parseInt(minuteText.replace('분', ''));
		// 칼로리 추출
		const calorie = parseInt(calorieText.replace('kcal', ''));

		// 누적
		totalMinute += minute;
		totalCalorie += calorie;
	});

	console.log('Total Minute:', totalMinute);
	console.log('Total Calorie:', totalCalorie);

	//기존 값에 입력
	$("#total-exerciseTime").text(totalMinute);
	$("#total-calTime").text(totalCalorie);
}

/*----------
	캘린더
----------*/
function calendarHandler() {
	//일자 설정
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn: "button",
		buttonText: "날짜 선택",
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		yearSuffix: '년',
		changeMonth: true,
		changeYear: true
	}
	//캘린더
	$("input[name='food_date']").datepicker(config);
}