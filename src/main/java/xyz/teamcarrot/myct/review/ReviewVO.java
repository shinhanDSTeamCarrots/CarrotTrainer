package xyz.teamcarrot.myct.review;

import java.sql.Timestamp;


import lombok.Data;

@Data
public class ReviewVO {
	private int review_no;
	private String content;
	private int point;
	private Timestamp regist_date;
	private int like_cnt;
	private int goods_no;
	private int member_no;
	private String member_name;
	private String goods_name;
	private int self_like;
	private byte[] image;
}
