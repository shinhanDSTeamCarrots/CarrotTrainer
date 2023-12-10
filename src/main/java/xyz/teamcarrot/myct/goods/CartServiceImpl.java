package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper mapper;
	
	@Override
	public List<CartVO> cartList() {
		List<CartVO> cartList = mapper.getlist();
		return cartList;
	}
	
	@Override
	public void addToCart(CartVO cart) {
		mapper.insert(cart);
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