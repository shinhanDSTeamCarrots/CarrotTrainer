package xyz.teamcarrot.myct.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public int addToCart(CartVO cart) {
		int r = mapper.insert(cart);
		return r;
	}
	
	@Override
	public void removeFromCart(List<Integer> cartNos) {
		mapper.deleteSelected(cartNos);
	}
	
	@Override
    public void updateCart(CartVO cart) {
        mapper.update(cart);
    }
	
	@Override
	public boolean checkCart(int mem_no, int goods_no) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("mem_no",mem_no);
		paramMap.put("goods_no",goods_no);
		
		int count=mapper.existInCart(paramMap);	
		return count>0;
	}
	
}