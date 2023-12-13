package xyz.teamcarrot.myct.healthInfo;

public interface BodyInfoService {
	//"로그인이 되었을 때," 나이, 신장 등 입력
	boolean insertBodyInfo(BodyInfoVO vo);
}