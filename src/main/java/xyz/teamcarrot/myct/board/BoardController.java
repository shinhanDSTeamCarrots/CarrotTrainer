package xyz.teamcarrot.myct.board;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	
	@Autowired
	private BoardService bservice;
	
	@GetMapping("/freeboard.do")
	public String freeboard(Model model) {
		model.addAttribute("list", bservice.getList());
		return "board/freeboard";
	}
	
	@GetMapping("/write")
	public String write() {
		
		
		return "/board/write";
	}
	
	
	
	@GetMapping("/board/noticeboard.do")
	public String noticeboard() {
		
		return "board/noticeboard";
	}
	
	
	
	// 나중에 POST로 바꾸기
	@GetMapping("/board/qnaboard.do")
	public String Qnaboard() {
		return "board/Qnaboard";
	}
	
	
	
	/* 게시판 조회 */
	@GetMapping("/read.do")
	public String boardGetPageGET(int board_no, Model model) {
        BoardVO vo = bservice.getPage(board_no);
        System.out.println("test: " + vo.getBoard_no());
        model.addAttribute("pageInfo", bservice.getPage(board_no));
        return "board/read";	
    }
}
