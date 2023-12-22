package xyz.teamcarrot.myct.healthnews;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HealthNewsController {

	/*
	 * @Autowired private HealthNewsService healthNewsService;
	 */

	
	@GetMapping("/healthnews/cardboard.do")
	public String cardboard(Model model) {
		
		return "news/cardBoard";
	}
	
	/*
	 * @GetMapping("/healthnews/cardread.do/{id}") public String
	 * cardread(@PathVariable("id") int id, Model model) {
	 * model.addAttribute("news", healthNewsService.getNewsById(id)); return
	 * "news/cardRead"; }
	 */
}
