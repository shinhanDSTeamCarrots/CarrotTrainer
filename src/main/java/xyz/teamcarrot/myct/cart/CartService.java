package xyz.teamcarrot.myct.cart;

import java.util.List;
import java.util.Map;

public interface CartService {

	List<CartVO> cartList();
	void addToCart(CartVO cart);
	void removeFromCart(int cartNo);
	void updateCart(CartVO cart);
}