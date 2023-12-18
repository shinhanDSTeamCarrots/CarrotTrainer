package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;

import lombok.Data;

@Data
public class BodyChangeVO {
	private int body_change_no;
	private Date regist_date;
	private double weight;
	private Double muscle_mass;
	private Double fat_mass;
	private int member_no;
	

	//null일 경우 0으로 변환
	public double getMuscle_mass() {
		if(muscle_mass == null)
			return 0;
		return muscle_mass.doubleValue();
	}
	public double getFat_mass() {
		if(this.fat_mass == null)
			return 0;
		return fat_mass.doubleValue();
	}
}
