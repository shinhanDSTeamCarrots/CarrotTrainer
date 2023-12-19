package xyz.teamcarrot.myct.pay;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayServiceImpl implements PayService {
	@Autowired
	PayMapper mapper;
	
	@Override
	public List<BuyGoodsVO> getCartGoods(Map map) {
		return mapper.getCartGoods(map);
	}

	@Override
	public List<Map<String, Object>> getAddressList(int member_no) {
		return mapper.getAddressList(member_no);
	}

	@Override
	public int getMemberMileage(int member_no) {
		return mapper.getMemberMileage(member_no);
	}
	
}
