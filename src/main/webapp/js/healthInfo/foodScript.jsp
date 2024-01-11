<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function () {
	//페이지 초기화
	initializePage();

	//검색
	$("#search-text").click(function () {
		search();
	});

	//음식 클릭 시, 장바구니로 이동
	$(".food-info").click(function () {
		// 세션에 저장
		cartMove(event);
		calculateTotal();
	});

	//입력
    $(".select-info").click(function (e) {
        //handleFoodDataInput();
        alert("기능을 준비중입니다.")
    });
});
// 페이지 초기화 함수
function initializePage() {
    calendarHandler();
    bookmarkHandler();
    loadCartItems();
    calculateTotal();
}
// 숨겨진 입력 필드 생성 및 세션 값 할당하는 함수
function createHiddenInput(form, inputId, sessionValue) {
	$('<input>', {
		'type': 'hidden',
		'id': inputId,
		'name': inputId,
		'value': sessionValue || ''
	}).appendTo(form);
}
// 음식 데이터 처리
function handleFoodDataInput() {
    // 세션에서 로그인 정보 불러옴
    const userName = "${sessionScope.loginInfo.member_nickname}";

    if (userName) {
        if (confirm("입력하시겠습니까?")) {
            processFoodEntry();
        } else {
            alert("날짜를 입력해주세요.");
        }
    } else {
        handleLoginPrompt();
    }
}
// 음식 데이터 처리
function processFoodEntry() {
    // 세션에 저장된 데이터 가져오기
    let foodInfo = sessionStorage.getItem("foodData");
    let selectedDate = $("#food_date").val();

    if (selectedDate !== '') {
        let formattedDate = getFormattedDate(selectedDate);

        if (foodInfo) {
            let foodData = JSON.parse(foodInfo);

            // 각 데이터에 대해 Ajax를 사용하여 전송
            for (let i = 0; i < foodData.length; i++) {
                sendDiaryEntry(foodData[i], formattedDate);
            }
        } else {
            alert("저장할 음식 목록이 없습니다.");
        }
    } else {
        alert("날짜를 입력해주세요.");
    }
}
// Ajax 요청 보내기
function sendDiaryEntry(data, formattedDate) {
    $.ajax({
        type: 'POST',
        url: 'insertFoodDiary',
        data: {
            intake_date: formattedDate,
            intake_time: $('#intake_time').val(),
            image: "",
            total_calorie: Number(data.calorie),
            total_carbs: Number(data.carbs),
            total_protein: Number(data.protein),
            total_fat: Number(data.fat),
            total_sugar: Number(data.sugar),
            total_salt: Number(data.salt),
        },
        success: function(response) {
            console.log('Success:', response);
            processFoodInfoData(data);
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}
// 로그인 프롬프트 처리
function handleLoginPrompt() {
    if (confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/member/login";
    }
}

// 음식 정보 처리
function processFoodInfoData(data) {
    // 새로운 폼 엘리먼트 생성
    let form = $('<form>', {
        'class': 'foodInfo-cart',
        'action': 'insertFoodInfo',
        'method': 'post'
    });

    // 숨겨진 입력 필드 생성 및 세션 값 할당
	createHiddenInput(form, "food_name", data.health);
	createHiddenInput(form, "food_gram", Number(data.gram));
	createHiddenInput(form, "food_unit", "g");
	createHiddenInput(form, "food_calorie", Number(data.calorie));
	createHiddenInput(form, "food_carbs", Number(data.carbs));
	createHiddenInput(form, "food_protein", Number(data.protein));
	createHiddenInput(form, "food_fat", Number(data.fat));
	createHiddenInput(form, "food_sugar", Number(data.sugar));
	createHiddenInput(form, "food_salt", Number(data.salt));

    // 폼을 body에 추가하고 제출
    form.appendTo('body').submit().remove();
}
// 선택한 날짜를 ISO 형식으로 변환하는 함수
function getFormattedDate(selectedDate) {
    let foodDateObject = new Date(selectedDate);
    return foodDateObject.toISOString().split('T')[0];
}
/*-------------
	검색 함수
-------------*/
//검색 완료 시, 페이지 리로드
function search() {
	location.href = "${pageContext.request.contextPath}/healthInfo/food?foodName=" + $('#foodName').val();
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
		console.log("no확인용:", $(this).closest(".food-info").data("foodno"));

		//세션에서 로그인 정보 불러옴
		const userName = "${sessionScope.loginInfo.member_nickname}";

		if (userName) {
			//이미 등록되어있는 경우 > 색상이 골드색일 때
			console.log($(this).data("color"));
			if ($(this).data("color") === "gold") {
				if (confirm("즐겨찾기에서 제거하시겠습니까?")) {
					delFoodBookmark(event);
				}
			} else {
				//등록되어있지 않은 경우
				if (confirm("즐겨찾기에 추가하시겠습니까?")) {
					addFoodBookmark(event);
				}
			}
		} else {
			if (confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")) {
				location.href = "${pageContext.request.contextPath}/member/login";
			}
		}
	});
}
function addFoodBookmark(e) {
	// 클릭한 행에 대한 정보 가져오기
	const foodNo = $(e.currentTarget).closest(".food-info").data("foodno");
	console.log('foodNo:' + foodNo);
	$.ajax({
		url: '${pageContext.request.contextPath}/healthInfo/insertFoodBookmark',
		type: 'POST',
		data: { food_dic_no: foodNo },
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
function delFoodBookmark(e) {
	// 클릭한 행에 대한 정보 가져오기
	const bookmarkNo = $(e.currentTarget).closest(".food-info").data("bookmarkno");
	console.log('bookmarkNo:' + bookmarkNo);
	$.ajax({
		url: '${pageContext.request.contextPath}/healthInfo/deleteFoodBookmark',
		type: 'POST',
		data: { food_bookmark_no: bookmarkNo },
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

/*----------
	모달
----------*/
function modalHandler() {
	//장바구니에 있는 운동 클릭 시, 모달 팝업 +이벤트 동적 바인딩
	$(".foodInfo-name").click(function (e) {
		let no = $(this).closest(".foodInfo-select").data("no");
		console.log("no:", no);

		// 세션 스토리지에서 해당 no 값에 해당하는 데이터 가져오기
		let foodDataString = sessionStorage.getItem("foodData");
		let foodData = foodDataString ? JSON.parse(foodDataString) : {};

		let foodInfo = foodData[no];

		// 모달 열기 함수 호출
		openModal(foodInfo);
	});
	//모달 버튼 누르면 세션 스토리지 값 변경
	$("#modalBody-button button").click(function () {
		event.stopPropagation();

		// 세션 스토리지에서 운동 데이터 가져오기
		let foodDataString = sessionStorage.getItem("foodData");

		// JSON 문자열을 JavaScript 객체로 파싱
		let foodData = foodDataString ? JSON.parse(foodDataString) : null;

		let previousGramValue = 0;

		if (foodData) {
			// 입력된 값 가져오기
			let enteredGram = $("#gram").val();
			let enteredCalories = $("#calorie").val();
			let selectedNo = Number($("#no").val());
			
			//onsole.log("enteredGram"+enteredGram);
			for (let key in foodData) {
				if (foodData.hasOwnProperty(key)) {
					if (foodData[key].no === selectedNo) {
						// 선택된 항목의 데이터 업데이트
						foodData[key].gram = enteredGram;
						foodData[key].calorie = enteredCalories;
						console.log("Type of enteredGram: " + typeof enteredGram);
						console.log("Type of enteredCalories: " + typeof enteredCalories);
						break;
					}
				}
			}
			// 세션 스토리지에 저장
			sessionStorage.setItem("foodData", JSON.stringify(foodData));

			$('#modalWrap').css('display', 'none');

			$('.foodInfo-cart').empty();
			loadCartItems();
			calculateTotal();
		}
	});

	// 숫자 이외의 문자를 제거하고 input에 설정
	$("#gram").on("input", function () {
		var inputValue = $(this).val();
		$(this).val(inputValue.replace(/[^0-9]/g, ''));
	});
	// minus-button 클릭 이벤트
	$("#minus-button").off("click");
	$("#minus-button").on("click", function () {
		let currentValue = parseInt($("#gram").val());
		let enteredCalories = parseInt($("#calorie").val());

		console.log('currentValue:', currentValue);
		console.log('enteredCalories:', enteredCalories);
		// 값이 숫자인지 확인 후 처리
		if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
			let newGramValue = currentValue - 10;
			let newCalories = Math.round(enteredCalories / currentValue * newGramValue);

			previousGramValue = newGramValue;
			console.log('newGramValue:', newGramValue);
			console.log('newCalories:', newCalories);
			$("#gram").val(newGramValue);
			$("#calorie").val(newCalories);

		}
	});
	// plus-button 클릭 이벤트
	$("#plus-button").off("click");
	$("#plus-button").on("click", function () {
		let currentValue = parseInt($("#gram").val());
		let enteredCalories = parseInt($("#calorie").val());

		// 값이 숫자인지 확인 후 처리
		if (!isNaN(currentValue) && !isNaN(enteredCalories)) {
			let newGramValue = currentValue + 10;
			let newCalories = Math.round(enteredCalories / currentValue * newGramValue);

			previousGramValue = newGramValue;

			$("#gram").val(newGramValue);
			$("#calorie").val(newCalories);
		}
	});

	// #gram 값이 변경될 때 이벤트 처리
	$("#gram").keyup(function (e) {
		let previousValue = previousGramValue;

		// 변경된 #gram 값 가져오기
		let enteredGram = Number($(this).val());

		// 동적으로 #calorie 값 업데이트
		if (enteredGram < 0) {
			// 0 미만이면 0으로 설정
			enteredGram = 0;
			$(this).val(0);  // 입력값도 0으로 설정
		}
		// 칼로리 계산
		enteredCalories = (enteredGram === 0) ? 0 : calculateCalories(previousValue, enteredGram);
		console.log(enteredCalories, previousValue, enteredGram);

		$("#calorie").val(enteredCalories);
	});
	/*--------------------
		모달 팝업 오픈 함수
	--------------------*/
	function openModal(foodData) {
		console.log("모달 열기 및 데이터 전달:", foodData);

		// 모달 내용 채우기
		$("#modalBody-title-text").text(foodData.food);
		$("#no").val(foodData.no);
		$("#gram").val(foodData.gram);
		previousGramValue = Number($("#gram").val());
		$("#calorie").val(foodData.calorie);
		
		let carbsText = (foodData.carbs / 324 * 100).toFixed(1);
		let proteinText = (foodData.protein / 55 * 100).toFixed(1);
		let fatText = (foodData.fat / 54 * 100).toFixed(1);
		let sugarText = (foodData.sugar / 100 * 100).toFixed(1);
		let saltText = (foodData.salt / 2000 * 100).toFixed(1);
		
		$("#carbs").text(foodData.carbs+"("+carbsText+"%)");
		$("#protein").text(foodData.protein+"("+proteinText+"%)");
		$("#fat").text(foodData.fat+"("+fatText+"%)");
		$("#sugar").text(foodData.sugar+"("+sugarText+"%)");
		$("#salt").text(foodData.salt+"("+saltText+"%)");
		
		animateProgressBar('#modalBody-carbs-graph', carbsText);
		animateProgressBar('#modalBody-protein-graph', proteinText);
		animateProgressBar('#modalBody-fat-graph', fatText);
		animateProgressBar('#modalBody-sugar-graph', sugarText);
		animateProgressBar('#modalBody-salt-graph', saltText);
		
		// 상태바 애니메이션
		function animateProgressBar(barSelector, targetPercentage) {
		    const bar = $(barSelector).find('.progress');
		
		    let currentWidth = 0;
		    const barAnimation = setInterval(() => {
		        bar.width(currentWidth + '%');
		        currentWidth++ >= targetPercentage && clearInterval(barAnimation);
		    }, 10); // interval은 10ms로 고정
		}
		
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
/*-------------
	세션 함수
-------------*/
//클릭 시, 값 확인하여 세션에 저장 함수
function cartMove(e) {
	//값 확인
	console.log($(e.currentTarget).data("foodno"));
	console.log($(e.currentTarget).children(".food-gram").children(".food").text());
	console.log($(e.currentTarget).children(".food-gram").children(".gram").text().replace('g', ''));
	console.log($(e.currentTarget).children(".calorie").text().replace('kcal/hr', ''));
	
	console.log($(".carbs").val());

	let no = $(e.currentTarget).data("foodno");
	let food = $(e.currentTarget).children(".food-gram").children(".food").text();
	let gram = $(e.currentTarget).children(".food-gram").children(".gram").text().replace('g', '');
	let calorie = $(e.currentTarget).children(".calorie").text().replace('kcal/hr', '');
	
	let carbs = $(".carbs").val();
	let protein = $(".protein").val();
	let fat = $(".fat").val();
	let sugar = $(".sugar").val();
	let salt = $(".salt").val();

	// 세션에서 기존 데이터 가져오기
	let existingData = sessionStorage.getItem("foodData");
	let existingFoodData = {};

	// 기존 데이터가 있으면 파싱
	if (existingData) {
		existingFoodData = JSON.parse(existingData);
	}
	// 최대 10개만 허용
	if (Object.keys(existingFoodData).length >= 10) {
		alert("최대 10개까지만 선택 가능합니다.");
		return;
	}
	// 이미 등록된 no인지 확인
	if (existingFoodData.hasOwnProperty(no)) {
		alert("이미 등록된 항목입니다.");
		return;
	} else {
		// 기존 데이터에 새로운 항목 추가 또는 덮어쓰기
		existingFoodData[no] = {
			no: no,
			food: food,
			gram: gram,
			calorie: calorie,
			carbs: carbs,
			protein: protein,
			fat: fat,
			sugar: sugar,
			salt: salt
		};
		// 세션에 데이터 저장
		sessionStorage.setItem("foodData", JSON.stringify(existingFoodData));

		//배경색 변경
		$(e.currentTarget).css("background-color", "#FAF8ED");
		//배경색 상태 저장
		sessionStorage.setItem("background-color", "#FAF8ED");

		// 새로운 항목을 장바구니에 추가
		addFoodToCart(existingFoodData[no]);
	}
}
//세션에서 모든 쿠키 값들 가져오기 >  페이지 로드 시에 세션에서 특정 데이터를 가져와서 목록에 추가하는 데 사용
function loadCartItems() {
	let foodInfo = sessionStorage.getItem("foodData")

	console.log(foodInfo);

	if (foodInfo) {
		// 세션 데이터가 있으면 파싱하여 운동 목록에 추가
		let foodData = JSON.parse(foodInfo);
		for (let key in foodData) {
			if (foodData.hasOwnProperty(key)) {
				console.log("foodData"+foodData[key]);
				addFoodToCart(foodData[key]);
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
function addFoodToCart(foodData) {
	//받은 데이터로 운동 목록에 값 생성
	const foodInfoSelect = $('<div class="foodInfo-select"></div>');

	const foodInfoDetail = $('<div class="foodInfo-detail"></div>');
	foodInfoDetail.append('<div class="foodInfo-name"><div class="foodInfo-name-text">' + foodData.food + '</div><div class="foodInfo-name-gram">' + foodData.gram + 'g</div></div>');
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
	let totalGram = 0;
	let totalCalorie = 0;

	$('.foodInfo-detail').each(function () {
		const gramText = $(this).find('.foodInfo-name-gram').text();
		const calorieText = $(this).find('.foodInfo-cals').text();

		// 분 추출
		const gram = parseInt(gramText.replace('g', ''));
		// 칼로리 추출
		const calorie = parseInt(calorieText.replace('kcal', ''));

		// 누적
		totalGram += gram;
		totalCalorie += calorie;
	});

	console.log('Total Gram:', totalGram);
	console.log('Total Calorie:', totalCalorie);

	//기존 값에 입력
	$("#total-calTime").text(totalCalorie);
}
/*----------
	캘린더
----------*/
function calendarHandler() {
	//일자 설정
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn: "both",
		buttonText: "",
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