package xyz.teamcarrot.myct.board;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {
	private int reply_no;
	private String reply_content;
	private Timestamp reply_rdate;
	private int board_no;
	private int member_no; 
}
