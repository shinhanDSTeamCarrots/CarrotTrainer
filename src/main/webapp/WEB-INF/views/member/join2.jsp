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

function joinDone() {
    // btn 클래스를 가진 모든 요소를 선택
    const buttons = document.querySelectorAll('.btn');

    // 초록색인 버튼의 개수를 세기 위한 변수
    let greenCount = 0;

    // 각 버튼에 대해 반복
    buttons.forEach(button => {
        if (button.style.backgroundColor === 'green') {
            greenCount++;
        }
    });

    // 초록색인 버튼이 하나도 없을 경우 알림창 띄우기
    if (greenCount === 0) {
        alert('최소 하나의 항목을 선택하세요.');
    } else {
        alert('회원 가입을 축하해요!')
        //데이터 저장&홈페이지로 이동시키는 방법 생각하기
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
}

</script>
<style>
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

    .btn {
       
       margin-right: 150px;
       margin-left : 150px;
       border-style: solid;
       width : 200px;
       height: 100px;
       
       
       border-color: black;
       background-color:white;
       border-radius: 30%;
       
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .doneButton{
    	font-size: 40px;
    }
    .btn:hover {
            background-color: green; /* 마우스를 올렸을 때 색상 변경 */
        }
    /* 클릭했을 때 초록색 되는 방법, 초록색인 버튼 값만 데이터에 저장하는 방법 생각 */         
     
    </style>
    	
	
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		<div class = "menu">
    			<h2 class = "title">건강해지고 싶은 부위?</h2>
    				<h3 class = "title">관심 있는 신체 부위에 체크해 보아요. 저희가 도와드릴게요!<br>(최소 1개 선택, 중복선택 가능)</h3>    				
    				<form name="frm" id="frm" action="join2.do" method="get">
    				<div class="btn-container">
    					<a href="javascript:;" class="btn" id = "body1" onclick="changeColor(this)">눈</a>
    					<a href="javascript:;" class="btn" id = "body2" onclick="changeColor(this)">귀</a>
    					<a href="javascript:;" class="btn" id = "body3" onclick="changeColor(this)">간</a>
    				</div>
    				<div class="btn-container">
    					<a href="javascript:;" class="btn" id = "body4" onclick="changeColor(this)">기관지</a>
    					<a href="javascript:;" class="btn" id = "body5" onclick="changeColor(this)">위</a>
    					<a href="javascript:;" class="btn" id = "body6" onclick="changeColor(this)">장</a>
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