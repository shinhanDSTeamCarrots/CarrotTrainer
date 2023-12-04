package xyz.teamcarrot.myct.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {
	
	@GetMapping("/board/noticeboard.do")
	public String noticeboard() {
		
		return "board/noticeboard";
	}
	
	@GetMapping("/board/freeboard.do")
	public String freeboard() {
		
		return "board/freeboard";
	}
	
	
	
	@GetMapping("/board/qnaboard.do")
	public String Qnaboard() {
		return "board/Qnaboard";
	}
	
	@GetMapping("/board/write.do")
	public String write() {
		return "board/write";
	}
	
	@GetMapping("/board/read.do")
	public String read() {
		return "board/read";
	}
}
