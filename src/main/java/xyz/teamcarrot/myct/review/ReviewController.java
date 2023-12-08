/* Created:		23.12.01
 * Author:		������
 * Description:	���� ��Ʈ�ѷ�. �Լ��� ��� �ļ�
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	
	
	//쇼핑몰 상품 리뷰 리스트
	@GetMapping("review/shoppingReview.do")
	public ModelAndView ShoppingReview(HttpSession session, HttpServletRequest request) {
		System.out.println("review/shopping start");
		int goods_no = Integer.parseInt(request.getParameter("goods_no"));
		
		int page_no = 1;
		try{
			page_no = Integer.parseInt(request.getParameter("page_no"));
		}catch(Exception e) {
			//do noting
		}
		
		MemberVO loginVO = (MemberVO)session.getAttribute("loginVO");
		int self_no = -1;
		if(loginVO != null) {
			self_no = loginVO.getMember_no();
		}
		String alignType = "";
		if(request.getParameter("alignType") == null || request.getParameter("alignType").equals("")) {
			alignType = "regist_desc";
		}
		else {
			alignType=request.getParameter("alignType");
		}
		
		//model.addAttribute("list",service.selectReview(0, 1));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("goods/reviewlist");
		System.out.println("review/shopping selectData");
		
		Map returnmap = service.selectData(goods_no);
		
		
		
		Map paramMap = new HashMap<String, Object>();
		paramMap.put("page",(page_no-1) * 10 );
		paramMap.put("self_no", self_no);
		paramMap.put("goods_no", goods_no);
		paramMap.put("alignType", alignType);
		paramMap.put("searchType", "goods_search");
		
		
		System.out.println(returnmap.get("total_page").getClass().getName());
		
		
		
		returnmap.put("list", service.selectReview(paramMap));
		returnmap.put("page",page_no);
		returnmap.put("alignType", alignType);
		int total_cnt = ((Long)returnmap.get("total_cnt")).intValue();
		int total_page = ((Long)returnmap.get("total_page")).intValue();
		System.out.println("total_cnt: "+total_cnt);
		System.out.println("total_page: "+total_page);
		if(total_cnt > 0) {
			List<Integer> listint = new ArrayList<Integer>();
			for(int i = ((page_no-1)/5) * 5 + 1; (i <= total_page )&&(i <= ((page_no-1)/5+1) * 5);i++ ) {
				System.out.println("added: "+i);
				listint.add(i);
			}
			returnmap.put("page_list", listint);
		}
		returnmap.put("prev_page", (page_no/5) * 5 );
		returnmap.put("next_pageable", (page_no/5 + 1) * 5 +1 >= total_page ? false : true);
		returnmap.put("next_page", (page_no/5 +1) * 5 +1 );
		
		//returnmap.put("pageFirst",page_no/5);
		//returnmap.put("pageLast", (page_no/5)+1);
		
		mav.addObject("map", returnmap);
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
	@PostMapping("review/write.do")
	public String AfterWrite(HttpServletRequest request) {
		//request.getParameter("*********after url");
		
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
