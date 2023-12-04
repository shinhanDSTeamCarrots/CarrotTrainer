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
	
	//����Ʈ ���
	@GetMapping("review/shoppingReview.do")
	public ModelAndView ShoppingReview(HttpSession session) {
		//************************************���������� �ٲܰ� �����
		int shoppingitem = (int)session.getAttribute("*********************");
		//model.addAttribute("list",service.selectReview(0, 1));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*******url");
		mav.addObject("list", null);
		return mav;
	}
	
	//Ư�� ������ �ۼ��� ���� ����Ʈ
	@GetMapping("review/myreview.do")
	public ModelAndView MyReview(HttpSession session) {
		//********************************************Ư�� ������ �ۼ��� ���� ����Ʈ
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*******url");//url ����
		mav.addObject("list", null);//object
		return mav;
	}
	
	//���� �ۼ� ����
	@GetMapping("review/write.do")
	public ModelAndView Write() {
		//���� �ۼ� ������ ����
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*************view name");
		mav.addObject("mode", "w");
		return mav;
	}
	
	//���� �ۼ��Ϸ�
	@PostMapping("review/afterwrite.do")
	public String AfterWrite(HttpServletRequest request) {
		request.getParameter("����");
		return "��ǰ ������";
	}
	
	
	
	//���� ����
	@GetMapping("review/modify.do")
	public ModelAndView Modify() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("**********************url");
		mav.addObject("mode", "m");
		return mav;
	}
	//���� ����
	@PostMapping("review/delete.do")
	public ModelAndView Delete(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*********url name");
		ReviewVO vo = (ReviewVO)request.getAttribute("ReviewVO");
		service.deleteReview(vo.getReview_no());
		
		return mav;
	}
	
	//���� ���ƿ�
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
	
	//���� ���ƿ� ���
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
