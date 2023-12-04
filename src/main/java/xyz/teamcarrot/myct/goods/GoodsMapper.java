package xyz.teamcarrot.myct.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsMapper {
	//상품 목록
	List<Map<String,Object>> list();

}
