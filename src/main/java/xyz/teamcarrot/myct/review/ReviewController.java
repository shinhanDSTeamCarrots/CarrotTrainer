/* Created:		23.12.01
 * Author:		������
 * Description:	���� ��Ʈ�ѷ�. �Լ��� ��� �ļ�
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.net.http.HttpRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import xyz.teamcarrot.myct.member.MemberVO;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	//AJAX 로 변환 필요?
	//쇼핑몰 상품 리뷰 리스트
	@GetMapping("review/shoppingReview.do")
	public ModelAndView ShoppingReview(HttpSession session, HttpServletRequest request) {
		logger.warn("review/shopping start");
		int goods_no = Integer.parseInt(request.getParameter("goods_no"));
		
		int page_no = 1;
		try{
			page_no = Integer.parseInt(request.getParameter("page_no"));
		}catch(Exception e) {
			//do noting
		}
		
		MemberVO loginVO = (MemberVO)session.getAttribute("loginInfo");
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
		logger.debug("review/shopping selectData");
		
		Map returnmap = service.selectData(goods_no);
		
		
		
		Map paramMap = new HashMap<String, Object>();
		paramMap.put("page",(page_no-1) * 10 );
		paramMap.put("self_no", self_no);
		paramMap.put("goods_no", goods_no);
		paramMap.put("alignType", alignType);
		paramMap.put("searchType", "goods_search");
		
		
		logger.error(returnmap.get("total_page").getClass().getName());
		
		
		
		returnmap.put("list", service.selectReview(paramMap));
		returnmap.put("page",page_no);
		returnmap.put("alignType", alignType);
		int total_cnt = ((Long)returnmap.get("total_cnt")).intValue();
		int total_page = ((Long)returnmap.get("total_page")).intValue();
		logger.error("total_cnt: "+total_cnt);
		logger.error("total_page: "+total_page);
		if(total_cnt > 0) {
			List<Integer> listint = new ArrayList<Integer>();
			for(int i = ((page_no-1)/5) * 5 + 1; (i <= total_page )&&(i <= ((page_no-1)/5+1) * 5);i++ ) {
				logger.error("added: "+i);
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
	public ModelAndView Write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/reviewWrite");
		try {
			int goods_no =Integer.parseInt(request.getParameter("goods_no"));
			mav.addObject("goods_no",goods_no);
		}
		catch(Exception e) {
			logger.error(e.toString());	
		}
		//리뷰 정보용 goods_no 가져옴
		mav.addObject("mode", "w");
		
		
		return mav;
	}
	
	//리뷰 작성 후 쇼핑몰 연결
	@PostMapping("review/write.do")
	public String AfterWrite(HttpServletRequest request) {
		//request.getParameter("*********after url");
		//리뷰 정보 가져옴
		
		return "/review/complete.jsp";
	}
	
	
	
	//리뷰 수정
	@GetMapping("review/modify.do")
	public ModelAndView Modify(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/reviewWrite");
		int goods_no =(int)request.getAttribute("goods_no");
		//리뷰 정보용 goods_no 랑
		//리뷰 정보 가져옴
		mav.addObject("goods_no",goods_no);
		mav.addObject("mode", "m");
		return mav;
	}
	//리뷰 삭제
	@ResponseBody
	@PostMapping("review/delete.do")
	public String Delete(HttpServletRequest request, @RequestParam int review_no) {
		try {
			service.deleteReview(review_no);
			return "T";
		}catch(Exception e) {
			logger.error(e.toString());
			return "F";
		}
		
	}
	
	//리뷰 좋아요
	@ResponseBody
	@PostMapping("review/like.do")
	public String Like(HttpServletRequest request, @RequestParam int review_no, @RequestParam int mem_no ) {
		try {
			logger.error("review_no: "+review_no +"\tmem_no: "+mem_no);
			logger.debug("review Like Called");
			service.likeReview(review_no, mem_no);
			return "T";
		}
		catch(org.springframework.dao.DuplicateKeyException duplicateException) {
			//이미 처리됨
			return "D";
		}
		catch(Exception e){
			e.printStackTrace();
			return "F";
		}
	}
	
	//리뷰 좋아요 취소함
	@ResponseBody
	@PostMapping("review/dislike.do")
	public String Dislike(HttpServletRequest request, @RequestParam int review_no, @RequestParam int mem_no) {
		try {
			logger.error("review_no: "+review_no +"\tmem_no: "+mem_no);
			logger.debug("review Like Called");
			service.dislikeReview(review_no, mem_no);
			return "T";
		}
		catch(Exception e){
			return "F";
		}
	}
	
	
	
	
}
