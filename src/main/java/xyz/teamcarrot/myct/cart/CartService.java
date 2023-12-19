package xyz.teamcarrot.myct.cart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CartService {

	List<CartVO> cartList(int member_no);
	int addToCart(CartVO cart, HttpServletRequest request);
	void removeFromCart(int cartNo);
	void updateCart(CartVO cart);
}