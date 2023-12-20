package xyz.teamcarrot.myct.healthInfo;

import java.util.List;
import java.util.Map;

public interface HealthDicService {
	List<Map<String, Object>> getHealthDic(String healthName, double kg, int minute);
}