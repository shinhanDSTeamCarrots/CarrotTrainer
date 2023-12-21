package xyz.teamcarrot.myct.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaMapper mapper;

	@Override
	public List<GoodsInquiryVO> qnaList(int goods_no) {
		
		List<GoodsInquiryVO> qnaList = mapper.qnaList(goods_no);
		return qnaList;
	}

	@Override
	public int qnaInsert(GoodsInquiryVO qna) {
		return mapper.qnaInsert(qna);
	}

}
