package xyz.teamcarrot.myct.pay;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.member.MemberVO;

@Controller
@Slf4j
@RequiredArgsConstructor
public class PayController implements InitializingBean{


	PayService service;
	
	private IamportClient iamportClient;
	
	@Value("${imp.api.key}")
	private String apiKey;
	@Value("${imp.api.secretkey}")
	private String secretKey;

	//PostConstructor
	@Override
	public void afterPropertiesSet() throws Exception {
		this.iamportClient = new IamportClient(apiKey, secretKey);
		
	}
	
	@GetMapping("pay/cart")
	public ModelAndView fromCart(HttpSession sess, HttpServletRequest request, @RequestParam("cartNos") List<Integer> value) {
		//조건
		//로그인 체크부터
		ModelAndView mav = new ModelAndView();
		MemberVO memvo = (MemberVO)sess.getAttribute("loginInfo");
		if(memvo == null) {
			//로그인 쪽으로 보낸다.
			mav.setViewName("redirect:/");
			return mav;
		}
		
		
		
		/*find with cart index*/
		Map parammap = new HashMap<String,Object>();
		parammap.put("list", value);
		parammap.put("member_no", memvo.getMember_no());
		List<BuyGoodsVO> goodsVOs = service.getCartGoods(parammap);
		if(goodsVOs.size() == 0) {
			mav.setViewName("redirect:/");
			return mav;
		}
		mav.addObject("goodsList",goodsVOs);
		
		int total_amt = goodsVOs.stream().mapToInt(o->o.getGoods_final_price()).sum();
		String title_name = goodsVOs.get(0).getGoods_name();
		if(goodsVOs.size() > 1) {
			title_name += " 외 "+(goodsVOs.size()-1) +"건";
		}
		
		mav.addObject("total_amt", total_amt);
		
		mav.addObject("buy_method", "C");
		
		mav.addObject("title_name", title_name);
		
		
		/*ADDR LIST*/
		List<Map<String,Object>> maps = service.getAddressList(memvo.getMember_no());
		
		/*to Json Array String*/
		String jsonStr = xyz.teamcarrot.myct.JsonUtils.getJsonStringFromList(maps);
		
		mav.addObject("addrList",maps);
		mav.addObject("addrJsonStr",jsonStr);
		
		int mileage = service.getMemberMileage(memvo.getMember_no());
		mav.addObject("mileage",mileage);
		
		mav.setViewName("pay/paypage");
		
		
		return mav;
	}
	//옵션 없으면 0
	@GetMapping("pay/pay")
	public ModelAndView fromGoods(HttpSession sess, HttpServletRequest request, @RequestParam("goods_no") int goods_no, @RequestParam("option_no") int option_no, @RequestParam("goods_cnt") int goods_cnt) {
		//조건
		//로그인 체크부터
		ModelAndView mav = new ModelAndView();
		MemberVO memvo = (MemberVO)sess.getAttribute("loginInfo");
		if(memvo == null) {
			//로그인 쪽으로 보낸다.
			mav.setViewName("redirect:/");
			return mav;
		}
		/*find with cart index*/
		Map parammap = new HashMap<String,Object>();
		parammap.put("goods_no", goods_no);
		parammap.put("option_no", option_no);
		parammap.put("goods_cnt", goods_cnt);
		BuyGoodsVO goodsVO = service.getGoods(parammap);
		List<BuyGoodsVO> goodsVOs = new ArrayList<BuyGoodsVO>();
		goodsVOs.add(goodsVO);
		mav.addObject("goodsList",goodsVOs);
		int total_amt = goodsVO.getGoods_final_price();
		String title_name = goodsVO.getGoods_name();
		mav.addObject("total_amt", total_amt);
		mav.addObject("buy_method", "G");
		mav.addObject("title_name", title_name);
		
		/*ADDR LIST*/
		List<Map<String,Object>> maps = service.getAddressList(memvo.getMember_no());
		
		/*to Json Array String*/
		String jsonStr = xyz.teamcarrot.myct.JsonUtils.getJsonStringFromList(maps);
		
		mav.addObject("addrList",maps);
		mav.addObject("addrJsonStr",jsonStr);
		
		int mileage = service.getMemberMileage(memvo.getMember_no());
		mav.addObject("mileage",mileage);
		
		mav.setViewName("pay/paypage");
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		return mav;
		
		
	}
	
	public void setPaySetting() {
		
		//상품 바로 구매로 넘어왔거나
		
		//상품 번호
		//상품 옵션 번호
		//상품 개수
		
		
		
		//장바구니로 넘어옴
		//선택된 장바구니 no 를 list로 받아온다
		
		
		
		/*
		try {
			//상품 바로 구매로 넘어온 경우
			//상품에 대한 정보를 Post 로 보냈다는 가정하에
			
		}catch(Exception e) {
		}*/
		
		/*
		//장바구니 - 장바구니 코드로 받아올 것
		List<BuyGoodsVO> goodsVOs = service.getCartGoods(memvo.getMember_no());
		if(goodsVOs.size() == 0) {
			mav.setViewName("redirect:/");
			return mav;
		}
		int total_amt = goodsVOs.stream().mapToInt(o->o.getGoods_final_price()).sum();
		mav.addObject("goodsList", goodsVOs);
		mav.addObject("total_amt",total_amt);
		
		
		mav.setViewName("pay/paypage");
		
		return mav;*/
	}
	@PostMapping("pay/payComplete")
	public ModelAndView payComplete(HttpSession sess, HttpServletRequest request, List<BuyGoodsVO> goods, PayDataDTO dto) {
		ModelAndView mav = new ModelAndView();
		try {
			MemberVO login = (MemberVO)sess.getAttribute("loginInfo");
			
			dto.setMember_no(login.getMember_no());
			
			int purchase_div = 0;
			if(dto.getPaytype().equals("INICIS")) {
				purchase_div = 1;
			}else if(dto.getPaytype().equals("TOSS")) {
				purchase_div = 2;
			}else if(dto.getPaytype().equals("KAKAO")) {
				purchase_div = 3;
			}else if(dto.getPaytype().equals("BANK")) {
				purchase_div = 0;
			}
			dto.setPurchase_div(purchase_div);
			
			int order = service.insertOrders(goods, dto);
			
			mav.addObject("order", order);
			
			
			log.info("결제 성공");
			mav.setViewName("pay/payDone");
		}
		catch(RuntimeException e) {
			log.info("주문상품 환불");
			mav.setViewName("pay/payFail");
		}
		catch(Exception e) {
			log.info("주문 실패");
			mav.setViewName("pay/payFail");
		}
		return mav;
	}
	
	@ResponseBody
	@PostMapping("pay/validation/{imp_uid}")
	public IamportResponse<Payment> validateIamport(@PathVariable String imp_uid){
		IamportResponse<Payment> payment;
		try {
			payment = iamportClient.paymentByImpUid(imp_uid);
			log.info("결제 요청 응답. 결제 내역 - 주문 번호: {}", payment.getResponse().getMerchantUid());
			return payment;
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO : 401 Unauthorized 
				break;
			case 404 :
				//TODO : imp_uidimp_uid 에 해당되는 거래내역이 존재하지 않음
			 	break;
			case 500 :
				//TODO : 서버 응답 오류
				break;
			}
		} catch (IOException e) {
			//서버 연결 실패
			e.printStackTrace();
		}
		return null;
	}

	
}
