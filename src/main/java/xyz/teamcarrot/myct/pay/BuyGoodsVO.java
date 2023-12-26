package xyz.teamcarrot.myct.pay;

import lombok.Data;

@Data
public class BuyGoodsVO {
	private int rownum;
	private int cart_no;
	private int goods_no;
	private String goods_name;
	private int goods_price;
	private String goods_thumnail;
	private int goods_final_price;
	private int option_no;
	private String option_name;
	private int option_price;
	private int goods_cnt;
	private int order_no;
	
	public BuyGoodsVO() {}
}
