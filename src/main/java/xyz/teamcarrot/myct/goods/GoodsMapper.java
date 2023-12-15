package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsMapper {
	//상품 목록
	List<GoodsVO> list();
	
	//카테고리별 상품 목록 
	List<GoodsVO> getCategoryGoodsList(int category_no);
		
	//상품상세 목록
	GoodsVO detail(int goods_no);
	
	List<GoodsOptionVO> goodsOption(int goods_no);
	
	//상품 추가
	int insert(GoodsVO goods);
	
	//상품 삭제
	int delete(int goods_no);
	
	//상품 수정
	int update(GoodsVO goods);
	
	
}