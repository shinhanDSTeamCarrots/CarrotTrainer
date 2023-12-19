package xyz.teamcarrot.myct.cart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper mapper;
	
	@Override
	public List<CartVO> cartList(int member_no) {
		List<CartVO> cartList = mapper.cartList(member_no);
		return cartList;
	}
	
	@Override
	public int addToCart(CartVO cart, HttpServletRequest request) {
		int r = mapper.insert(cart);
		return r;
	}
	
	@Override
	public void removeFromCart(int cartNo) {
		mapper.delete(cartNo);
	}
	
	@Override
    public void updateCart(CartVO cart) {
        mapper.update(cart);
    }

}