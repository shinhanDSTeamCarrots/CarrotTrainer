//유저이름 불러오기
$(function() {
	const memberName = "${sessionScope.loginInfo.member_name}";
	userNamecheck();
	
	function userNamecheck() {
		if(memberName) {
			$(".sql-text-name").text("비회원");
			$(".sql-result-text-name").text("비회원");
		}
		if(!memberName) {
			$(".sql-text-name").text(memberName);
			$(".sql-result-text-name").text(memberName);
		}
	}
});