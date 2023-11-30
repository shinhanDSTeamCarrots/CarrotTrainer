package xyz.teamcarrot.myct.member;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class MileageVO {
	private int mileage_no;
	private Timestamp purchase_date;
	private int mileage_change;
	private String mileage_log;
}
