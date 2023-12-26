package xyz.teamcarrot.myct.cart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CartService {

	List<CartVO> cartList(int member_no);
	int addToCart(CartVO cart);
	void removeFromCart(List<Integer> cartNos);
	void updateCart(CartVO cart);
	boolean checkCart(int mem_no, int goods_no);
}