package xyz.teamcarrot.myct.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {
	
	//장바구니 목록
	List<CartVO> cartList(int member_no);
	
	//장바구니 추가
	int insert(CartVO cart);

	//장바구니 삭제	
	void deleteSelected(List<Integer> cartNos);
	
	//장바구니 수정
	int updateQuantity(CartVO cart);
	void updateCartQuantity(CartVO cart);
	
	//장바구니에 존재 여부 확인
	int existInCart(Map<String, Object> paramMap);
	
}
