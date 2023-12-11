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

/* Controller ������̼��� ���� �ش� Ŭ������ �������� ������ �ν��ϱ� ���� 
 * RequestMapping�� /board�� �����ϴ� ��� ó���� BoardController�� �ϵ��� �����ϴ� ������ �Ѵ�.
 * */
@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService bservice;


	/* �Խ��� ��� ������ ����(����¡ ����) */
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
			

	/* �Խ��� ��� ������ ���� */
	@GetMapping("/write.do")
	public String boardEnrollGET() {

		log.info("�Խ��� ��� ������ ����");
		return "board/write";
	}

	/* �Խ��� ��� */
	@PostMapping("/insert.do")
	public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {

		log.info("BoardVO : " + board);
		
		/* jsp�� ���� ���� �����͸� DB�� �����ؾ���. 
		 * ���� �Ķ���� �ο��Ͽ� �Ѱ��ֱ⸸ �ϸ� ��.*/
		bservice.enroll(board);
		
		/* ��� ���� ���â ���� 
		 * addFlashAttribute�� �� ������ ��ȸ�����θ� �����͸� �����ϱ� ���ؼ� */
		rttr.addFlashAttribute("result", "enrol success");
		
		/* �����̷�Ʈ�� ���� ������ ���, ����, ������ ���� �۾��� ó���� �� �� 
		 * ���ΰ�ħ�� ���� �Ȱ��� ������ ��� ������ ����� �� ���� �ϱ� ����
		 * */
		// ī�װ� ��ȣ�� ���� �����̷�Ʈ ����
	    switch (board.getCategory_no()) {
	        case 1:
	            // ��������
	            return "redirect:/board/noticeboard.do";
	        case 2:
	            // �����Խ���
	            return "redirect:/board/freeboard.do";
	        case 3:
	            // ���ǰԽ���
	            return "redirect:/board/qnaboard.do";
	        default:
	            // �⺻ �����̷�Ʈ (Ȥ�� ���� �������� �����̷�Ʈ)
	            return "redirect:/";
	    }
	}	

	/* ������ ���� */
	@PostMapping("/delete.do")
	public String boardDeletePOST(int board_no, RedirectAttributes rttr) {

		bservice.delete(board_no);

		rttr.addFlashAttribute("result", "delete success");

		return "redirect:/board/freeboard.do";
	}

	/* �Խ��� ��ȸ */
	@GetMapping("/read.do")
	public String boardGetPageGET(int board_no, Model model, Criteria cri) {
		BoardVO vo = bservice.getPage(board_no);
		System.out.println("test: " + vo.getBoard_no());
		model.addAttribute("pageInfo", bservice.getPage(board_no));
		model.addAttribute("cri", cri);
		return "board/read";
	}

	/* ���� ������ �̵� */
	@GetMapping("/modify.do")
	public String boardModifyGET(int board_no, Model model, Criteria cri) {

		model.addAttribute("pageInfo", bservice.getPage(board_no));
		model.addAttribute("cri", cri);
		return "board/modify";
	}

	/* ������ ���� */
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
