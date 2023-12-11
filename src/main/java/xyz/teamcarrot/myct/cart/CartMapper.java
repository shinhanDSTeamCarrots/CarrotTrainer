package xyz.teamcarrot.myct.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {
	
	//장바구니 목록
	List<CartVO> getlist();
	
	//장바구니 추가
	void insert(CartVO cart);

	//장바구니 삭제	
	void delete(int cartNo);
	
	//장바구니 수정
	void update(CartVO cart);
	
}
