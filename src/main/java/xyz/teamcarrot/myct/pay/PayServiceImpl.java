package xyz.teamcarrot.myct.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	@Override
	public int insertOrders(List<BuyGoodsVO> goodsvos, PayDataDTO dto) {
		try {
			System.out.println("member_no:"+dto.getMember_no());
			mapper.insertOrderMain(dto);
			goodsvos.forEach(g -> g.setOrder_no(dto.getOrder_no()));
			List<Integer> iList = new ArrayList<Integer>();
			for(BuyGoodsVO bgv : goodsvos) {
				mapper.insertOrderDetail(bgv);
				if(dto.getBuy_method().equals("C")) {
					iList.add(bgv.getCart_no());
				}
			}
			if(dto.getBuy_method().equals("C"))
				cartmapper.deleteSelected(iList);
			//추가로 마일리지 넣고 뺏기
			Map paramMap = new HashMap<String, Object>();
			paramMap.put("member_no", dto.getMember_no() );
			paramMap.put("mileage_amt", dto.getPay_price() * 0.01  - dto.getMileage());
			mapper.updateMemberMileage(paramMap);
			if(dto.getMileage() != 0) {
				paramMap.clear();
				paramMap.put("member_no", dto.getMember_no() );
				paramMap.put("mileage_change", - dto.getMileage());
				paramMap.put("mileage_log","["+ dto.getOrder_no()+"]상품 구매 사용 마일리지");
				mapper.insertMileageLog(paramMap);
			}
			paramMap.clear();
			paramMap.put("member_no", dto.getMember_no() );
			paramMap.put("mileage_change", (dto.getPay_price() * 0.01));
			paramMap.put("mileage_log","["+ dto.getOrder_no()+"]상품 구매 추가 마일리지");
			mapper.insertMileageLog(paramMap);
			return dto.getOrder_no();
		}
		catch(Exception exception) {
			throw exception;
		}
	}

	@Override
	public BuyGoodsVO getGoods(Map map) {
		return mapper.getGoods(map);
	}

	@Override
	public List<OrderDetailVO> getPurchaseDetails(Map map) {
		return mapper.getPurchaseDetails(map);
	}

	@Override
	public OrderVO getPurchaseMain(Map map) {
		return mapper.getPurchaseMain(map);
	}
	
}
