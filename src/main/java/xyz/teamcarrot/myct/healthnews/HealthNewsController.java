package xyz.teamcarrot.myct.healthnews;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HealthNewsController {
	
	@GetMapping("/healthnews/cardboard.do")
	public String cardboard() {
		
		return "news/cardBoard";
	}
	
	@GetMapping("/healthnews/cardread.do")
	public String cardread() {
		
		return "news/cardRead";
	}
}
