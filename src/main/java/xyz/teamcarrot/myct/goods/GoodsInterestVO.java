package xyz.teamcarrot.myct.goods;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class GoodsInterestVO {
	private int interest_no;
	private int goods_no;
	private int member_no;
	private Timestamp regist_date;
}
