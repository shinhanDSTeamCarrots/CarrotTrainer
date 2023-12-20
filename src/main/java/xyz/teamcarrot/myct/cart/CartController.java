package xyz.teamcarrot.myct.cart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.member.MemberVO;
@Slf4j
@Controller
public class CartController {
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService service;
	
	@GetMapping("/cart")
	public String list(Model model, HttpSession session) {
		 MemberVO login = (MemberVO)session.getAttribute("loginInfo");
		 // 세션이 비어있거나 로그인되어 있지 않으면 로그인 페이지로 리다이렉트 ( 로그인해야 장바구니 표시가 보일거긴 함)
	     if (login == null) {
	        return "redirect:/member/login.do";
	    }
	     int member_no = login.getMember_no();

	    // 회원번호에 해당하는 장바구니 목록을 가져와 모델에 추가
		List<CartVO> cartList=service.cartList(member_no);
		model.addAttribute("cartList", cartList);		
		return "/goods/cart";
	}
	
	@ResponseBody
	@PostMapping("cart/add")
    public String addToCart(Model model, HttpServletRequest request, CartVO cart) {
        HttpSession sess=request.getSession();
        log.info("cart: "+cart.toString());
        MemberVO login = (MemberVO)sess.getAttribute("loginInfo");
		cart.setMember_no(login.getMember_no());
        int r = service.addToCart(cart, request);
        if (r>0) {
        	model.addAttribute("cmd","move");
        	model.addAttribute("msg","장바구니에 정상적으로 담겼습니다");
        	return "T";
        }
        else {
        	//안담길경우 
        	return "F";
        }
    }
	@ResponseBody
	@PostMapping("/cart/remove")
    public void removeFromCart(@RequestParam List<Integer> cartNos) {
        service.removeFromCart(cartNos);
    }
	
	@PostMapping("cart/update")
    public void updateCart(@RequestBody CartVO cart) {
        service.updateCart(cart);
    }
	
	@ResponseBody
	@PostMapping("cart/check")
	public String checkCart(@RequestParam int mem_no, @RequestParam int goods_no) {
		boolean existsInCart = service.checkCart(mem_no, goods_no);
		return existsInCart ? "EXIST" : "NOT_EXIST";
	}

}


