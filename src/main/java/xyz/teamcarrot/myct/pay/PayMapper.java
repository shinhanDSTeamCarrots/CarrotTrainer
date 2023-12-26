package xyz.teamcarrot.myct.pay;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PayMapper {
	List<BuyGoodsVO> getCartGoods(Map map);
	BuyGoodsVO getGoods(Map map);
	List<Map<String, Object>> getAddressList(@Param("member_no")int member_no);
	int getMemberMileage(@Param("member_no")int member_no);
	int insertOrderMain(PayDataDTO dto);
	int insertOrderDetail(BuyGoodsVO goodsvo);
	//void updateMainDataThumnail(@Param("order_no")int order_no, @Param("detail_no")int detail_no);
	List<OrderDetailVO> getPurchaseDetails(Map map);
	OrderVO getPurchaseMain(Map map);
	void updateMemberMileage(Map map);
	void insertMileageLog(Map map);
}
