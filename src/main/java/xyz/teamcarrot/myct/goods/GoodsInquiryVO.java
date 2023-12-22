package xyz.teamcarrot.myct.goods;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class GoodsInquiryVO {

	private int inquiry_no;
	private int inquiry_type;
	private String title;
	private String content;
	private Timestamp inquiry_date;
	private int is_reply;
	private Timestamp reply_date;
	private int goods_no;
	private int member_no;
	private int admin_no;
	private String reply_content;
	private int is_secret;
	
	private String member_id;
}
