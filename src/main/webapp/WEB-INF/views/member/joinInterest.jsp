<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심부위 설정</title>
<META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
	<script src="js/script.js"></script>
<script>



/*function joinDone() {
    const buttons = document.querySelectorAll('.btn');
    const selectedButtons = [];

    buttons.forEach(button => {
        if (button.style.backgroundColor === 'green') {
            selectedButtons.push(button.id);
        }
    });

    if (selectedButtons.length === 0) {
        alert('최소 하나의 항목을 선택하세요.');
    } else {
        // Ajax를 사용하여 서버에 선택된 버튼 정보 전송
        $.ajax({
            type: 'POST',
            url: 'interestRegist', 
            contentType: 'application/json',
            data: JSON.stringify({ selectedButtons: selectedButtons }),
            success: function (response) {
                alert('회원 가입을 축하해요!');
            },
            error: function (error) {
                console.error('에러 발생:', error);
            }
        });
    }
}

let clickCount = 0;

function changeColor(button) {
    clickCount++;

    if (clickCount % 2 === 1) {
        // 홀수 번 클릭
        button.style.backgroundColor = 'green';
    } else {
        // 짝수 번 클릭
        button.style.backgroundColor = 'white';
    }
}*/

function joinDone() {
    var checkboxes = document.getElementsByName('body');
    var selectedValues = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            // checkbox의 name 속성값을 가져와서 배열에 추가
            selectedValues.push(checkboxes[i].name);
        }
    }

    // 배열의 값을 String으로 변환하고 합치기
    var stringValue = selectedValues.join("");
    var numValue = parseInt(stringValue, 10);
    if(stringValue ==""){
    	alert("최소 하나의 항목을 선택해 주세요.");
    } else{
    	$.ajax({
    		type : 'GET',
    		url: 'interestRegist',
    		data: numValue,
    		success: function(response){
    			alert('회원 가입을 축하해요!');
    		},
            error: function (error) {
                console.error('에러 발생:', error);
            }
    		
    	});
    }
    $("#frm").submit();  
}



</script>
<style>


		#body{
                    display: inline-block;
                    outline: 0;
                    cursor: pointer;
                    padding: 5px 16px;
                    font-size: 14px;
                    font-weight: 500;
                    line-height: 20px;
                    vertical-align: middle;
                    border: 1px solid;
                    border-radius: 6px;
                    color: #ffffff;
                    background-color: #2ea44f;
                    border-color: #1b1f2326;
                    box-shadow: rgba(27, 31, 35, 0.04) 0px 1px 0px 0px, rgba(255, 255, 255, 0.25) 0px 1px 0px 0px inset;
                    transition: 0.2s cubic-bezier(0.3, 0, 0.5, 1);
                    transition-property: color, background-color, border-color;
                    :hover {
                        background-color: #2c974b;
                        border-color: #1b1f2326;
                        transition-duration: 0.1s;
                    }
             }   
    /*******나중에 컨테이너 부분 수정해야 함(지금 내용은 임시책)*******/
    /*	.container{
		    display: flex;
		    flex-direction: row;
		    justify-content: center;
		    height : 1600px;		    
    	}
    	.menu{
    		text-align: center;
    	}
    	.btn-container {
        display: flex;
        text-align : center;
        font : 20px;
    }

    .btn {
        margin-right: 20px;
        text-align : center;
       
    } */
    
    .title{
    justify-content:center;
    margin-bottom: 40px;
    }
    .container {
        display: flex;
        flex-direction: row;
        justify-content: center;
         /* 추가: 수직 가운데 정렬 */
        height: 1600px;
    }

    .menu {
        text-align: center;
    }

    .btn-container {
        display: flex;
        justify-content: center; /* 추가: 수평 가운데 정렬 */
        text-align : center;
        font-size: 25px; /* 수정: font 속성을 font-size로 변경 */
        margin-bottom: 100px;
    }

  
    
    .doneButton{
    	font-size: 40px;
    }
    .btn:hover {
            background-color: green; 
        }
             
     
    </style>
    	
	
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class = "menu">
    			<h2 class = "title">건강해지고 싶은 부위?</h2>
    				<h3 class = "title">관심 있는 신체 부위에 체크해 보아요. 저희가 도와드릴게요!<br>(최소 1개 선택, 중복선택 가능)</h3>  
    				  				
    				<form name="frm" id="frm" action="joinInterest" method="get">
    				<div class="btn-container">
    					<input type = "checkbox" name = "1" id ="body" >눈
    					<input type = "checkbox" name ="2" id ="body">귀
    					<input type = "checkbox" name = "3" id ="body" >간
    					<input type = "checkbox" name = "4" id ="body" >기관지
    					<input type = "checkbox" name = "5" id ="body" >위
    					<input type = "checkbox" name = "6" id ="body" >장
                    </div>
                    
          				
    				</form>
    				<div class = "doneButton">
    					<a href="javascript:;" onclick="joinDone();">가입</a>
    				</div>
    		</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>