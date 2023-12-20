$(function() {
	$("#search-text").click(function() {
		search(70, 60)
	});
	function search(kg, minute) {
    	location.href = "/myct/exercise?healthName=" + $('#healthName').val() + "&kg=" + kg + "&minute=" + minute
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