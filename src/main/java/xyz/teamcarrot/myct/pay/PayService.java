package xyz.teamcarrot.myct.pay;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface PayService {
	List<BuyGoodsVO> getCartGoods(Map map);
	List<Map<String,Object>> getAddressList(int member_no);
	int getMemberMileage(int member_no);
	int insertOrders(List<BuyGoodsVO> goodsvos, PayDataDTO dto);
	BuyGoodsVO getGoods(Map map);
	List<OrderDetailVO> getPurchaseDetails(Map map);
	OrderVO getPurchaseMain(Map map);
}
