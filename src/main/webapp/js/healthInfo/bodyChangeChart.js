function drawGraphs(foodchange, healthchange,bodychange){

	new Chart(document.getElementById("line-chart"), {
		type: 'line',
		data: {
			labels: [bodychange[0]['regist_date'],bodychange[1]['regist_date'],bodychange[2]['regist_date'] , bodychange[3]['regist_date'], bodychange[4]['regist_date'], bodychange[5]['regist_date'],bodychange[6]['regist_date']],
			datasets: [{
				data: [bodychange[0]['weight'],bodychange[1]['weight'], bodychange[2]['weight'], bodychange[3]['weight'], bodychange[4]['weight'], bodychange[5]['weight'],bodychange[6]['weight']],
				label: "체중",
				borderColor: "#F9B572",
				fill: false
			}, {
				data: [bodychange[0]['muscle_mass'],bodychange[1]['muscle_mass'], bodychange[2]['muscle_mass'], bodychange[3]['muscle_mass'], bodychange[4]['muscle_mass'], bodychange[5]['muscle_mass'],bodychange[6]['muscle_mass']],
				label: "근육량",
				borderColor: "#435334",
				fill: false
			}, {
				data: [bodychange[0]['fat_mass'],bodychange[1]['fat_mass'], bodychange[2]['fat_mass'], bodychange[3]['fat_mass'], bodychange[4]['fat_mass'], bodychange[5]['fat_mass'],bodychange[6]['fat_mass']],
				label: "체지방률",
				borderColor: "#CEDEBD",
				fill: false
			}
		]
	},
	options: {
	  title: {
	  	display: true,
	  	text: '나의 피트니스 차트'
	  }
	 }
	});
	
	new Chart(document.getElementById("foodBar-chart"), {
	    type: 'bar',
	    data: {
	      labels: ["6일 전", "5일 전", "4일 전", "3일 전", "2일 전", "하루 전", "오늘"],
	      datasets: [
	        {
	        	label : "아침",
	        	backgroundColor: "#F9B572",
	        	data: [foodchange['1_1'], foodchange['2_1'], foodchange['3_1'], foodchange['4_1'], foodchange['5_1'], foodchange['6_1'], foodchange['7_1']]
	        },
	        {
	        	label : "점심",
	        	backgroundColor: "#435334",
	        	data: [foodchange['1_2'], foodchange['2_2'], foodchange['3_2'], foodchange['4_2'], foodchange['5_2'], foodchange['6_2'], foodchange['7_2']]
	        },
	        {
	        	label : "저녁",
	        	backgroundColor: "#CEDEBD",
	        	data: [foodchange['1_3'], foodchange['2_3'], foodchange['3_3'], foodchange['4_3'], foodchange['5_3'], foodchange['6_3'], foodchange['7_3']]
	        }
	      ]
	    },
	    options: {
	      legend: { display: true },
	      title: {
	        display: true,
	        text: '일주일간의 변화'
	      }
	    }
	});
	new Chart(document.getElementById("exerciseDoughnut-chart"), {
		type: 'doughnut',
	    data: {
	    	labels: [healthchange[0]['name'], healthchange[1]['name'], healthchange[2]['name'], healthchange[3]['name'], healthchange[4]['name'],healthchange[5]['name'],healthchange[6]['name']],
	      datasets: [
	        {
	          label: "운동 횟수",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850","#F9B572","#435334"],
	          data: [healthchange[0]['cnt'],healthchange[1]['cnt'],healthchange[2]['cnt'],healthchange[3]['cnt'],healthchange[4]['cnt'],healthchange[5]['cnt'],healthchange[6]['cnt']]
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: '일주일간의 운동기록 (상위 7개)'
	      }
	    }
	});
}