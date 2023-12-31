package xyz.teamcarrot.myct.pay;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderDetailVO {
	private int detail_no;
	private int order_no;
	private int goods_no;
	private int option_no;
	private int cnt;
	private int deliver_state;
	private Timestamp acception_date;
	private int tracking_no;
	private int admin_no;
	private String goods_name;
	private String option_name;
	private String admin_name;
}
