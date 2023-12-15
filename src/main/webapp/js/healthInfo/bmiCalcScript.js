//bmi 계산
$(function() {
	$('#bmi-calc').click(function(e) {
		e.preventDefault();
		if (bmiConfirm()) {
			bmiCalc();
		}
	});
	//입력 확인 알림창
	function bmiConfirm() {
		if ($("#age").val() === '') {
			alert('나이를 입력하세요');
			$("#age").focus();
			return false;
		}
		if ($("#height").val() === '') {
			alert('신장을 입력하세요');
			$("#height").focus();
			return false;
		}
		if ($("#weight").val() === '') {
			alert('체중을 입력하세요');
			$("#weight").focus();
			return false;
		}
		if ($("input[name='gender']:checked").val() === undefined) {
			alert('성별을 선택하세요');
			return false;
		}
		if ($("#target_weight").val() === '') {
			alert('목표 몸무게를 입력하세요');
			$("#target_weight").focus();
			return false;
		}
		if ($("#exercise_mass").val() === '') {
			alert('평소 운동량을 입력하세요');
			$("#exercise_mass").focus();
			return false;
		}
		return true;
	}
	//계산
	function bmiCalc(){
		//입력받은 값
		const age = parseFloat($("#age").val());
		const height = parseFloat($("#height").val());
		const weight = parseFloat($("#weight").val());
		const gender = $("input[name='gender']:checked").val();
		const target_weight = parseFloat($("#target_weight").val());
		const exercise_mass = $("#exercise_mass").val();

		//계산 값
		let avgWeight;
		let difWeight;
		let aimResult;
		
		let bmi;
		let bmiResult;
		
		let target_calorie;
		let target_carbs;
		let target_protein;
		let target_fat;
		let target_sugar;
	
		
		//평균 체중
		if(gender==="1") {
			avgWeight = Math.round(Math.pow(height/100, 2)*22*100)/100;
		}
		if(gender==="2") {
			avgWeight = Math.round(Math.pow(height/100, 2)*21*100)/100;
		}
		
		//체중 차이
		difWeight = Math.round(Math.abs(target_weight-avgWeight)*100)/100;
		
		//목표 체중 범위
		if(Math.round(Math.abs(weight-target_weight)) < 1) {
			aimResult = "유지";
		}
		else if(Math.round(weight-target_weight) < 0) {
			aimResult = "체중 증량";
		}
		else if(Math.round(weight-target_weight) >= 0) {
			aimResult = "체중 감소";
		}
		
		//bmi
		bmi = Math.round(weight/Math.pow(height/100, 2)*100)/100;
		
		//bmi 결과
		if(bmi >= 30) {
			bmiResult = "비만";
		}
		else if(bmi >= 25) {
			bmiResult = "과체중";
		}
		else if(bmi >= 20) {
			bmiResult = "정상";
		}
		else if(bmi < 20) {
			bmiResult = "저체중";
		}
			
		//섭취 목표 칼로리
		if(exercise_mass === "1") {
			target_calorie = Math.round(avgWeight*25);
		}
		if(exercise_mass === "2") {
			target_calorie = Math.round(avgWeight*30);
		}
		if(exercise_mass === "3") {
			target_calorie = Math.round(avgWeight*35);
		}
		
		//하루 목표 영양소 > 유지인 경우는 제외
		if(aimResult = "체중 증량") {
			target_calorie = target_calorie*1.1;
		}
		else if(aimResult = "체중 감소") {
			target_calorie = target_calorie*0.9;
		}
		
		target_carbs = Math.round((target_carbs*0.5)/4);
		target_protein = Math.round((target_carbs*0.3)/4);
		target_fat = Math.round((target_carbs*0.2)/9);
		target_sugar = Math.round((target_carbs*0.1)/4);
		
		console.log(target_calorie)
		console.log(target_carbs)
		console.log(target_protein)
		console.log(target_fat)
		console.log(target_sugar)
		//계산값 텍스트 삽입
		$("#avgWeight").text(avgWeight.toFixed(1));
		$("#difWeight").text(difWeight.toFixed(1));
		$("#aimResult").text(aimResult);
		
		$("#bmi").text(bmi.toFixed(2));
		$("#bmiResult").text(bmiResult);
		$("#target_calorie").text(target_calorie);
	}
});