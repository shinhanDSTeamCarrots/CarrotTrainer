package xyz.teamcarrot.myct.goods;

import lombok.Data;

@Data
public class GoodsOptionVO {

	private int option_no;
	private String option_name;
	private int price_updown;
	private int goods_no;
	private int final_price;
}
