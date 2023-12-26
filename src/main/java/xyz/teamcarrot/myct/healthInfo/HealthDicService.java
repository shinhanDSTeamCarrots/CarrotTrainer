package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

public interface HealthDicService {
	//전체 운동 리스트
	List<Map<String, Object>> getHealthDic(String healthName,int member_no, int minute);
	//북마크 운동 리스트
	List<Map<String, Object>> getbookmarkHealthDic(String healthName,int member_no, int minute);
	
	//북마크 추가
	int addBookmark(HealthBookmarkVO vo);
	//북마크 삭제
	int delBookmark(int health_bookmark_no);
}