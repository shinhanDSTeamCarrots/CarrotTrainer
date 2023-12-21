package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsMapper mapper;
	
	
	@Override
	public List<GoodsVO> goodsList(String searchGoods) {
		List<GoodsVO> goodsList = mapper.goodsList(searchGoods);
		return goodsList;
	}
	/*@Override
	public List<GoodsVO> searchGoodsList(String searchGoods) {
		List<GoodsVO> searchGoodsList = mapper.searchGoodsList(searchGoods);
		return searchGoodsList;
	}*/
	
	@Override
	public List<GoodsVO> getCategoryGoodsList(int category_no){
		List<GoodsVO> goodsPerCate = mapper.getCategoryGoodsList(category_no);
		return goodsPerCate;
	}
	
	@Override
	public GoodsVO detail(int goods_no){
		GoodsVO detail=mapper.detail(goods_no);
		return detail;
	}

	@Override
	public List<GoodsOptionVO> goodsOption(int goods_no) {
		List<GoodsOptionVO> goodsOptions = mapper.goodsOption(goods_no);
		return goodsOptions;
	}

	

}