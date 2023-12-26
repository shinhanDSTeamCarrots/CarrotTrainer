package xyz.teamcarrot.myct.goods;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class QnaController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);

	@Autowired
	private QnaService service;
	
	@ResponseBody
	@GetMapping("/detail/{goods_no}/qnaList")
	public List<GoodsInquiryVO> qnaList(Model model, @PathVariable int goods_no) {
		List<GoodsInquiryVO> qnaList = service.getQnaList(goods_no);
	    logger.info("상품번호별 문의 리스트 goods_no {} qna: {}", goods_no, qnaList);
		return qnaList;
	}
	
	@ResponseBody
	@PostMapping("/detail/qna/{inquiry_no}")
	public GoodsInquiryVO eachQna(Model model, @PathVariable int inquiry_no) {
		System.out.println("inquiry number 체크! " + inquiry_no);
		GoodsInquiryVO qnaDetail = service.eachQna(inquiry_no);
		logger.info("!!!!!");
		return qnaDetail;
 	}
 	
	@ResponseBody
	@GetMapping("/detail/{goods_no}/qnaCnt")
	public int qnaCnt(Model model, @PathVariable int goods_no) {
		int qnaCnt=service.getCntbyGoodsno(goods_no);
		logger.info("상품번호별 문의 갯수 goods_no {} qnaCnt: {}", goods_no, qnaCnt);
		return qnaCnt;
	}
	
	@ResponseBody
	@PostMapping("/detail/qnaInsert")
	public String qnaInsert(GoodsInquiryVO vo, Model model, HttpSession session) {
		MemberVO login = (MemberVO)session.getAttribute("loginInfo");
		// 세션이 비어있거나 로그인되어 있지 않으면 로그인 페이지로 리다이렉트 ( 로그인해야 장바구니 표시가 보일거긴 함)
	    if (login == null) {
	       return "redirect:/member/login";
	    }
	    
		else{
			int member_no = login.getMember_no();
		    vo.setMember_no(member_no);
			int r = service.insertQna(vo);
			System.out.println("qna 작성자 체크! " + member_no);
			logger.info("qnawriter:" , member_no);
			if (r>0) {		
				return "success";
			}
			else {			
				return "error";
			}
		}
	}

}
