package xyz.teamcarrot.myct.goods;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class GoodsVO {

	private int goods_no;
	private String goods_name;
	private int price;
	private int discount_price;
	private int delivery_fee;
	private String image;
	private String image_detail1;
	private String image_detail2;
	private String image_detail3;
	private String image_detail4;
	private String image_detail5;
	private String purchase_info;
	private Timestamp register_date;
	private int stock;
	private int is_delete;
	private double goods_rate;
	private int category_no;
	
	
	//옵션용
	private int price_updown;
	private String category_name;
	
	//페이징용
	private int startIdx;
	private int page;
	
}
