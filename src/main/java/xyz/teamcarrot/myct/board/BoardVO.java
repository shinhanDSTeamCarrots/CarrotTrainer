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
	 private String member_nickname; // 추가
	// 첨부파일 관련 필드 추가
	    private String filename_org; // 원본 파일명
	    private String filename_real; // 저장된 파일명
	    
	    private String file_name; // 첨부파일 이름 필드 추가
	    private String file_no;  // 첨부파일 번호
	    
	    private String hasReply; // 답글 유무를 나타내는 필드

	    // 기존 필드들에 대한 getter 및 setter 메서드들...

	    // hasReply 필드에 대한 getter 메서드
	    public String getHasReply() {
	        return hasReply;
	    }

	    // hasReply 필드에 대한 setter 메서드
	    public void setHasReply(String hasReply) {
	        this.hasReply = hasReply;
	    }

	    // file_no에 대한 getter와 setter
	    public String getFile_no() {
	        return file_no;
	    }

	    public void setFile_no(String file_no) {
	        this.file_no = file_no;
	    }

	    // getter 및 setter
	    public String getMember_nickname() {
	        return member_nickname;
	    }

	    public void setMember_nickname(String member_nickname) {
	        this.member_nickname = member_nickname;
	    }

		public void setFilename_org(String org) {
			// TODO Auto-generated method stub
			
		}

		public void setFilename_real(String real) {
			// TODO Auto-generated method stub
			
		}

		
}
