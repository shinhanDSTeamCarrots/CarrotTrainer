<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function () {
	calendarHandler();
	bookmarkHandler();
	loadCartItems();
	calculateTotal();

	//검색
	$("#search-text").click(function () {
		search(60);
	});

	//운동 클릭 시, 장바구니로 이동
	$(".health-info").click(function () {
		// 세션에 저장
		cartMove(event);
		calculateTotal();
	});

	//입력
	$("#select-info").click(function (e) {
		if (confirm("입력하시겠습니까?")) {
			// 세션에 저장된 데이터 가져오기
	        let healthInfo = sessionStorage.getItem("healthData");
			
			// health_date input 요소 선택
			let healthDateInput = $("input[name='health_date']");
			// input 요소의 값 가져오기
			let healthDateValue = healthDateInput.val();
			// 가져온 값 출력 (콘솔 등을 통해 확인)
			let healthDateObject = new Date(healthDateValue);
			let formattedDate = healthDateObject.toISOString().split('T')[0];
			
			console.log("포맷팅된 Date 문자열:", formattedDate);
			
	        // 세션 데이터가 있으면 분리하여 입력 필드에 할당
	        if (healthInfo) {
	            let healthData = JSON.parse(healthInfo);
	
	            // 각 데이터에 대해 폼 생성 및 전송
	            for (let key in healthData) {
	                if (healthData.hasOwnProperty(key)) {
	                    // 새로운 폼 엘리먼트 생성
	                    let form = $('<form>', {
	                        'class': 'healthInfo-cart',
	                        'action': '${pageContext.request.contextPath}/healthInfo/insertHealthInfo',
	                        'method': 'post'
	                    });
	
	                    // 숨겨진 입력 필드 생성 및 세션 값 할당
	                    createHiddenInput(form, "health_name", healthData[key].health);
	                    createHiddenInput(form, "health_calorie", Number(healthData[key].calorie));
	                    createHiddenInput(form, "health_time", Number(healthData[key].minute));
	                    createHiddenInput(form, "health_date", formattedDate);
						console.log("포맷팅된 Date 문자열:", healthData[key].health);
						console.log("포맷팅된 Date 문자열:", healthData[key].calorie);
						console.log("포맷팅된 Date 문자열:", healthData[key].minute);
						console.log("포맷팅된 Date 문자열:", formattedDate);
	                    // 폼을 body에 추가하고 제출
	                    form.appendTo('body').submit().remove();
	                }
	            }
	        } else {
	            alert("저장할 운동 목록이 없습니다.");
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
/*----------
	북마크
----------*/
function bookmarkHandler() {
	//북마크 클릭 시, db에 저장(로그인이 되어있을 경우에만)
	$(".bookmark").click(function (event) {
		// 상위 이벤트 막기
		event.stopPropagation(); // 또는 return false; 를 사용 가능

		//확인용
		console.log("no확인용:", $(this).closest(".health-info").data("no"));

		//세션에서 로그인 정보 불러옴
		const userName = "${sessionScope.loginInfo.member_nickname}";

		if (userName) {
			//이미 등록되어있는 경우 > 색상이 골드색일 때
			console.log($(this).data("color"));
			if ($(this).data("color") === "gold") {
				if (confirm("즐겨찾기에서 제거하시겠습니까?")) {
					delBookmark(event);
				}
			} else {
				//등록되어있지 않은 경우
				if (confirm("즐겨찾기에 추가하시겠습니까?")) {
					addBookmark(event);
				}
			}
		} else {
			if (confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
				location.href = "${pageContext.request.contextPath}/member/login";
			}
		}
	});
}
/*----------
	모달
----------*/
function modalHandler() {
	//장바구니에 있는 운동 클릭 시, 모달 팝업 +이벤트 동적 바인딩
	$(".healthInfo-name").click(function (e) {
		let no = $(this).closest(".healthInfo-select").data("no");
		console.log("no:",no);
		
		// 세션 스토리지에서 해당 no 값에 해당하는 데이터 가져오기
	    let healthDataString = sessionStorage.getItem("healthData");
	    let healthData = healthDataString ? JSON.parse(healthDataString) : {};
	
	    let healthInfo = healthData[no];

		// 모달 열기 함수 호출
		openModal(healthInfo);
	});
	//모달 버튼 누르면 세션 스토리지 값 변경
	$("#modalBody-button button").click(function () {
		event.stopPropagation();

		// 세션 스토리지에서 운동 데이터 가져오기
		let healthDataString = sessionStorage.getItem("healthData");

		// JSON 문자열을 JavaScript 객체로 파싱
		let healthData = healthDataString ? JSON.parse(healthDataString) : null;
		
		let previousMinuteValue = 0;

		if (healthData) {
			// 입력된 값 가져오기
			let enteredTime = $("#minute").val();
			let enteredCalories = $("#calorie").val();
			let selectedNo = Number($("#no").val());

			for (let key in healthData) {
			    if (healthData.hasOwnProperty(key)) {
					if (healthData[key].no === selectedNo) {
					    // 선택된 항목의 데이터 업데이트
					    healthData[key].minute = enteredTime;
					    healthData[key].calorie = enteredCalories;
					    break;
					}
			    }
			}
			// 세션 스토리지에 저장
			sessionStorage.setItem("healthData", JSON.stringify(healthData));

			$('#modalWrap').css('display', 'none');

			$('.healthInfo-cart').empty();
			loadCartItems();
			calculateTotal();
		}
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
			let newMinuteValue = currentValue - 10;
			let newCalories = Math.round(enteredCalories / currentValue * newMinuteValue);

			previousMinuteValue = newMinuteValue;

			$("#minute").val(newMinuteValue);
			$("#calorie").val(newCalories);

		}
	});
	// plus-button 클릭 이벤트
	$("#plus-button").on("click", function () {
		let currentValue = parseInt($("#minute").val());
		let enteredCalories = parseInt($("#calorie").val());

		// 값이 숫자인지 확인 후 처리
		if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
			let newMinuteValue = currentValue + 10;
			let newCalories = Math.round(enteredCalories / currentValue * newMinuteValue);

			previousMinuteValue = newMinuteValue;

			$("#minute").val(newMinuteValue);
			$("#calorie").val(newCalories);
		}
	});
	
	// #minute 값이 변경될 때 이벤트 처리
	$("#minute").keyup(function (e) {
		let previousValue = previousMinuteValue;

		// 변경된 #minute 값 가져오기
		let enteredTime = Number($(this).val());

		// 동적으로 #calorie 값 업데이트
    	if (enteredTime < 0) {
	        // 0 미만이면 0으로 설정
	        enteredTime = 0;
	        $(this).val(0);  // 입력값도 0으로 설정
	    }
		// 칼로리 계산
    	enteredCalories = (enteredTime === 0) ? 0 : calculateCalories(previousValue, enteredTime);
		console.log(enteredCalories, previousValue, enteredTime);
		
		$("#calorie").val(enteredCalories);
	});
	/*--------------------
		모달 팝업 오픈 함수
	--------------------*/
	function openModal(healthData) {
		console.log("모달 열기 및 데이터 전달:", healthData);

		// 모달 내용 채우기
		$("#modalBody-title-text").text(healthData.health);
		$("#no").val(healthData.no);
		$("#minute").val(healthData.minute);
		previousMinuteValue = Number($("#minute").val());
		$("#calorie").val(healthData.calorie);

		// 모달 열기
		$('#modalWrap').css('display', 'flex');

		// 닫기 버튼 클릭 이벤트 처리
		$('#closeBtn').click(function () {
			$('#modalWrap').css('display', 'none');
		});

		// 팝업 외부 클릭 이벤트 처리
		$('#modalWrap').click(function (e) {
			if (e.target === this) {
				$(this).css('display', 'none');
			}
		});
	}
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
	$("input[name='health_date']").datepicker(config);
}
/*-------------
	계산 함수
-------------*/
function calculateCalories(previousTime, currentTime) {
	// #calorie에서 입력된 값 가져오기
	console.log('calori',$("#calorie").val());
	let enteredCalories = Number($("#calorie").val());

	// 칼로리 계산
	let calories = Math.round(enteredCalories / previousTime * currentTime);
	return calories;
}

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
function addBookmark(e) {
	// 클릭한 행에 대한 정보 가져오기
	const healthNo = $(e.currentTarget).closest(".health-info").data("no");
	console.log('healthNo:' + healthNo);
	$.ajax({
		url: '${pageContext.request.contextPath}/healthInfo/insertBookmark',
		type: 'POST',
		data: { health_dic_no: healthNo },
		success: function (res) {
			// 삭제 성공 시 처리
			console.log('북마크 추가 성공:', res);
			$(e.currentTarget).css("color", "gold");
		},
		error: function (error) {
			console.error('북마크 추가 실패:', error);
		}
	});
}
function delBookmark(e) {
	// 클릭한 행에 대한 정보 가져오기
	const bookmarkNo = $(e.currentTarget).closest(".health-info").data("bookmarkno");
	console.log('bookmarkNo:' + bookmarkNo);
	$.ajax({
		url: '${pageContext.request.contextPath}/healthInfo/deleteBookmark',
		type: 'POST',
		data: { health_bookmark_no: bookmarkNo },
		success: function (res) {
			// 삭제 성공 시 처리
			console.log('북마크 삭제 성공:', res);
			$(e.currentTarget).css("color", "");
		},
		error: function (error) {
			console.error('북마크 삭제 실패:', error);
		}
	});
}
/*-------------
	세션 함수
-------------*/
//클릭 시, 값 확인하여 세션에 저장 함수
function cartMove(e) {
	//값 확인
	console.log($(e.currentTarget).data("no"));
	console.log($(e.currentTarget).children(".health").text());
	console.log($(e.currentTarget).children(".calorie").text().replace('kcal/hr', ''));

	let no = $(e.currentTarget).data("no");
	let health = $(e.currentTarget).children(".health").text();
	let minute = 60; //기본값
	let calorie = $(e.currentTarget).children(".calorie").text().replace('kcal/hr', '');

	// 세션에서 기존 데이터 가져오기
	let existingData = sessionStorage.getItem("healthData");
	let existingHealthData = {};

	// 기존 데이터가 있으면 파싱
	if (existingData) {
		existingHealthData = JSON.parse(existingData);
	}
	// 최대 10개만 허용
    if (Object.keys(existingHealthData).length >= 10) {
        alert("최대 10개까지만 선택 가능합니다.");
        return;
    }
	// 이미 등록된 no인지 확인
	if (existingHealthData.hasOwnProperty(no)) {
		alert("이미 등록된 항목입니다.");
		return;
	} else {
		// 기존 데이터에 새로운 항목 추가 또는 덮어쓰기
		existingHealthData[no] = {
			no: no,
			health: health,
			minute: minute,
			calorie: calorie
		};
		// 세션에 데이터 저장
		sessionStorage.setItem("healthData", JSON.stringify(existingHealthData));
		
		//배경색 변경
		$(e.currentTarget).css("background-color", "#FAF8ED");
		//배경색 상태 저장
		sessionStorage.setItem("background-color", "#FAF8ED");
		
		// 새로운 항목을 장바구니에 추가
		addHealthToCart(existingHealthData[no]);
	}
}
//세션에서 모든 쿠키 값들 가져오기 >  페이지 로드 시에 세션에서 특정 데이터를 가져와서 목록에 추가하는 데 사용
function loadCartItems() {
	let healthInfo = sessionStorage.getItem("healthData")

	console.log(healthInfo);

	if (healthInfo) {
		// 세션 데이터가 있으면 파싱하여 운동 목록에 추가
        let healthData = JSON.parse(healthInfo);
        for (let key in healthData) {
            if (healthData.hasOwnProperty(key)) {
                addHealthToCart(healthData[key]);
                // 배경색 설정
                let background_color = sessionStorage.getItem("background-color");
            }
        }
	}
}
/*-------------------
	장바구니 관련 함수
-------------------*/
//진행 운동 목록 생성 함수
function addHealthToCart(healthData) {
	//받은 데이터로 운동 목록에 값 생성
	const healthInfoSelect = $('<div class="healthInfo-select"></div>');

	const healthInfoDetail = $('<div class="healthInfo-detail"></div>');
	healthInfoDetail.append('<div class="healthInfo-name"><div class="healthInfo-name-text">' + healthData.health + '</div><div class="healthInfo-name-time">' + healthData.minute + '분</div></div>');
	healthInfoDetail.append('<div class="healthInfo-cals">' + healthData.calorie + 'kcal</div>');
	healthInfoDetail.append('<div class="healthInfo-del"><div id="delButton"><p>-</p></div></div>'); //빼기 이미지
	
	// no 값을 data-no 속성으로 설정
    healthInfoSelect.attr('data-no', healthData.no);
    
	healthInfoSelect.append(healthInfoDetail);

	$('.healthInfo-cart').append(healthInfoSelect);
	modalHandler();
	
	//빼기 버튼 클릭 시, 세션에서 삭제
	$(".healthInfo-del").click(function (e) {
		// 세션에 저장
		console.log($(this).closest(".healthInfo-select").data("no"));
		
		// 빼기 버튼에 설정된 data-no 속성 값을 가져옴
    	const no = $(this).closest(".healthInfo-select").data("no");
		// 세션에서 삭제
		delHealthToCart(no);
	});
}
//진행 운동 목록 삭제 함수
function delHealthToCart(no) {
	// 세션 스토리지에서 현재 운동 목록 가져오기
    let existingData = sessionStorage.getItem("healthData");
    let existingHealthData = {};

    // 기존 데이터가 있으면 파싱
    if (existingData) {
        existingHealthData = JSON.parse(existingData);
    }

    // 운동 삭제
    if (existingHealthData.hasOwnProperty(no)) {
        delete existingHealthData[no];
        // 세션에 데이터 갱신
        sessionStorage.setItem("healthData", JSON.stringify(existingHealthData));
        
        // UI 갱신 (운동 목록에서 삭제)
    	//$(`.healthInfo-select[data-no="${no}"]`).remove();
    	$(".healthInfo-cart").empty();

    	loadCartItems();
		calculateTotal();
    }
}
//클릭 시, 진행 운동 계산 함수
function calculateTotal() {
	let totalMinute = 0;
	let totalCalorie = 0;

	$('.healthInfo-detail').each(function () {
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