package xyz.teamcarrot.myct.pay;

import java.io.IOException;
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
	public ModelAndView fromCart(HttpSession sess, HttpServletRequest request, @RequestParam("carts") int[] value) {
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
		List<BuyGoodsVO> goodsVOs = service.getCartGoods(parammap);
		
		
		
		
		
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
	@PostMapping("pay/pay")
	public ModelAndView payComplete(HttpSession sess, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			MemberVO login = (MemberVO)sess.getAttribute("loginInfo");
			
			log.info("결재 성공");
		}
		catch(RuntimeException e) {
			
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
