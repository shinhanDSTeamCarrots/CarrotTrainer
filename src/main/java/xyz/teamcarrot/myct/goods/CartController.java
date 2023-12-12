package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
/*@Controller

@RequestMapping("/cart/*")
public class CartController {
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService service;
	
	@GetMapping("/list.do")
	public String list(Model model) {
		List<CartVO> cartList=service.cartList();
		model.addAttribute("cartList", cartList);
		
		// 콘솔에 출력
        for (CartVO cart : cartList) {
            logger.info("{}", cart);
        }
	
		return "/goods/cartList";
	}
	
	@PostMapping("/add")
    public void addToCart(@RequestBody CartVO cart) {
        service.addToCart(cart);
    }
	
	@DeleteMapping("/remove/{cartNo}")
    public void removeFromCart(@PathVariable int cartNo) {
        service.removeFromCart(cartNo);
    }
	
	@PutMapping("/update")
    public void updateCart(@RequestBody CartVO cart) {
        service.updateCart(cart);
    }
}*/
