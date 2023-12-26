/* Created:		23.12.15
 * Author:		전성욱
 * Description:	어드민 컨트롤러
 * Edited:		
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;

import xyz.teamcarrot.myct.goods.GoodsService;
import xyz.teamcarrot.myct.goods.GoodsVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class AdminPageController {
	
	@GetMapping("admin")
	public ModelAndView topPage(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		
		//관리자 페이지 로그인 정보 확인
		
		
		
		
		
		
		
		
		
		
		
		return mav;
		
	}
	
	
	@GetMapping("admin/login")
	public ModelAndView adminLogin(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		
		//관리자 페이지 로그인 페이지 연동
		
		
		
		
		
		
		
		
		
		
		
		
		return mav;
		
	}
	@ResponseBody
	@PostMapping("admin/login")
	public String postAdminLogin(HttpServletRequest request, HttpSession sess) {
		
		
		
		//관리자 페이지 로그인 동작
		
		
		
		
		
		return "T";
		
	}
	
	@GetMapping("admin/logout")
	public ModelAndView adminLogout(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		//홈페이지 메인으로
		
		sess.invalidate();
		
		
		mav.setViewName("redirect:/");
		
		
		
		
		
		
		
		return mav;
		
	}
	@Autowired
	private GoodsService goodsservice;
	
	@GetMapping("/admin/goods/management")
	public String list(Model model, @RequestParam(name="search_goods", required=false) String searchGoods) {
		List<GoodsVO> goodsList;	
		
		goodsList=goodsservice.goodsList(searchGoods);		
		model.addAttribute("goodsList", goodsList);
		return "/admin/goods/management";
	}
	
	@PostMapping("/admin/goods/insert")
	public String goodsInsert(Model model,HttpServletRequest request, GoodsVO goods) {
		HttpSession sess = request.getSession();
		AdminVO login = (AdminVO)sess.getAttribute("loginInfo");
		//관리자 로그인 여부 확인해야하는데.....
		
		goods.setGoods_name(request.getParameter("goods_name"));
	    goods.setPrice(Integer.parseInt(request.getParameter("price")));
	    goods.setDiscount_price(Integer.parseInt(request.getParameter("discount_price")));
	    goods.setDelivery_fee(Integer.parseInt(request.getParameter("delivery_fee")));
	    goods.setPurchase_info(request.getParameter("purchase_info"));
	    goods.setStock(Integer.parseInt(request.getParameter("stock")));
	    goods.setCategory_no(Integer.parseInt(request.getParameter("category_no")));
	    
		int r = goodsservice.goodsInsert(goods);
		if (r>0) {
			model.addAttribute("cmd","move");
			model.addAttribute("msg","상품이 정상적으로 등록되었습니다.");
			model.addAttribute("url","management");
		}
		else {
			model.addAttribute("cmd", "back");
			model.addAttribute("msg", "등록 오류");
		}	
		return "common/alert";
	}
}
