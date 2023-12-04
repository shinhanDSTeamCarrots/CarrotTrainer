package xyz.teamcarrot.myct;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@GetMapping("/board/boardInfo.do")
	public String boardInfo() {
		
		return "admin/board/boardInfo";
	}
	
	@GetMapping("/board/notice.do")
	public String notice() {
		
		return "admin/board/notice";
	}
	
	@GetMapping("/board/noticeWrite.do")
	public String noticeWrite() {
		
		return "admin/board/noticeWrite";
	}
	
	@GetMapping("/board/qna.do")
	public String qna() {
		
		return "admin/board/qna";
	}
	
	@GetMapping("/board/qnaReply.do")
	public String qnaReply() {
		
		return "admin/board/qnaReply";
	}
	
	@GetMapping("/news/adminNews.do")
	public String adminNews() {
		
		return "admin/news/adminNews";
	}
	
	@GetMapping("/news/adminWrite.do")
	public String adminWrite() {
		
		return "admin/news/adminWrite";
	}
	
	@GetMapping("/mypage/main.do")
	public String main() {
		
		return "mypage/main";
	}
}
