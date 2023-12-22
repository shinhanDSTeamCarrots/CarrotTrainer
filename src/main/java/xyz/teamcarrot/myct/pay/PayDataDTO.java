package xyz.teamcarrot.myct.pay;

import lombok.Data;

@Data
public class PayDataDTO {
	private String phone;
	private String addr1;
	private String addr2;
	private String zipcode;
	private String notice;
	private String recevier_name;
	private int mileage;
	private int pay_price;
	private String paytype;
	private String payStr;
	private String buy_method;
	private int member_no;
	private int purchase_div;
}
