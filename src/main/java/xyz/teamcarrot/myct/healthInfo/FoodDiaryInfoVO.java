package xyz.teamcarrot.myct.healthInfo;

import lombok.Data;

@Data
public class FoodDiaryInfoVO {
	private int food_diary_info_no;
	private String food_name;
	private double food_calorie;
	private double food_carbs;
	private double food_protein;
	private double food_fat;
	private double food_sugar;
	private double food_salt;
	private int food_diary_no;
}
