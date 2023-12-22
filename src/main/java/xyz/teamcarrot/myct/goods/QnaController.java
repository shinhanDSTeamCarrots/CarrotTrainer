package xyz.teamcarrot.myct.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class QnaController {
	
	@Autowired
	QnaService service;
	
	@GetMapping("/qnaList")
	public String list(Model model, @PathVariable int goods_no) {
		model.addAttribute("qna",service.qnaList(goods_no));
		return "goods/detail";
	}
	
	@PostMapping("/goods/qna")
	public String insert(GoodsInquiryVO vo, Model model) {
		model.addAttribute("result", service.qnaInsert(vo));
		return "/goods/detail";
	}

}
