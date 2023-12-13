package xyz.teamcarrot.myct.healthInfo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BodyInfoMapper {
	//나이, 신장 등 입력
	int insertBodyInfo(BodyInfoVO vo);
}
