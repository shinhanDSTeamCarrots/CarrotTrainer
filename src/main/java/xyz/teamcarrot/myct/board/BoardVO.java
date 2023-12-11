 package xyz.teamcarrot.myct.board;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {

	private int board_no;
	private String board_title;
	private Timestamp board_rdate;
	private int board_view;
	private String board_content;
	private int category_no;
	private int member_no;
}
