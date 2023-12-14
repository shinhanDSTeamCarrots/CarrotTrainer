package xyz.teamcarrot.myct.healthInfo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DiaryController {
	@GetMapping("/diary")
	public String bmi() {
		return "/healthInfo/diary";
	}
}
