package xyz.teamcarrot.myct.healthInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExerciseController {
	
	@Autowired
	HealthDicService service;
	
	//기본 목록
	@GetMapping("/exercise")
	public String exercise(Model model) {
		model.addAttribute("healthDic", service.getHealthDic());
		return "/healthInfo/exercise";
	}
}
