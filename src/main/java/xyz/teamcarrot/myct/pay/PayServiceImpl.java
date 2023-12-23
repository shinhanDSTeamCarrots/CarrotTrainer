package xyz.teamcarrot.myct.pay;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xyz.teamcarrot.myct.cart.CartMapper;

@Service
public class PayServiceImpl implements PayService {
	@Autowired
	PayMapper mapper;
	
	@Autowired CartMapper cartmapper;
	
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
	@Override
	public int insertOrders(List<BuyGoodsVO> goodsvos, PayDataDTO dto) {
		try {
			System.out.println("member_no:"+dto.getMember_no());
			int orderno = mapper.insertOrderMain(dto);
			goodsvos.forEach(g -> g.setOption_no(orderno));
			List<Integer> iList = new ArrayList<Integer>();
			for(BuyGoodsVO bgv : goodsvos) {
				mapper.insertOrderDetail(bgv);
				if(dto.getBuy_method().equals("C")) {
					iList.add(bgv.getCart_no());
				}
			}
			cartmapper.deleteSelected(iList);
			return orderno;
		}
		catch(Exception exception) {
			throw exception;
		}
	}

	@Override
	public BuyGoodsVO getGoods(Map map) {
		return mapper.getGoods(map);
	}
	
}
