package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HealthInfoMapper {
	List<Map<String, Object>> healthDic();
}
