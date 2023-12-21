//<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
//<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
$(function() {
	$("#search-text").click(function() {
		search(60);
	});
	//운동 클릭 시, 장바구니로 이동
	$(".health-info").click(function() {
		cartMove.call(this);
		calculateTotal();
	});
	//북마크 클릭 시, db에 저장(로그인이 되어있을 경우에만)
	$(".health-info .bookmark").click(function(event) {
	  // 상위 이벤트 막기
	  event.stopPropagation(); // 또는 return false; 를 사용 가능

	  // 클릭 시, 로그인이 되어있을 때, db에 저장
	  console.log($(this).closest(".health-info").data("no"));
	  insertBookmark();
	  //이미 등록되어있는 지 확인 > 등록되어있으면 색상 변경 안함/없으면 등록
	  //등록 시, 확인 컨펌창 띄우기(?즐찾할거니 정말 뺼거니?)
	  
	});
	
	//장바구니에 있는 운동 클릭 시, 모달 팝업
	$(".healthInfo-name").click(function() {
		// 받은 데이터로 모달 내용 생성
		console.log("gg")
		
	});
	function insertBookmark() {
		const userName = "${sessionScope.loginInfo}";
		if (userName) {	//로그인이 되어있을 때
		} else {	//비로그인일 때
			if(confirm("로그인이 필요한 기능입니다.\n로그인하시겠습니까?")){
				location.href=(""); //로그인 페이지로 이동
			}
		}
	}
	
	
	//검색 함수 - 검색 완료 시, 페이지 리로드
	function search(minute) {
    	location.href = "/myct/exercise?healthName=" + $('#healthName').val();
    }
    //클릭 시, 진행 운동 목록으로 이동 함수
    function cartMove() {
    	//값 확인
    	console.log($(this).data("no"));
		console.log($(this).children(".health").text());
		console.log($(this).children(".calorie").text().replace('kcal/hr', ''));
		
		let no = $(this).data("no");
		let health = $(this).children(".health").text();
		let minute = 60; //기본값
		let calorie = $(this).children(".calorie").text().replace('kcal/hr', '');
		
		// 받은 데이터로 목록 생성
    	const healthInfoSelect = $('<div class="healthInfo-select"></div>');
    	
    	const healthInfoDetail = $('<div class="healthInfo-detail"></div>');
    	healthInfoDetail.append('<div class="bookmark">&#9733;</div>'); //즐겨찾기 이미지
	    healthInfoDetail.append('<div class="healthInfo-name"><div class="healthInfo-name-text">' + health + '</div><div class="healthInfo-name-time">' + minute + '분</div></div>');
	    healthInfoDetail.append('<div class="healthInfo-cals">' + calorie + 'kcal</div>');
	    healthInfoDetail.append('<div class="healthInfo-del">-</div>');  //빼기 이미지
	    
	    healthInfoSelect.append(healthInfoDetail);
	    healthInfoSelect.append('<div class="detail-division-line"></div>');

        $('.healthInfo-cart').append(healthInfoSelect);
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