package xyz.teamcarrot.myct.healthInfo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BodyInfoMapper {
	//tb_body_info 테이블 > 나이, 신장 등 입력
	int insertBodyInfo(BodyInfoVO vo);
	BodyInfoVO selectBodyInfo(int no);
	int updateBodyInfo(BodyInfoVO vo);
	
	//tb_body_change 테이블 > 몸무게, 근육량, 체지방량 입력
	int insertBodyChange(BodyChangeVO vo);
	BodyChangeVO selectBodyChange(int no);
	int updateBodyChange(BodyChangeVO vo);
	int deleteBodyChange(int no);
}
