<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- fmt 태그를 통해서 '년도/월/일' 형식으로 출력 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>자유게시판</title>
<META name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</head>
<style>

body {
  font-family: 'Roboto', sans-serif;
  color: #333;
  background-color: #f4f4f4;
}

.container {
  max-width: 1200px;
  margin: 50px auto;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.board-title {
  font-size: 2.4rem;
  color: #4CAF50;
  margin-bottom: 20px;
}

table {
  width: 100%; 
  border-collapse: collapse;
  margin-top: 20px;
}

th, td {
  padding: 20px; 
  text-align: center;
  border-bottom: 1px solid #ddd;
  font-size: 1.4rem; 
}

th {
  background-color: #4CAF50;
  color: white;
}


.pagination {
	margin-top: 20px;
	text-align: center;
}

.pagination span {
	margin: 0 5px;
	cursor: pointer;
	font-size: 25px;
}

.search-container {
	text-align: right;
	margin-top: 20px;
}

.search-input {
	padding: 10px 15px; /* 입력창 내부 여백을 좌우로 제공 */
	font-size: 1.6rem; /* 입력창 글씨 크기 조정 */
	border: 1px solid #ddd; /* 테두리 스타일 조정 */
	margin-right: 8px; /* 입력창과 검색버튼 사이의 간격 조정 */
	width: 300px; /* 입력창 너비 조정 */
	height: 48px; /* 입력창 높이 조정 */
	vertical-align: middle; /* 입력창을 수직 중앙에 위치시키기 위함 */
}

.search-button {
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	padding: 0 20px; /* 버튼 내부 여백을 좌우로만 제공 */
	border: none; /* 테두리 없음 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 클릭 가능한 커서 모양 */
	font-size: 1.6rem; /* 버튼 글씨 크기 조정 */
	height: 38px; /* 버튼 높이 조정 */
	line-height: 38px; /* 버튼의 높이에 맞춰 line-height 설정 */
	text-align: center; /* 텍스트를 버튼의 중앙으로 정렬 */
	display: inline-block; /* inline-block으로 설정하여 line-height가 적용되도록 함 */
	vertical-align: middle; /* 버튼을 수직 중앙에 위치시키기 위함 */
	white-space: nowrap; /* 텍스트를 한 줄로 유지 */
}

.write-btn-container {
	text-align: right; /* 버튼을 오른쪽으로 정렬 */
	margin: 20px 0 20px; /* 상단 여백 추가 */
}

.write-button {
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	padding: 10px 20px; /* 패딩 */
	border: none; /* 테두리 없음 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 클릭 가능한 커서 모양 */
	font-size: 1.0rem; /* 글씨 크기 */
	margin-bottom: 0px; /* 하단 여백 추가 */
}


  .pageInfo{
      list-style : none;
      display: inline-block;
    margin: 50px 0 0 400px;      
  }
  .pageInfo li{
      float: left;
    font-size: 20px;
    margin-left: 18px;
    padding: 7px;
    font-weight: 500;
  }
 a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: underline;}
   .active{
      background-color: #cdd5ec;
  }
  
  .search_area{
    display: inline-block;
    margin-top: 30px;
    margin-left: 0px;
  }
  .search_area input{
      height: 30px;
    width: 250px;
  }
  .search_area button{
     width: 100px;
    height: 36px;
    background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	font-size: 1.3rem; /* 버튼 글씨 크기 조정 */
  }
  
  .search_area select {
  	height: 35px;
  }
</style>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="container">
			<div class="board-title">자유게시판</div>
			<!-- 글쓰기 버튼 추가 -->
			<div class="write-btn-container">
			<c:if test="${!empty loginInfo }">
				<a href="write.do" class="write-button">게시판 등록</a>
				</c:if>
			</div>

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회</th>
						<th>카테고리</th>
						<th>추천수<th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="list">
					  <c:if test="${list.category_no == 2}">
						<tr>
							<td><c:out value="${list.board_no}" /></td>
							<%--  <td>
							<a class="move" href='<c:out value="${list.board_no}"/>'>
									<c:out value="${list.board_title}" />
							</a>
							</td> --%>
							
								 <td>
								<a class="move" href="javascript:void(0);" onclick="ViewCount(${list.board_no});">
										<c:out value="${list.board_title}" />
								</a></td> 
								<td><c:out value="${list.member_nickname}" /></td>

							<td><fmt:formatDate pattern="yyyy/MM/dd"
									value="${list.board_rdate}" /></td>
							<td><c:out value="${list.board_view}" /></td>
							<td>자유게시판</td>
							<td>111</td>

						</tr>
						</c:if>
					</c:forEach>

					<!-- 추가 게시물 행을 여기에 추가 -->
				</tbody>
			</table>

			<div class="search_wrap">
        <div class="search_area">
        <select name="type">
                <option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
                <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
                <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
                <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
                <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 + 내용</option>
                <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 + 작성자</option>
                <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 + 내용 + 작성자</option>
            </select>  
            <input type="text" name="keyword" value="${pageMaker.cri.keyword }">
            <button>검색</button>
        </div>
    </div>   


			<div class="pageInfo_wrap" >
		<div class="pageInfo_area">
			<ul id="pageInfo" class="pageInfo">
			
				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
				</c:if>
				
				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
    <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? 'active' : ''}">
        <a href="${num}">${num}</a>
    </li>
</c:forEach>

				
				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>	
				
			</ul>
		</div>
	</div>
	




			<form id="moveForm" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
					<input type="hidden" name="type" value="${pageMaker.cri.type }">
			</form>
		</div>


		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	

	<script>
		$(document).ready(function() {

			let result = '<c:out value="${result}"/>';

			checkAlert(result);

			function checkAlert(result) {

				if (result === '') {
					reutrn;
				}

				if (result === "enrol success") {
					alert("등록이 완료되었습니다.");
				}

				if (result === "modify success") {
					alert("수정이 완료되었습니다.");
				}

				if (result === "delete success") {
					alert("삭제가 완료되었습니다.");
				}
			}

		});
		
		
		 let moveForm = $("#moveForm");
	  	 
	  

		/*  $(".move").on("click", function(e) {
							e.preventDefault();
							//moveForm.empty();

							moveForm.append("<input type='hidden' name='board_no' value='"	
											+ $(this).attr("href") + "'>");
							moveForm.attr("action", "/myct/board/freedetail.do");
							moveFo rm.submit();
						});    */
						
						  function ViewCount(boardNo) {
							 window.location.href = '/myct/board/freedetail.do?board_no=' + boardNo;
							 
							 
					        
					      /*  $.ajax({
					            url: '/myct/board/updateViewCount',
					            type: 'POST',
					            data: { board_no: boardNo },
					            success: function(response) {
					            	console.log("AJAX response:", response);
					                if(response === 'success') {
					        
					                   window.location.href = '/myct/board/freedetail.do?board_no=' + boardNo;
					                } else {
					                    alert('조회수 증가에 실패했습니다.');
					                }
					            },
					            error: function(xhr, status, error) {
					                console.error("Error incrementing view count");
				
					            }
					        });
					        */
					    }

		

		$(".pageInfo a").on("click", function(e) {

			e.preventDefault();
			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			moveForm.attr("action", "/myct/board/freeboard.do");
			moveForm.submit();

		});
		

	    $(".search_area button").on("click", function(e){
	        e.preventDefault();
	        
	        let type = $(".search_area select").val();
	        let keyword = $(".search_area input[name='keyword']").val();
	        
	        if(!type){
	            alert("검색 종류를 선택하세요.");
	            return false;
	        }
	        
	        if(!keyword){
	            alert("키워드를 입력하세요.");
	            return false;
	        }        
	        
	        moveForm.find("input[name='type']").val(type);
	        moveForm.find("input[name='keyword']").val(keyword);
	        moveForm.find("input[name='pageNum']").val(1);
	        moveForm.submit();
	    });
	</script>
</body>
</html>