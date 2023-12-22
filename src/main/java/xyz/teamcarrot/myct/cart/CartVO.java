package xyz.teamcarrot.myct.cart;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class CartVO {
	
	private int cart_no;
	private int goods_count;
	private Timestamp cart_add_date;
	private int goods_no;
	private int member_no;
	private int option_no;
	
	
	/* 장바구니 리스트에서 띄울때 필요한 값 */
	private String image;
	private String goods_name;
	private String option_name;
	private int final_price;
	private int delivery_fee;
}
