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
	
	private int option_no;
	private String option_name;
	private int price_updown;
	
	private String category_name;
	
	@Override
    public String toString() {
        return "GoodsVO{" +
                "goods_no=" + goods_no +
                ",option_name=" + option_name +
                ",category_name=" + category_name +
                ", goods_name='" + goods_name + '\'' +
                ", price=" + price +                
                '}';
    }
	
}
