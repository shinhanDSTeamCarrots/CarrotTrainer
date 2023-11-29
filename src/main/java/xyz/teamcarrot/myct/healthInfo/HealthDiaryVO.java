package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;

import lombok.Data;

@Data
public class HealthDiaryVO {
	private int health_diary_no;
	private String health_name;
	private double health_calorie;
	private int health_time;
	private Date health_date;
	private int member_no;
}
