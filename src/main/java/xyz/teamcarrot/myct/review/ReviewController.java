/* Created:		23.12.01
 * Author:		������
 * Description:	���� ��Ʈ�ѷ�. �Լ��� ��� �ļ�
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.goods.GoodsService;
import xyz.teamcarrot.myct.member.MemberVO;
@Slf4j
@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	@Autowired
	GoodsService goodsservice;
	
	
	
	
	
	//AJAX 로 변환 필요?
	//쇼핑몰 상품 리뷰 리스트
	@GetMapping("review/shoppingReview")
	public ModelAndView ShoppingReview(HttpSession session, HttpServletRequest request) {
		log.debug("review/shopping start");
		int goods_no;
		try {
			goods_no = Integer.parseInt(request.getParameter("goods_no"));
		}
		catch(NumberFormatException nfe) {
			goods_no = -1;
		}
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
		log.debug("review/shopping selectData");
		
		Map returnmap = service.selectData(goods_no);
		if(returnmap.get("avg_point") != null) {
			BigDecimal d = (BigDecimal)returnmap.get("avg_point");
			returnmap.put("avg_point", Math.round(d.doubleValue() * 100)/100.0f);
			int value = (int) Math.round(d.doubleValue() * 2);
			log.info("value: "+Math.round(d.doubleValue() * 2));
			returnmap.put("avg_point_display", value);
		}
		
		
		
		Map paramMap = new HashMap<String, Object>();
		paramMap.put("page",(page_no-1) * 10 );
		paramMap.put("self_no", self_no);
		paramMap.put("goods_no", goods_no);
		paramMap.put("alignType", alignType);
		paramMap.put("searchType", "goods_search");
		
		
		log.debug(returnmap.get("total_page").getClass().getName());
		
		
		
		returnmap.put("list", service.selectReview(paramMap));
		returnmap.put("page",page_no);
		returnmap.put("alignType", alignType);
		int total_cnt = ((Long)returnmap.get("total_cnt")).intValue();
		int total_page = ((Long)returnmap.get("total_page")).intValue();
		log.debug("total_cnt: "+total_cnt);
		log.debug("total_page: "+total_page);
		if(total_cnt > 0) {
			List<Integer> listint = new ArrayList<Integer>();
			for(int i = ((page_no-1)/5) * 5 + 1; (i <= total_page )&&(i <= ((page_no-1)/5+1) * 5);i++ ) {
				log.debug("added: "+i);
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
	@GetMapping("review/myreview")
	public ModelAndView MyReview(HttpSession session) {
		//********************************************Ư�� ������ �ۼ��� ���� ����Ʈ
		ModelAndView mav = new ModelAndView();
		mav.setViewName("*******url");//url ����
		mav.addObject("list", null);//object
		return mav;
	}
	
	//리뷰 작성 페이지
	@GetMapping("review/write")
	public ModelAndView Write(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();
		
		
		if(((MemberVO)sess.getAttribute("loginInfo")) == null) {

			mav.addObject("cmd", "move");
			mav.addObject("msg", "로그인이 필요합니다.");
			mav.addObject("url", "/myct/member/login");
			mav.setViewName("common/alert");
			return mav;
		}
		
		
		
		mav.setViewName("review/reviewWrite");
		
		int goods_no = -1;
		
		try {
			goods_no =Integer.parseInt(request.getParameter("goods_no"));
		}
		catch(Exception e) {
			log.error(e.toString());
		}
		mav.addObject("goods_no",goods_no);
		mav.addObject("gData",goodsservice.detail(goods_no));
		//리뷰 정보용 goods_no 가져옴
		mav.addObject("mode", "w");
		mav.addObject("ReviewNo",-1);
		
		
		return mav;
	}
	
	
	
	//리뷰 수정
	@GetMapping("review/modify")
	public ModelAndView Modify(HttpServletRequest request, HttpSession sess) {
		ModelAndView mav = new ModelAndView();

		if(((MemberVO)sess.getAttribute("loginInfo")) == null) {
			mav.setViewName("redirect:/");
			return mav;
		}
		
		mav.setViewName("review/reviewWrite");
		int review_no;
		try {
			review_no =Integer.parseInt(request.getParameter("review_no"));
		}
		catch(Exception e) {
			review_no = -1;
		}
		//리뷰 정보용 goods_no 랑
		//리뷰 정보 가져옴
		ReviewVO vo = service.getSpecificReview(review_no);
		mav.addObject("goods_no",vo.getGoods_no());
		mav.addObject("gData",goodsservice.detail(vo.getGoods_no()));
		mav.addObject("ReviewNo",vo.getReview_no());
		mav.addObject("ReviewVO", vo);
		mav.addObject("mode", "m");
		return mav;
	}
	
	
	//리뷰 작성 후 쇼핑몰 연결
	@PostMapping("review/write")
	public String AfterWrite( HttpSession session,@RequestParam Map<String, String> formData, HttpServletRequest req) {
		ReviewVO vo;
		vo = new ReviewVO();
		String mode = formData.get("mode");
		if(mode.equals("m")) {
			vo.setReview_no(Integer.parseInt(formData.get("review_no")));
		}
		if(mode.equals("w"))
			vo.setGoods_no(Integer.parseInt(formData.get("goods_no")));
		log.debug(formData.get("imgstr"));
		if(formData.get("imgstr") != null && !formData.get("imgstr").equals("") && formData.get("imgstr").getBytes() != null)
			vo.setImage(formData.get("imgstr").getBytes());
		vo.setPoint(Integer.parseInt(formData.get("point")));
		vo.setContent(formData.get("content"));

		if(mode.equals("w"))
			vo.setMember_no(((MemberVO)session.getAttribute("loginInfo")).getMember_no());
		
		if(mode.equals("w"))
			service.insertReview(vo);
		else
			service.updateReview(vo);
		
		
		return "/detail/"+vo.getGoods_no();
	}
	
	//리뷰 삭제
	@ResponseBody
	@PostMapping("review/delete")
	public String Delete(HttpServletRequest request, @RequestParam int review_no) {
		try {
			service.deleteReview(review_no);
			return "T";
		}catch(Exception e) {
			log.error(e.toString());
			return "F";
		}
		
	}
	
	//리뷰 좋아요
	@ResponseBody
	@PostMapping("review/like")
	public String Like(HttpServletRequest request, @RequestParam int review_no, @RequestParam int mem_no ) {
		try {
			log.debug("review_no: "+review_no +"\tmem_no: "+mem_no);
			log.debug("review Like Called");
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
	@PostMapping("review/dislike")
	public String Dislike(HttpServletRequest request, @RequestParam int review_no, @RequestParam int mem_no) {
		try {
			log.debug("review_no: "+review_no +"\tmem_no: "+mem_no);
			log.debug("review Like Called");
			service.dislikeReview(review_no, mem_no);
			return "T";
		}
		catch(Exception e){
			return "F";
		}
	}
	
	
	
	
	
}
