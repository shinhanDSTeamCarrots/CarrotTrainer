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
	//goodsList(안에 들어와야함)
	public List<GoodsVO> goodsList() {
		List<GoodsVO> goodsList = mapper.list();
		return goodsList;
	}
	
	@Override
	public List<GoodsVO> getCategoryGoodsList(int category_no){
		List<GoodsVO> goodsPerCate = mapper.getCategoryGoodsList(category_no);
		return goodsPerCate;
	}
	
	@Override
	public List<GoodsVO> detailList(){
		List<GoodsVO> detailList=mapper.detailList();
		return detailList;
	}

}