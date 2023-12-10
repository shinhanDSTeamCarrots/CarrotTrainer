package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public abstract class CartMapper {
	
	//장바구니 목록
	abstract List<CartVO> getlist();
	
	//장바구니 추가
	abstract void insert(CartVO cart);

	//장바구니 삭제	
	abstract void delete(int cartNo);
	
	//장바구니 수정
	abstract void update(CartVO cart);
	
}
