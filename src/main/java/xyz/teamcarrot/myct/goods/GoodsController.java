package xyz.teamcarrot.myct.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GoodsController {
	
	@Autowired
	private GoodsService service;
	
	@GetMapping("/goods/chickenList.do")
	public String list(Model model) {
		model.addAttribute("goodsList", service.goodsList());
		return "goods/chickenList";
	}
}
