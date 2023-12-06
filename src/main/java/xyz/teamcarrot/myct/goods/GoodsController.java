package xyz.teamcarrot.myct.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GoodsController {
	
	@Autowired
	private GoodsService service;
	
	@GetMapping("/chickenList.do")
	public String list(Model model) {
		model.addAttribute("goodsList", service.goodsList());
		return "/goods/chickenList";
	}
	//getattribute category no 변서 저장해서 getmapping뒤에 붙이기
	//model안에 goodsList에 service.goodsList가 들어가있는걸 goodsList를 chickenList c:{"goodsList"} 
}
