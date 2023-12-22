package xyz.teamcarrot.myct.board;

import java.util.HashMap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xyz.teamcarrot.myct.member.MemberService;
import xyz.teamcarrot.myct.member.MemberVO;

/* Controller ������̼��� ���� �ش� Ŭ������ �������� ������ �ν��ϱ� ���� 
 * RequestMapping�� /board�� �����ϴ� ��� ó���� BoardController�� �ϵ��� �����ϴ� ������ �Ѵ�.
 * */
@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService bservice;
	@Autowired
	private MemberService mservcie;

	// 자유게시판 리스트 출력
	@GetMapping("/freeboard")
	public String boardListGET(Model model, Criteria cri, HttpServletRequest request, HttpSession session) {

		log.info("freeboardListGET");

		model.addAttribute("list", bservice.getListPaging(cri));
		int total = bservice.getTotal(cri);

		PageMakerDTO pageMake = new PageMakerDTO(cri, total);
		model.addAttribute("pageMaker", pageMake);

		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			model.addAttribute("member", member);
		}
		return "board/freeboard";
	}

	// 자유게시판 게시글 조회
	@GetMapping("/freedetail")
	public String boardGetPageGET(int board_no, Model model, HttpSession session, Criteria cri) {
		BoardVO board = bservice.getPage(board_no);
		log.info("test: " + board.getBoard_no());
		model.addAttribute("cri", cri);
		model.addAttribute("pageInfo", board);

		int result = bservice.updateRecomCount(board_no);
		model.addAttribute("resultList", result);

		// 해당 게시글의 답글 목록 조회
		List<ReplyVO> replies = bservice.getReplies(board_no);
		model.addAttribute("replyList", replies);

		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("loginMember", member);
		}

		return "board/freedetail";
	}
	
	// (관리자 페이지) 자유게시판 게시글 관리
	@GetMapping("/board/boardInfo")
	public String boardInfo(Model model, HttpSession session, Criteria cri) {

		model.addAttribute("page", bservice.getListPaging(cri));
		int total = bservice.getTotal(cri);

		PageMakerDTO pageMake = new PageMakerDTO(cri, total);
		model.addAttribute("pageMaker", pageMake);

		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			model.addAttribute("member", member);
		}
		return "admin/board/boardInfo";
	}
	
	
	// 문의게시판 리스트 출력
	@GetMapping("/qnaboard")
	public String QnaboardList(Model model, HttpSession session, HttpServletRequest request) {
		log.info("QnaboardListGET");

		// 게시판 목록을 모델에 추가
		model.addAttribute("page", bservice.getList());

		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("member", member);
		}

		return "board/Qnaboard";
	}

	// 문의게시판 게시글 조회와 답글 목록을 조회
	@GetMapping("/Qnadetail")
	public String boardDetail(int board_no, Model model, HttpSession session) {
		
		BoardVO board = bservice.getPage(board_no);
		model.addAttribute("pageInfo", board);

		
		List<ReplyVO> replies = bservice.getReplies(board_no);
		model.addAttribute("replyList", replies);

		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("loginMember", member);
		}

		return "board/Qnadetail";
	}
	
	// (관리자 페이지) 문의게시판 게시글 관리
	@GetMapping("/board/qna")
	public String qna(Model model, HttpSession session, HttpServletRequest request) {
		log.info("QnaboardListGET");

		model.addAttribute("page", bservice.getList());
		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("member", member);
		}
		return "admin/board/qna";
	}
	
	// 공지사항 게시글 리스트 출력
	@GetMapping("/noticeboard")
	public String noticeboard(Model model, HttpSession session, HttpServletRequest request) {

		
		model.addAttribute("page", bservice.getList());
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("noticeMember", member);
		}
		return "board/noticeboard";
	}
	
	// (관리자 페이지) 공지사항 게시글 관리 
	@GetMapping("/board/notice")
	public String notice(Model model, HttpSession session, HttpServletRequest request) {

		
		model.addAttribute("page", bservice.getList());

		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("adminMember", member);
		}

		return "admin/board/notice";
	}

	/* 다중 선택 삭제(미완성) */
//    @PostMapping("/deleteSelected")
//    @ResponseBody
//    public ResponseEntity<?> deleteSelectedBoards(@RequestParam("board_nos") List<Integer> boardNos) {
//        try {
//            bservice.deleteSelectedBoards(boardNos);
//            return ResponseEntity.ok("success");
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
//        }
//    }
	
	// 다중 선택 제거
	@PostMapping("/deleteSelected")
	@ResponseBody
	public String deleteSelectedBoards(@RequestParam("board_nos") List<Integer> boardNos) {
		try {
			bservice.deleteSelectedBoards(boardNos);
			return "success";
		} catch (Exception e) {
			
			return "fail";
		}
	}
	
	// 조회수 
	@PostMapping("/updateViewCount")
	public String ViewCount(int board_no, Model model, BoardVO board) {
		bservice.updateViewCount(board_no);

		log.info("조회수 테스트 성공");
		return "success";
	}

	// 추천수 (미완성)
	@PostMapping("/updateRecomCount")
	@ResponseBody
	public String RecomCount(int board_no, Model model, BoardRecomVO boardrecom) {
		bservice.updateRecomCount(board_no);
		log.info("추천수 테스트 성공");
		return "success";
	}
	
	// 댓글 등록
	@PostMapping("/insertReply")
	@ResponseBody
	public String insertReply(ReplyVO reply, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");

		if (member != null) {
			
			reply.setMember_no(member.getMember_no());
			
			log.info("댓글 등록을 시도합니다. 댓글 내용: {}", reply.getReply_content());
			int replyresult = bservice.insertReply(reply);
			
			log.info("댓글 등록 결과: {}", replyresult > 0 ? "성공" : "실패"); 

			return replyresult > 0 ? "success" : "fail";
		}
		
		return "notLoggedIn"; 
	}

	// 댓글 삭제 
	@ResponseBody
	@PostMapping("/replydelete")
	public String replyDeletePOST(ReplyVO replyvo, @RequestParam("reply_id") int reply_no) {
		try {
			bservice.deleteReply(reply_no);
			return "success";
		} catch (Exception e) {
			log.error(e.toString());
			return "fail";
		}
	}

	// 특정 게시글의 댓글 목록을 반환
	@GetMapping("/getReplies")
	@ResponseBody
	public List<ReplyVO> getRepliesForBoard(@RequestParam("board_no") int boardNo) {
		return bservice.getReplies(boardNo);
	}

	@GetMapping("/qnareply")
	public String Qnareply(Model model) {
		return "board/Qnareply";
	}

	@GetMapping("/cancel")
	public String boardCancleGET(int category_no, int board_no, Model model) {

		switch (category_no) {
		case 1:
			return "redirect:/board/noticedetail";
		case 2:
			return "redirect:/board/freedetail";
		case 3:
			return "redirect:/board/Qnadetail";
		default:
			return "redirect:/";
		}
	}

	/* �Խ��� ��� ������ ���� */
	@GetMapping("/write")
	public String boardEnrollGET() {

		log.info("�Խ��� ��� ������ ����");
		return "board/write";
	}

	/* �Խ��� ��� */
	@PostMapping("/insert")
	public String boardEnrollPOST(@RequestParam("file") MultipartFile file, HttpSession session, BoardVO board,
			RedirectAttributes rttr, HttpServletRequest request) {

		log.info("BoardVO : " + board);
		session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("loginInfo");
		board.setMember_no(login.getMember_no());

		bservice.enroll(board, file, request);
		rttr.addFlashAttribute("result", "enrol success");
		switch (board.getCategory_no()) {
		case 1:
			return "redirect:/board/noticeboard";
		case 2:
			return "redirect:/board/freeboard";
		case 3:
			return "redirect:/board/qnaboard";
		default:
			return "redirect:/";
		}
	}

	/* ������ ���� */
	@PostMapping("/delete")
	public String boardDeletePOST(int board_no, int category_no, RedirectAttributes rttr) {
		bservice.delete(board_no);
		rttr.addFlashAttribute("result", "delete success");

		
		switch (category_no) {
		case 1:
			return "redirect:/board/noticeboard";
		case 2:
			return "redirect:/board/freeboard";
		case 3:
			return "redirect:/board/qnaboard";
		default:
			return "redirect:/"; // 기본값
		}
	}

	/* ���� ������ �̵� */
	@GetMapping("/modify")
	public String boardModifyGET(int board_no, Model model/* , Criteria cri */) {

		model.addAttribute("pageInfo", bservice.getPage(board_no));
//		model.addAttribute("cri", cri);
		return "board/modify";
	}

	/* ������ ���� */
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr, int category_no) {

		bservice.modify(board);

		rttr.addFlashAttribute("result", "modify success");

	
		switch (category_no) {
		case 1:
			return "redirect:/board/noticeboard";
		case 2:
			return "redirect:/board/freeboard";
		case 3:
			return "redirect:/board/qnaboard";
		default:
			return "redirect:/"; 
		}

	}

	@GetMapping("/board/qnaReply")
	public String qnaReply() {

		return "admin/board/qnaReply";
	}

	@GetMapping("/news/adminNews")
	public String adminNews() {

		return "admin/news/adminNews";
	}

	@GetMapping("/news/adminWrite")
	public String adminWrite() {

		return "admin/news/adminWrite";
	}

	@GetMapping("/mypage/main")
	public String main() {

		return "mypage/main";
	}

}