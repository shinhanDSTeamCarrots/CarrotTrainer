//<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
//<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function() {
	$("#search-text").click(function() {
		search(60);
	});
	
	//운동 클릭 시, 장바구니로 이동
	$(".health-info").click(function() {
		loadCartItems(this);
		calculateTotal();
	});
	
	//북마크 클릭 시, db에 저장(로그인이 되어있을 경우에만)
	$(".health-info .bookmark").click(function(event) {
	  // 상위 이벤트 막기
	  event.stopPropagation(); // 또는 return false; 를 사용 가능

	  //확인용
	  console.log($(this).closest(".health-info").data("no"));
	  
	  //세션에서 로그인 정보 불러옴
	  let loginInfo = sessionStorage.getItem("loginInfo");

	  if(loginInfo){
	  	//이미 등록되어있는 경우 > 색상이 골드색일 때
	  	if($(this).css("color") === "gold") {
	  		if(confirm("즐겨찾기에서 제거하시겠습니까?")) {
	  			delBookmark();
	  		}
	  	} else {
	  		//등록되어있지 않은 경우
	  		if(confirm("즐겨찾기에 추가하시겠습니까?")) {
	  			addBookmark();
	  		}
	  	}
	  } else {
	  	if(confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
	  		window.location.href = "로그인 페이지 URL";
	  	}
	  }  
	});
	
	//장바구니에 있는 운동 클릭 시, 모달 팝업
	$(".healthInfo-name").click(function() {
		// 받은 데이터로 모달 내용 생성
		// 모달 열기 함수 호출
    	openModal(healthData);
	});
	// 숫자 이외의 문자를 제거하고 input에 설정
	$("#minute").on("input", function () {
	    var inputValue = $(this).val();

	    $(this).val(inputValue.replace(/[^0-9]/g, ''));
	});
	// minus-button 클릭 이벤트
	$("#minus-button").on("click", function () {
	    let currentValue = parseInt($("#minute").val());
	    let enteredCalories = parseInt($("#calorie").val());
	    
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
	        $("#minute").val(currentValue - 10);
	        $("#calorie").val(Math.round(enteredCalories/60*50));
	        
	    }
	});
	// plus-button 클릭 이벤트
	$("#plus-button").on("click", function () {
	    let currentValue = parseInt($("#minute").val());
	    let enteredCalories = parseInt($("#calorie").val());
	    
	    // 값이 숫자인지 확인 후 처리
	    if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
	        $("#minute").val(currentValue + 10);
	        $("#calorie").val(Math.round(currentValue/60*70));
	    }
	});
	
	$("#modalBody-button button").click(function() {
		let healthData = getCookie(healthData);
		
	    // 입력된 값 가져오기
	    let enteredTime = $("#minute").val();
	    let enteredCalories = $("#calorie").val();
	    
	    // healthData에 새로운 값 설정
	    healthData.minute = enteredTime;
	    healthData.calorie = enteredCalories;
	
	    // 쿠키에 저장
	    setCookie("healthData", JSON.stringify(healthData));
	});
	
	/*-------------
		검색 함수
	-------------*/
	//검색 완료 시, 페이지 리로드
	function search(minute) {
    	location.href = "/myct/exercise?healthName=" + $('#healthName').val();
    }
	
	/*-------------
		북마크 함수
	-------------*/
	function addBookmark() {
	    // 클릭한 행에 대한 정보 가져오기
	    const healthNo = $(this).closest(".health-info".data("no")); //가로에 this추가하고 $(this).closest대신 $(event.currentTarget)로 변경??
	    
	    $.ajax({
	        url: '/insertBookmark', // 실제로는 서버의 경로를 지정해야 합니다.
	        method: 'POST',
	        data: JSON.stringify({ no : healthNo }),
	        success: function(res) {
	        	// 삭제 성공 시 처리
            	console.log('북마크 추가 성공:', res);
            	$(event.currentTarget).css("color", "gold");
	        },
	        error: function(error) {
	            console.error('북마크 추가 실패:', error);
	        }
	    });
	}
	function delBookmark() {
	    // 클릭한 행에 대한 정보 가져오기
	    const healthNo = $(this).closest(".health-info".data("no"));
	    
	    $.ajax({
	        url: '/deleteBookmark', // 실제로는 서버의 경로를 지정해야 합니다.
	        method: 'POST',
	        data: JSON.stringify({ no : healthNo }),
	        success: function(res) {
	        	// 삭제 성공 시 처리
            	console.log('북마크 삭제 성공:', res);
            	$(event.currentTarget).css("color", "");
	        },
	        error: function(error) {
	            console.error('북마크 삭제 실패:', error);
	        }
	    });
	}
	/*-------------
		쿠키 함수
	-------------*/
	//쿠키에서 모든 쿠키 값들 가져오기 >  페이지 로드 시에 특정 이름으로 시작하는 쿠키들을 찾아서 목록에 추가하는 데 사용
	function loadCartItems(){
		let allCookies = document.cookie.split(";");
		
		//각 쿠키 반복
		allCookies.forEach(function(cookie) {
			let cookieParts = cookie.split("=");
			let cookieName = cookieParts[0].trim();
			let cookieValue = cookieParts[1];
			
			if (cookieName.startsWith("healthData")) {
				// 쿠키 값을 JSON으로 파싱
				let healthData = JSON.parse(cookieValue);
				
				//페이지 로드 시에 이전에 저장된 항목들을 목록에 추가
				addHealthToCart(healthData);
			}
		});
	}
	//쿠키 설정
	function setCookie(name, value) {
	  document.cookie = name + "=" + value + "; path=/";
	}
	// 쿠키에서 모든 쿠키 값들 가져오기 > 특정 쿠키의 값을 반환하는 데 주로 사용
	function getCookie(name) {
    let cookies = document.cookie.split(';');

    // 찾고자 하는 쿠키 찾기
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].trim();
        // 쿠키의 이름과 값 분리
        let cookieParts = cookie.split('=');
        let cookieName = cookieParts[0];

        // 찾고자 하는 쿠키 이름과 일치하는 경우 해당 쿠키 값 반환
        if (cookieName === name) {
            return cookieParts[1];
        }
    }

    // 해당하는 쿠키를 찾지 못한 경우 null 반환
    return null;
	}
	
    /*-------------------
		장바구니 관련 함수
	-------------------*/
	//진행 운동 목록 생성 함수
	function addHealthToCart(healthData) {
		//받은 데이터로 운동 목록에 값 생성
    	const healthInfoSelect = $('<div class="healthInfo-select"></div>');
    	
    	const healthInfoDetail = $('<div class="healthInfo-detail"></div>');
    	healthInfoDetail.append('<div class="bookmark">&#9733;</div>'); //즐겨찾기 이미지
	    healthInfoDetail.append('<div class="healthInfo-name"><div class="healthInfo-name-text">' + healthData.health + '</div><div class="healthInfo-name-time">' + healthData.minute + '분</div></div>');
	    healthInfoDetail.append('<div class="healthInfo-cals">' +healthData.calorie + 'kcal</div>');
	    healthInfoDetail.append('<div class="healthInfo-del">-</div>');  //빼기 이미지
	    
	    healthInfoSelect.append(healthInfoDetail);
	    healthInfoSelect.append('<div class="detail-division-line"></div>');

        $('.healthInfo-cart').append(healthInfoSelect);
	}
    //클릭 시, 값 확인하여 쿠키에 저장 함수
    function cartMove() {
    	//값 확인
    	console.log($(this).data("no"));
		console.log($(this).children(".health").text());
		console.log($(this).children(".calorie").text().replace('kcal/hr', ''));
		
		let no = $(this).data("no");
		let health = $(this).children(".health").text();
		let minute = 60; //기본값
		let calorie = $(this).children(".calorie").text().replace('kcal/hr', '');
		
		//데이터를 json형태로 묶기
		let healthData = {
			no: no,
			health: health,
			minute: minute,
			calorie: calorie
		};
		
		// 쿠키에서 기존 데이터 가져오기
		let existingData = getCookie("healthData");
		
		// 이미 등록된 no인지 확인
		if (existingData) {
		    let existingHealthData = JSON.parse(existingData); //JSON 형식의 문자열을 JavaScript 객체로 변환하는 메서드
		
		    // 이미 등록된 no일 경우 알림 띄우고 종료
		    if (existingHealthData.no === no) {
		        alert("이미 등록된 항목입니다.");
		        return;
		    }
		}
		
		//json을 문자열로 반환하여 쿠키에 저장
		setCookie("healthData", JSON.stringify(healthData));
		
		//새로운 항목을 장바구니에 추가
		addHealthToCart(healthData);
    }
    //클릭 시, 진행 운동 계산 함수
    function calculateTotal() {
	    let totalMinute = 0;
	    let totalCalorie = 0;
	
	    $('.healthInfo-detail').each(function() {
	        const minuteText = $(this).find('.healthInfo-name-time').text();
	        const calorieText = $(this).find('.healthInfo-cals').text();
	
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
	/*--------------------
		모달 팝업 오픈 함수
	--------------------*/
	function openModal(healthData) {
    	console.log("모달 열기 및 데이터 전달:", healthData);
    	//쿠키에 저장된 운동관련 값 가져오기
    	let healthName = healthData.health;
    	let minute = healthData.minute;
    	let calorie = healthData.calorie;
    	
    	$("#modalBody-title-text").text(healthName);
    	$("#minute").val(minute);
    	$("#calorie").val(calorie);
	}
	
	/*----------
		캘린더
	----------*/
	//일자 설정
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn : "button",
		buttonText:"날짜 선택",
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    yearSuffix: '년',
        changeMonth: true,
        changeYear: true
	}
	//캘린더
	$( "input[name='health_date']" ).datepicker(config);
    
	// 참고: 목록에 데이터 추가하는 함수(ajax사용할 경우)
    function displayList(data) {
        // 여기에서 data를 이용하여 목록에 데이터를 추가하는 작업을 수행
        const tbody = $('#healthTbody');
        
		//기존 목록 지우기
 		tbody.empty();
 		
 		
        // 받은 데이터로 목록 생성
        for (let i = 0; i < data.length; i++) {
        	const row = $('<tr class="item-division-line"></tr>');
	        row.append('<td style="text-align: center;"><input type="checkbox" class="healthCheck" name="healthCheck" value="' + data[i].no + '"></td>');
	        row.append('<td class="health" style="text-align: left;">' + data[i].health + '</td>');
	        row.append('<td class="calorie" style="text-align: center;">' + data[i].calorie + 'kcal/hr</td>');
            
            tbody.append(row);
        }
    }
    
    
});