package xyz.teamcarrot.myct.board;

import java.sql.Date;

import lombok.Data;

@Data
public class tb_board_recom {
	private int board_recom_no;
	private int hit_count;
	private int board_no;
	private int hit_member_no; 
}
