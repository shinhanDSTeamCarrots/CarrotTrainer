$(function() {
	$("#search-text").click(function() {
		$.ajax({
			url:'exercise',
			data:{healthName:$('#healthName').val()},
			success:function(res) {
				console.log(res);
				if (res == 'true') {
					console.log('검색 성공')
					$("#healthName").val('');
					$("#healthName").focus();
				} else {
					console.log('검색 실패')
				}
			}
		})
	})
})