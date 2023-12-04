package xyz.teamcarrot.myct.healthInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExerciseController {
	
	@Autowired
	HealthInfoService service;
	
	@GetMapping("/exercise.do")
	public String exercise(Model model) {
		model.addAttribute("healthDic", service.gethealthDic());
		return "/healthInfo/exercise";
	}
}
