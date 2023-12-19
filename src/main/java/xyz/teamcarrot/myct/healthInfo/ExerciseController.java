package xyz.teamcarrot.myct.healthInfo;

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
	
	//기본 목록
	@ResponseBody
	@GetMapping("/exercise.do")
	public String exercise(Model model,@RequestParam String healthName) {
		model.addAttribute("healthDic", service.getHealthDic(healthName));
		return "/healthInfo/exercise";
	}
}
