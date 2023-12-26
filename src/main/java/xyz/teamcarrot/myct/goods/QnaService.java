package xyz.teamcarrot.myct.goods;

import java.util.List;

public interface QnaService {
	
	//문의 목록
	List<GoodsInquiryVO> getQnaList(int goods_no);
	
	GoodsInquiryVO eachQna(int inquiry_no);
	
	//상품별 문의 갯수
	int getCntbyGoodsno(int goods_no);
	
	//문의 작성
	int insertQna(GoodsInquiryVO qna);

}
