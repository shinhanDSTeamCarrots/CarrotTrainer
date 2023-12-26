package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImpl implements QnaService {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	@Autowired
	private QnaMapper mapper;

	@Override
	public List<GoodsInquiryVO> getQnaList(int goods_no) {				
		logger.info("상품 번호 {}에 대한 Q&A 목록 가져오기", goods_no);
	    List<GoodsInquiryVO> qnaList = mapper.qnaList(goods_no);
	    logger.info("Q&A 목록 검색 결과: {}", qnaList);
	    return qnaList;
	}

	@Override
	public int insertQna(GoodsInquiryVO qna) {
		return mapper.qnaInsert(qna);
	}

	@Override
	public int getCntbyGoodsno(int goods_no) {
		logger.info("상품 번호 {}에 대한 qna 개수",goods_no);
		int qnaCnt=mapper.getCntbyGoodsno(goods_no);
		logger.info("qna 개수:{}",qnaCnt);
		return qnaCnt;
	}

	
}
