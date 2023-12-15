package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GoodsController {
	private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	@Autowired
	private GoodsService service;
	
		
	@GetMapping("/goodsList")
	public String list(Model model) {
		List<GoodsVO> goodsList=service.goodsList();
		model.addAttribute("goodsList", goodsList);
		
		// 콘솔에 출력
        /*for (GoodsVO goods : goodsList) {
            logger.info("{}", goods);
        }*/		
		return "/goods/goodsList";
	}

	
	@GetMapping("/goodsList/{category_no}")
	public String cateGoodsList(Model model, @PathVariable int category_no) {
		System.out.println("category number 체크! " + category_no);
		List<GoodsVO> goodsPerCate=service.getCategoryGoodsList(category_no);
		
		model.addAttribute("goodsList", goodsPerCate);			
		return "/goods/goodsList";
	}
	
	
	@GetMapping("/detail/{goods_no}")
	public String detailList(Model model,@PathVariable int goods_no) {
		System.out.println("goods number 체크" + goods_no);
		GoodsVO goods = service.detail(goods_no);
		List<GoodsOptionVO> options = service.goodsOption(goods_no);
		model.addAttribute("item",goods);
		model.addAttribute("detail", options);
		return "/goods/detail";
	}
}