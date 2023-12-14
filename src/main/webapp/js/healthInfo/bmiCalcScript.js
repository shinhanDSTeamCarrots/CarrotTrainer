//bmi 계산
$(function() {
	$('#bmi-calc').click(function(e) {
		e.preventDefault();
		bmiCalc();
	});
	function bmiCalc(){
		//입력받은 값
		const age = document.getElementById("age");
		const height = document.getElementById("height");
		const weight = document.getElementById("weight");
		const gender = $("input[name='gender']:checked").val();
		const target_weight = document.getElementById("target_weight");
		const exercise_mass = $("#exercise_mass").val();

		//계산 값
		const avgWeight = document.getElementById("avgWeight");
		const difWeight = document.getElementById("difWeight");
		
		const bmi = document.getElementById("bmi");
		const bmiResult = document.getElementById("bmiResult");
		const target_calorie = document.getElementById("target_calorie");
	
		
		//평균 체중
		if(gender==="1") {
			$("#avgWeight").text(Math.round(Math.pow(height.value/100, 2)*22*10)/10);
		}
		if(gender==="2") {
			$("#avgWeight").text(Math.round(Math.pow(height.value/100, 2)*21*10)/10);
		}
		
		//체중 차이
		$("#difWeight").text(Math.round(Math.abs(target_weight.value-$("#avgWeight").text())*10)/10);
		
		//bmi
		$("#bmi").text(Math.round(weight.value/Math.pow(height.value/100, 2)*10)/10);
		
		//bmi 결과
		if($("#bmi").text() >= 30) {
			$("#bmiResult").text("비만");
		}
		else if($("#bmi").text() >= 25) {
			$("#bmiResult").text("과체중");
		}
		else if($("#bmi").text() >= 20) {
			$("#bmiResult").text("정상");
		}
		else if($("#bmi").text() < 20) {
			$("#bmiResult").text("저체중");
		}
			
		//섭취 목표 칼로리
		if(exercise_mass==="1") {
			$("#target_calorie").text(Math.round($("#avgWeight").text()*25));
		}
		if(exercise_mass==="2") {
			$("#target_calorie").text(Math.round($("#avgWeight").text()*30));
		}
		if(exercise_mass==="3") {
			$("#target_calorie").text(Math.round($("#avgWeight").text()*35));
		}
	}
});