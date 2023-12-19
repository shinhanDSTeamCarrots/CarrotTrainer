	package xyz.teamcarrot.myct.board;

import java.util.HashMap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
	


	/* �Խ��� ��� ������ ����(����¡ ����) */
	@GetMapping("/freeboard.do")
	public String boardListGET(Model model, Criteria cri,  HttpServletRequest request, HttpSession session) {
		
		log.info("freeboardListGET");

		
		model.addAttribute("list", bservice.getListPaging(cri));
		int total = bservice.getTotal(cri);	

		PageMakerDTO pageMake = new PageMakerDTO(cri, total);
		model.addAttribute("pageMaker", pageMake);
		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if(member != null) {
			model.addAttribute("member", member);
		}
		return "board/freeboard";
	}
	
	/* �����Խ��� ��ȸ */
	@GetMapping("/freedetail.do")
	public String boardGetPageGET(int board_no, Model model, HttpSession session , Criteria cri ) {
		BoardVO board = bservice.getPage(board_no);
		log.info("test: " + board.getBoard_no());
		 model.addAttribute("cri", cri);
		 model.addAttribute("pageInfo", board);

		 	int result = bservice.updateRecomCount(board_no);
		 	model.addAttribute("resultList", result);
		 	
	        // 해당 게시글의 답글 목록 조회
	        List<ReplyVO> replies = bservice.getReplies(board_no);
	        model.addAttribute("replyList", replies);
	    
	        // 로그인한 사용자 정보 확인
	        MemberVO member = (MemberVO) session.getAttribute("loginInfo");
	        if (member != null) {
	            // 로그인한 사용자 정보를 모델에 추가
	            model.addAttribute("loginMember", member);
	        }

		return "board/freedetail";
	}
			
	@GetMapping("/qnaboard.do")
	public String QnaboardList(Model model, HttpSession session, HttpServletRequest request) {
	    log.info("QnaboardListGET");
	   

	    // 게시판 목록을 모델에 추가
	    model.addAttribute("page", bservice.getList());

	    // 로그인한 사용자의 정보가 세션에 있는지 확인
	    MemberVO member = (MemberVO) session.getAttribute("loginInfo");
	    if (member != null) {
	        // 로그인한 상태인 경우, 모델에 로그인 정보 추가
	        model.addAttribute("member", member);
	    }

	    return "board/Qnaboard";
	}
	
	// 게시글 상세 페이지와 답글 목록을 조회하는 메서드
    @GetMapping("/Qnadetail.do")
    public String boardDetail(int board_no, Model model, HttpSession session) {
        // 게시글 상세 정보 조회
        BoardVO board = bservice.getPage(board_no);
        model.addAttribute("pageInfo", board);
     
        // 해당 게시글의 답글 목록 조회
        List<ReplyVO> replies = bservice.getReplies(board_no);
        model.addAttribute("replyList", replies);

        // 로그인한 사용자 정보 확인
        MemberVO member = (MemberVO) session.getAttribute("loginInfo");
        if (member != null) {
            // 로그인한 사용자 정보를 모델에 추가
            model.addAttribute("loginMember", member);
        }

        return "board/Qnadetail";
    }
    
    @GetMapping("/noticeboard.do")
	public String noticeboard(Model model, HttpSession session, HttpServletRequest request) {
    	
    	// 게시판 목록을 모델에 추가
	    model.addAttribute("page", bservice.getList());

	    // 로그인한 사용자의 정보가 세션에 있는지 확인
	    MemberVO member = (MemberVO) session.getAttribute("loginInfo");
	    if (member != null) {
	        // 로그인한 상태인 경우, 모델에 로그인 정보 추가
	        model.addAttribute("noticeMember", member);
	    }
		return "board/noticeboard";
	}
    
    @GetMapping("/board/notice.do")
	public String notice( Model model, HttpSession session, HttpServletRequest request ) {
		
	
		// 게시판 목록을 모델에 추가
	    model.addAttribute("page", bservice.getList());
		
		 // 로그인한 사용자의 정보가 세션에 있는지 확인
	    MemberVO member = (MemberVO) session.getAttribute("loginInfo");
	    if (member != null) {
	        // 로그인한 상태인 경우, 모델에 로그인 정보 추가
	        model.addAttribute("adminMember", member);
	    }
		
		return "admin/board/notice";
	}
	
	@GetMapping("/board/noticeWrite.do")
	public String noticeWrite() {
		
		return "admin/board/noticeWrite";
	}
    
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
	
	@PostMapping("/insertReply.do")
	@ResponseBody
	public String insertReply(ReplyVO reply, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("loginInfo");
	
	    if (member != null) {
	        // setMember_no()를 사용하여 회원 번호를 설정
	        reply.setMember_no(member.getMember_no());
	        
	        
	        
	        log.info("댓글 등록을 시도합니다. 댓글 내용: {}", reply.getReply_content()); // 댓글 등록 시도 로그
            int replyresult = bservice.insertReply(reply);
            log.info("댓글 등록 결과: {}", replyresult > 0 ? "성공" : "실패"); // 댓글 등록 결과 로그
          
	        return replyresult > 0 ? "success" : "fail";
	    }

	    return "notLoggedIn"; // 로그인하지 않은 사용자에 대한 처리
	}


	 // 특정 게시글의 댓글 목록을 반환하는 메서드
    @GetMapping("/getReplies.do")
    @ResponseBody
    public List<ReplyVO> getRepliesForBoard(@RequestParam("board_no") int boardNo) {
        return bservice.getReplies(boardNo);
    }

	@GetMapping("/qnareply.do")
	public String Qnareply(Model model) {
		return "board/Qnareply";
	}

		
						

	/* �Խ��� ��� ������ ���� */
	@GetMapping("/write.do")
	public String boardEnrollGET() {

		log.info("�Խ��� ��� ������ ����");
		return "board/write";
	}

	/* �Խ��� ��� */
	@PostMapping("/insert.do")
	public String boardEnrollPOST(
			@RequestParam("file") MultipartFile file,  HttpSession session, BoardVO board, RedirectAttributes rttr, HttpServletRequest request) {
		
		log.info("BoardVO : " + board);
		session = request.getSession();
		MemberVO login = (MemberVO)session.getAttribute("loginInfo");
		board.setMember_no(login.getMember_no());

		bservice.enroll(board, file, request);
		rttr.addFlashAttribute("result", "enrol success");
	    switch (board.getCategory_no()) {
	        case 1:
	            return "redirect:/board/noticeboard.do";
	        case 2:
	            return "redirect:/board/freeboard.do";
	        case 3:
	            return "redirect:/board/qnaboard.do";
	        default:
	            return "redirect:/";
	    }
	}	

	/* ������ ���� */
	@PostMapping("/delete.do")
	public String boardDeletePOST(int board_no, int category_no, RedirectAttributes rttr) {
	    bservice.delete(board_no);
	    rttr.addFlashAttribute("result", "delete success");

	    // category_no에 따른 리디렉션 처리
	    switch (category_no) {
	        case 1:
	            return "redirect:/board/noticeboard.do";
	        case 2:
	            return "redirect:/board/freeboard.do";
	        case 3:
	            return "redirect:/board/qnaboard.do";
	        default:
	            return "redirect:/"; // 기본값
	    }
	}

	/* ���� ������ �̵� */
	@GetMapping("/modify.do")
	public String boardModifyGET(int board_no, Model model/* , Criteria cri */) {

		model.addAttribute("pageInfo", bservice.getPage(board_no));
//		model.addAttribute("cri", cri);
		return "board/modify";
	}

	/* ������ ���� */
	@PostMapping("/modify.do")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {

		bservice.modify(board);

		rttr.addFlashAttribute("result", "modify success");

		return "redirect:/board/freeboard.do";

	}
	
	@GetMapping("/board/boardInfo.do")
	public String boardInfo() {
		
		return "admin/board/boardInfo";
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