$(function () {
	new Chart(document.getElementById("line-chart"), {
		type: 'line',
		data: {
			labels: ["12/7", "12/8", "12/9" , "12/10", "12/11", "12/12"],
			datasets: [{
				data: [50, 53, 52, 50, 48, 46],
				label: "체중",
				borderColor: "#F9B572",
				fill: false
			}, {
				data: [20.3, 20.1, 21.0, 22.0, 23.0, 24.0],
				label: "근육량",
				borderColor: "#435334",
				fill: false
			}, {
				data: [30.0, 32.0, 33.0, 29.0, 28.5, 26.3],
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
	      labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
	      datasets: [
	        {
	          label: "Population (millions)",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
	          data: [2478,5267,734,784,433]
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: 'Predicted world population (millions) in 2050'
	      }
	    }
    });
    
    new Chart(document.getElementById("exerciseDoughnut-chart"), {
    	type: 'doughnut',
	    data: {
	    	labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
	      datasets: [
	        {
	          label: "Population (millions)",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
	          data: [2478,5267,734,784,433]
	        }
	      ]
	    },
	    options: {
	      title: {
	        display: true,
	        text: 'Predicted world population (millions) in 2050'
	      }
	    }
	});
});