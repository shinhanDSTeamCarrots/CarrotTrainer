package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

public interface HealthDicService {
	//전체 운동 리스트
	List<Map<String, Object>> getHealthDic(String healthName,int member_no, int minute);
	
	//북마크 운동 리스트
	List<Map<String, Object>> getBookmarkHealthDic(String healthName,int member_no, int minute);
	//북마크 추가
	int addBookmark(HealthBookmarkVO vo);
	//북마크 삭제
	int delBookmark(int health_bookmark_no);
	
	//운동 정보 입력
	boolean insertHealthInfo(HealthDiaryVO vo);
	HealthDiaryVO selectHealthInfo(int member_no);
	int updateHealthInfo(HealthDiaryVO vo);
	int deleteHealthInfo(HealthDiaryVO vo);
	
	
	//전체 음식 리스트
	Map<String, Object> getFoodDic(String foodName,int member_no, Integer page);
	
	//북마크 음식 리스트
	List<Map<String, Object>> getBookmarkFoodDic(String foodName,int member_no);
	//북마크 추가
	int addFoodBookmark(FoodBookmarkVO vo);
	//북마크 삭제
	int delFoodBookmark(int food_bookmark_no);
}