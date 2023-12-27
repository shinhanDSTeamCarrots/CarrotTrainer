package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HealthDicMapper {
	//전체 운동 리스트
	List<Map<String, Object>> healthDic(Map<String, Object> map);
	
	//북마크 운동 리스트
	List<Map<String, Object>> bookmarkHealthDic(Map<String, Object> map);
	//북마크 추가
	int addBookmark(HealthBookmarkVO vo);
	//북마크 제거
	int delBookmark(int health_bookmark_no);
	
	//운동 정보 입력
	int insertHealthInfo(HealthDiaryVO vo);
	HealthDiaryVO selectHealthInfo(int no);
	int updateHealthInfo(HealthDiaryVO vo);
	int deleteHealthInfo(int no);
	
	
	//전체 음식 리스트
	List<Map<String, Object>> foodDic(Map<String, Object> map);
	
	//북마크 음식 리스트
	List<Map<String, Object>> bookmarkFoodDic(Map<String, Object> map);
	//북마크 추가
	int addFoodBookmark(FoodBookmarkVO vo);
	//북마크 제거
	int delFoodBookmark(int food_bookmark_no);
}
