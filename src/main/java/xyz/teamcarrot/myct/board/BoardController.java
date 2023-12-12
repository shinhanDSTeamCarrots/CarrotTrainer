package xyz.teamcarrot.myct.board;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/* Controller 어노테이션의 경우는 해당 클래스를 스프링의 빈으로 인식하기 위함 
 * RequestMapping은 /board로 시작하는 모든 처리를 BoardController가 하도록 지정하는 역할을 한다.
 * */
@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService bservice;


	/* 게시판 목록 페이지 접속(페이징 적용) */
	@GetMapping("/freeboard.do")
	public String boardListGET(Model model, Criteria cri) {

		log.info("boardListGET");

		model.addAttribute("list", bservice.getListPaging(cri));
		int total = bservice.getTotal(cri);

		PageMakerDTO pageMake = new PageMakerDTO(cri, total);

		model.addAttribute("pageMaker", pageMake);
		return "board/freeboard";
	}
	

			@GetMapping("/qnaboard.do")
			public String Qnaboard(Model model, Criteria cri) {
			
				log.info("boardListGET");

				model.addAttribute("list", bservice.getListPaging(cri));
				int total = bservice.getTotal(cri);

				PageMakerDTO pageMake = new PageMakerDTO(cri, total);

				return "board/Qnaboard";
			}
			

	/* 게시판 등록 페이지 접속 */
	@GetMapping("/write.do")
	public String boardEnrollGET() {

		log.info("게시판 등록 페이지 진입");
		return "board/write";
	}

	/* 게시판 등록 */
	@PostMapping("/insert.do")
	public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {

		log.info("BoardVO : " + board);
		
		/* jsp로 부터 받은 데이터를 DB에 저장해야함. 
		 * 그저 파라미터 부여하여 넘겨주기만 하면 됨.*/
		bservice.enroll(board);
		
		/* 등록 성공 경고창 구현 
		 * addFlashAttribute를 쓴 이유는 일회성으로만 데이터를 전달하기 위해서 */
		rttr.addFlashAttribute("result", "enrol success");
		
		/* 리다이렉트를 쓰는 이유는 등록, 수정, 삭제와 같은 작업이 처리가 된 후 
		 * 새로고침을 통해 똑같은 내용을 계속 서버에 등록할 수 없게 하기 위함
		 * */
		// 카테고리 번호에 따른 리다이렉트 설정
	    switch (board.getCategory_no()) {
	        case 1:
	            // 공지사항
	            return "redirect:/board/noticeboard.do";
	        case 2:
	            // 자유게시판
	            return "redirect:/board/freeboard.do";
	        case 3:
	            // 문의게시판
	            return "redirect:/board/qnaboard.do";
	        default:
	            // 기본 리다이렉트 (혹은 오류 페이지로 리다이렉트)
	            return "redirect:/";
	    }
	}	

	/* 페이지 삭제 */
	@PostMapping("/delete.do")
	public String boardDeletePOST(int board_no, RedirectAttributes rttr) {

		bservice.delete(board_no);

		rttr.addFlashAttribute("result", "delete success");

		return "redirect:/board/freeboard.do";
	}

	/* 게시판 조회 */
	@GetMapping("/read.do")
	public String boardGetPageGET(int board_no, Model model, Criteria cri) {
		BoardVO vo = bservice.getPage(board_no);
		System.out.println("test: " + vo.getBoard_no());
		model.addAttribute("pageInfo", bservice.getPage(board_no));
		model.addAttribute("cri", cri);
		return "board/read";
	}

	/* 수정 페이지 이동 */
	@GetMapping("/modify.do")
	public String boardModifyGET(int board_no, Model model, Criteria cri) {

		model.addAttribute("pageInfo", bservice.getPage(board_no));
		model.addAttribute("cri", cri);
		return "board/modify";
	}

	/* 페이지 수정 */
	@PostMapping("/modify.do")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {

		bservice.modify(board);

		rttr.addFlashAttribute("result", "modify success");

		return "redirect:/board/freeboard.do";

	}
	
	
	
	@GetMapping("/board/noticeboard.do")
	public String noticeboard() {

		return "board/noticeboard";
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
