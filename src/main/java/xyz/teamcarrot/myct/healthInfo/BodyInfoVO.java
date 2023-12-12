package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;

import lombok.Data;

@Data
public class BodyInfoVO {
	private int body_info_no;
	private Date body_info_date;
	private int age;
	private double height;
	private double weight;
	private double target_weight;
	private int gender;
	private int exercise_mass;
	private double muscle_mass;
	private double fat_mass;
	private double bmi;
	private int target_calorie;
	private double target_carbs;
	private double target_protein;
	private double target_fat;
	private double target_sugar;
	private int member_no;
}
