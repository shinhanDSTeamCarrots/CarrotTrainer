package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;

import lombok.Data;

@Data
public class BodyInfoVO {
	private int body_info_no;
	private Date body_info_date;
	private int age;
	private double height;
	private double body_info_weight;
	private double target_weight;
	private int gender;
	private int exercise_mass;
	private double bmi;
	private int target_calorie;
	private int target_carbs;
	private int target_protein;
	private int target_fat;
	private int target_sugar;
	private int member_no;
}
