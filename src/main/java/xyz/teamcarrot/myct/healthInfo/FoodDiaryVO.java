package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class FoodDiaryVO {
	private int food_diary_no;
	private Timestamp food_diary_date;
	private Date intake_date;
	private int intake_time;
	private String image;
	private int total_calorie;
	private double total_carbs;
	private double total_protein;
	private double total_fat;
	private double total_sugar;
	private int total_salt;
	private int member_no;
}
