/* Created:		23.12.01
 * Author:		������
 * Description:	���� ��Ʈ�ѷ�. �Լ��� ��� �ļ�
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	//쇼핑몰 상품 리뷰 리스트
	@GetMapping("review/shoppingReview.do")
	public ModelAndView ShoppingReview(HttpSession session) {
		//************************************���������� �ٲܰ� �����
		int shoppingitem = (int)session.getAttribute("*********************");
		//model.addAttribute("list",service.selectReview(0, 1));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("goods/reviewslist");
		mav.addObject("list", null);
		return mav;
	}
	
	//내가 쓴 리뷰 보기
	@GetMapping("review/myreview.do")
	public ModelAndView MyReview(HttpSession session) {
		//********************************************Ư�� ������ �ۼ��� ���� ����Ʈ
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*******url");//url ����
		mav.addObject("list", null);//object
		return mav;
	}
	
	//리뷰 작성 페이지
	@GetMapping("review/write.do")
	public ModelAndView Write() {
		//���� �ۼ� ������ ����
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*************view name");
		mav.addObject("mode", "w");
		return mav;
	}
	
	//리뷰 작성 후 쇼핑몰 연결
	@PostMapping("review/afterwrite.do")
	public String AfterWrite(HttpServletRequest request) {
		request.getParameter("*********after url");
		return "/review/complete.jsp";
	}
	
	
	
	//리뷰 수정
	@GetMapping("review/modify.do")
	public ModelAndView Modify() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("**********************url");
		mav.addObject("mode", "m");
		return mav;
	}
	//리뷰 삭제
	@PostMapping("review/delete.do")
	public ModelAndView Delete(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*********url name");
		ReviewVO vo = (ReviewVO)request.getAttribute("ReviewVO");
		service.deleteReview(vo.getReview_no());
		
		return mav;
	}
	
	//리뷰 좋아요
	@ResponseBody
	@PostMapping("review/like.do")
	public String Like(HttpServletRequest request) {
		try {
			int review_no = (int)request.getAttribute("review_no");
			int member_no = (int)request.getAttribute("member_no");
			service.likeReview(review_no, member_no);
			return "T";
		}
		catch(Exception e){
			return "F";
		}
	}
	
	//리뷰 좋아요 취소함
	@ResponseBody
	@PostMapping("review/dislike.do")
	public String Dislike(HttpServletRequest request) {
		try {
			int review_no = (int)request.getAttribute("review_no");
			int member_no = (int)request.getAttribute("member_no");
			service.dislikeReview(review_no, member_no);
			return "T";
		}
		catch(Exception e){
			return "F";
		}
	}
	
	
	
	
}
