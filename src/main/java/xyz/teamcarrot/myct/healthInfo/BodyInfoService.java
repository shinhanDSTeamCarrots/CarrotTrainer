package xyz.teamcarrot.myct.healthInfo;

public interface BodyInfoService {
	//tb_body_info 테이블 > "로그인이 되었을 때", 나이, 신장 등 입력
	boolean insertBodyInfo(BodyInfoVO vo);
	
	//tb_body_change 테이블 > "로그인이 되었을 때", 몸무게, 근육량, 체지방량 입력
	int insertBodyChange(BodyChangeVO vo);
	BodyChangeVO selectBodyChange(BodyChangeVO vo);
	int updateBodyChange(BodyChangeVO vo);
	int deleteBodyChange(BodyChangeVO vo);
}