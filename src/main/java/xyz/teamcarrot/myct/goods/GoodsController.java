package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GoodsController {
	private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	@Autowired
	private GoodsService service;
	
	@GetMapping("/chickenList.do")
	public String list(Model model) {
		List<GoodsVO> goodsList=service.goodsList();
		model.addAttribute("goodsList", goodsList);
		
		// 콘솔에 출력
        for (GoodsVO goods : goodsList) {
            logger.info("{}", goods);
        }
	
		return "/goods/chickenList";
	}
}