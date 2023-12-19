package xyz.teamcarrot.myct.pay;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PayMapper {
	List<BuyGoodsVO> getCartGoods(Map map);
	List<Map<String, Object>> getAddressList(@Param("member_no")int member_no);
	int getMemberMileage(@Param("member_no")int member_no);
}
