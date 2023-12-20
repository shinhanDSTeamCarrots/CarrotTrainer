package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ExerciseController {
	
	@Autowired
	HealthDicService service;
	
	/*
	//기본 목록 불러오기
	@GetMapping("/exercise")
	public String exercise(Model model) {
		model.addAttribute("healthDic", service.getHealthDic("", 70, 60));
		return "/healthInfo/exercise";
	}

	//검색 결과 불러오기
	@ResponseBody
	@GetMapping("/getHealthDic")
	public List<Map<String, Object>> searchWord(@RequestParam String healthName,@RequestParam int kg,@RequestParam int minute) {
		return service.getHealthDic(healthName, kg, minute);
	}*/
	@GetMapping("/exercise")
	public String searchHealthInfo(Model model,String healthName,Integer kg,Integer minute) {
		if(kg==null && minute==null ) {
			kg=70;
			minute=60;
		}
		System.out.println(healthName);
		System.out.println(kg);
		System.out.println(minute);
		model.addAttribute("healthDic", service.getHealthDic(healthName, kg, minute));
		return "/healthInfo/exercise";
	}
}
