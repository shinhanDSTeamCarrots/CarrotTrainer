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
	
	 private String member_nickname; // 회원 닉네임 필드 추가

	    // existing getters and setters

	    // member_nickname의 getter와 setter
	    public String getMember_nickname() {
	        return member_nickname;
	    }

	    public void setMember_nickname(String member_nickname) {
	        this.member_nickname = member_nickname;
	    }
}
