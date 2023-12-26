package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

public interface GoodsService {
	
	//전체 상품 리스트
	List<GoodsVO> goodsList(String searchGoods);
	
	//List<GoodsVO> searchGoodsList();
	
	//카테고리별 상품 리스트
	List<GoodsVO> getCategoryGoodsList(int category_no);
	
	//상품상세
	GoodsVO detail(int goods_no);
	
	List<GoodsOptionVO> goodsOption(int goods_no);
	
	//상품 추가
	int goodsInsert(GoodsVO goods);

}