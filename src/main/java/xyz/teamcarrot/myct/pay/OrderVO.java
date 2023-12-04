package xyz.teamcarrot.myct.pay;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderVO {
	private int order_no;
	private int member_no;
	private Timestamp purchase_date;
	private String purchase_val;
	private int purchase_state;
	private String receiver_nm;
	private String receiver_post;
	private String receiver_addr;
	private String receiver_addr_detail;
	private String receiver_phone;
	private String receiver_notice;
	private String refund_reason;
	private int thumnail_detail_no;
}
