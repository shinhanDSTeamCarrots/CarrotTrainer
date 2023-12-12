package xyz.teamcarrot.myct.member;
import lombok.Data;
import java.sql.Timestamp;
@Data
public class MemberVO {
	private int member_no;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_nickname;
	private String member_birthday;
	private String member_hp;
	private String member_email;
	private String member_addr;
	private String member_addrDetail;
	private int member_loginFailCnt;
	private int member_loginBlocked;
	private int member_blocked;
	private Timestamp member_joinDate;
	private int member_mileage;
}
