package xyz.teamcarrot.myct.member;
import lombok.Data;

@Data
public class AddressVO {
	private int place_no;
	private String receive_name;
	private String receive_hp;
	private String receive_addr;
	private String receive_addr2;
	private String receive_zipcode;
	private String postman_notice;
	private int member_no;
}
