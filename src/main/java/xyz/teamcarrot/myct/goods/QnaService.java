package xyz.teamcarrot.myct.goods;

import java.util.List;

public interface QnaService {
	
	//문의 목록
	List<GoodsInquiryVO> getQnaList(int goods_no);
	
	int getCntbyGoodsno(int goods_no);
	
	//문의 작성
	int insertQna(GoodsInquiryVO qna);

}
