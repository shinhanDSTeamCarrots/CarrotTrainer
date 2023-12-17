package xyz.teamcarrot.myct.healthInfo;

import java.sql.Date;

import lombok.Data;

@Data
public class BodyChangeVO {
	private int body_change_no;
	private Date body_change_date;
	private double body_change_weight;
	private double muscle_mass;
	private double fat_mass;
	private int member_no;
}
