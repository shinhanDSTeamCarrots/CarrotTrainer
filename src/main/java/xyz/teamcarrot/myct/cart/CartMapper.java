package xyz.teamcarrot.myct.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {
	
	//장바구니 목록
	List<CartVO> cartList(int member_no);
	
	//장바구니 추가
	int insert(CartVO cart);

	//장바구니 삭제	
	int delete(int cartNo);
	
	//장바구니 수정
	int update(CartVO cart);
	
}
