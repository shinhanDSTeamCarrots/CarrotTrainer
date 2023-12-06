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
		//Map을 해줘야하고 
		List<GoodsVO> goodsList = mapper.list();
		
		//put을 해줘야 함
		return goodsList;
	}

}
