package xyz.teamcarrot.myct.healthInfo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExerciseController {
	@GetMapping("/exercise.do")
	public String bmi() {
		return "/healthInfo/exercise";
	}
}
