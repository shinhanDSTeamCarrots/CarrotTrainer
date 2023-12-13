package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

public interface GoodsService {
	
	//전체 상품 리스트
	List<GoodsVO> goodsList();
	
	//카테고리별 상품 리스트
	List<GoodsVO> getCategoryGoodsList(int category_no);
	
	//상품상세 목록
	List<GoodsVO> detailList();
	
}