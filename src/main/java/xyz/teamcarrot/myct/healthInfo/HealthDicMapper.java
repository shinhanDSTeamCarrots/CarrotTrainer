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
}
