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

}
