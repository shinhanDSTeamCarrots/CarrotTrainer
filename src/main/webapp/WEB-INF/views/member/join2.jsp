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

function loginDone() {
    var check = document.getElementsById('body');
    var isChecked = false;
    for (var i = 0; i < check.length; i++) {
        if($("#body").is(":checked")) {
            isChecked = true;
            break;
        }
    }
    /*최소 하나 체크하는 방법 어떻게 할지, 버튼 모양 어떻게 할지 생각하기*/

   
    if (!isChecked) {
        alert('최소 하나의 항목에 체크해 주세요.');
        return false; 
    }

    else{
    	alert('회원 가입을 축하합니다!');
    	
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

   /* .btn {
       
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
    				<form name="frm" id="frm" action="" method="get">
    				<div class="btn-container">
    					<a href="javascript:;" class="btn" id = "body" onclick="">눈</a>
    					<a href="javascript:;" class="btn" id = "body" onclick="">귀</a>
    					<a href="javascript:;" class="btn" id = "body" onclick="">간</a>
    				</div>
    				<div class="btn-container">
    					<a href="javascript:;" class="btn" id = "body" onclick="">기관지</a>
    					<a href="javascript:;" class="btn" id = "body" onclick="">위</a>
    					<a href="javascript:;" class="btn" id = "body" onclick="">장</a>
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