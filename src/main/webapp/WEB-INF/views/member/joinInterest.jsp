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
    /*var checkboxes = document.getElementsByName('body');
    var selectedValues = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            // checkbox의 name 속성값을 가져와서 배열에 추가
            selectedValues.push(checkboxes[i].name);
        }
    }
    var stringValue = selectedValues.join(",");

    if (stringValue.length == 0) {
        alert("최소 하나의 항목을 선택해 주세요.");
    } else {
        $.ajax({
            type: 'GET',
            url: 'interestRegist',
            data: { selectedValues: stringValue },
            success: function (response) {
                alert('회원 가입을 축하해요!');
            },
            error: function (error) {
                console.error('에러 발생:', error);
            }
        });
    }*/
    if ($('input[name="chklist"]:checked').length === 0) {
        alert("하나 이상의 체크박스를 선택해주세요.");
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
    
    /* Styling for titles */
.title {
    margin-bottom: 20px;
    color: #333; /* Dark grey color for text */
    font-size: 1.5em; /* Larger font size for titles */
}
    .wrap { 
    	margin:auto; 
        text-align:center;
        } 
.container {
  max-width: 1200px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f9f9f9; /* Soft background color */
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1); /* Subtle shadow */
  
}

    .menu {
        text-align: center;
    }

    .btn-container {
        display: flex;
        justify-content: center; /* 추가: 수평 가운데 정렬 */
        text-align : center;
        font-size: 15px; /* 수정: font 속성을 font-size로 변경 */
        margin-bottom:30px;
    }
    
    .btn-container2 {
        display: flex;
        justify-content: center; /* 추가: 수평 가운데 정렬 */
        text-align : center;
        font-size: 15px; /* 수정: font 속성을 font-size로 변경 */
        margin-bottom: 100px;
    }

  	input{
  	margin-left: 5px;
  	margin-right: 5px;
  	margin-bottom: 3px;
  	margin-top : 3px;
  	
  	}
   
             /* Button-like styles for custom checkboxes */
.custom-checkbox {
    display: inline-block;
    padding: 10px 20px;
    margin: 10px;
    font-size: 1rem;
    color: #fff;
    background-color: #007bff; /* Primary button color */
    border-radius: 20px; /* Rounded borders */
    cursor: pointer;
    transition: background-color 0.2s; /* Smooth transition for hover effect */
}

.custom-checkbox:hover {
    background-color: #0056b3; /* Darker shade on hover */
}

/* Invisible but accessible real checkboxes */
.custom-checkbox input[type="checkbox"] {
    display: none; /* Hide the default checkbox */
}

/* Styling for the join button */
.doneButton a {
    display: inline-block;
    padding: 12px 25px;
    margin-top: 30px;
    background-color: #609966; /* Success color */
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.2s;
}

.doneButton a:hover {
    background-color: #489450;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .container {
        width: 90%;
    }
    .title {
        font-size: 1.2em; /* Slightly smaller font size on smaller screens */
    }
}
     
    </style>
    	
	
</head>
<body>
    <div class="wrap">
    	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    	<div class="container">
    		
    			<h2 class = "title">건강해지고 싶은 부위?</h2>
    				<h3 class = "title">관심 있는 신체 부위에 체크해 보아요. 저희가 도와드릴게요!<br>(최소 1개 선택, 중복선택 가능)</h3>  
    				  				
    				<form name="frm" id="frm" action="joinInterest" method="Post">
    				<div class="btn-container">
    					<input type = "checkbox" name = "chklist" value="1" id ="body_eye" >눈
    					<input type = "checkbox" name ="chklist" value="2" id ="body_ear">귀
    					<input type = "checkbox" name = "chklist" value="3" id ="body_liver" >간
    				</div>
    				<div class = "btn-container2">	
    					<input type = "checkbox" name = "chklist" value="4" id ="body_lung" >기관지
    					<input type = "checkbox" name = "chklist" value="5" id ="body_stomach" >위
    					<input type = "checkbox" name = "chklist" value="6" id ="body_intestine" >장
 
          				
    				</form>
    				<div class = "doneButton">
    					<a href="javascript:;" onclick="joinDone();">가입</a>
    				</div>
    	</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>