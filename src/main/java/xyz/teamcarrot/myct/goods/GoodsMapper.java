package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsMapper {
	//상품 목록
	List<GoodsVO> list();

	//상품 추가
	void insert(GoodsVO goods);
	
	//상품 삭제
	void delete(int goods_no);
	
	//상품 수정
	void update(GoodsVO goods);
	
	
}