package xyz.teamcarrot.myct.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.HashMap;


import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
			
			boolean isOwner = member.getMember_no() == board.getBoard_no();
			model.addAttribute("isOwnser", isOwner);
			model.addAttribute("loginMember", member);
		}

		return "board/freedetail";
	}
	
	// (관리자 페이지) 자유게시판 게시글 관리
	@GetMapping("/board/boardInfo")
	public String boardInfo(Model model,@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Criteria cri) {

		// 페이지 정보와 게시판 종류에 관한 Criteria 객체 생성
	    Criteria criteria = new Criteria(page, 10); // 페이지당 10개의 게시물

	    // 게시판 목록을 모델에 추가
	    List<BoardVO> qnaList = bservice.getListPaging(criteria);
	    model.addAttribute("page", qnaList);

	    // 전체 게시물 수를 기준으로 PageMakerDTO 객체 생성하여 모델에 추가
	    int total = bservice.getTotal(criteria);
	    PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);
	    model.addAttribute("pageMaker", pageMaker);

		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			model.addAttribute("member", member);
		}
		return "admin/board/boardInfo";
	}
	
	
	@GetMapping("/qnaboard")
	public String QnaboardList(Model model, 
	                           @RequestParam(value = "page", defaultValue = "1") int page,
	                           HttpSession session) {

	    // 페이지 정보와 게시판 종류에 관한 Criteria 객체 생성
	    Criteria criteria = new Criteria(page, 10); // 페이지당 10개의 게시물

	    // 게시판 목록을 모델에 추가
	    List<BoardVO> qnaList = bservice.getListPaging(criteria);
	    model.addAttribute("page", qnaList);

	    // 전체 게시물 수를 기준으로 PageMakerDTO 객체 생성하여 모델에 추가
	    int total = bservice.getTotal(criteria);
	    PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);
	    model.addAttribute("pageMaker", pageMaker);

	    // 기타 필요한 정보 (예: 현재 로그인한 사용자 정보)
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
	public String qna(Model model, @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "searchType", required = false) String searchType, HttpSession session, HttpServletRequest request) {
		log.info("QnaboardListGET");
		Criteria criteria = new Criteria(page, 10);

		List<BoardVO> notices = bservice.getListPaging(criteria);
	    int total = bservice.getTotal(criteria);

	    PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);

	    model.addAttribute("page", notices);
	    model.addAttribute("pageMaker", pageMaker);
		
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("member", member);
		}
		return "admin/board/qna";
	}
	

	@GetMapping("/noticeboard")
	public String noticeboard(Model model, 
	                          @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "searchType", required = false) String searchType,
	                          @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpSession session) {
	    Criteria criteria = new Criteria(page, 10);  // 10은 페이지당 게시물 수, 필요에 따라 조정 가능
	    
	
	    criteria.setSearchType(searchType);
	    criteria.setKeyword(searchKeyword);
	    
	    List<BoardVO> notices = bservice.getListPaging(criteria);
	    int total = bservice.getTotal(criteria);

	    PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);

	    model.addAttribute("page", notices);
	    model.addAttribute("pageMaker", pageMaker);
	    
	    MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			
			model.addAttribute("noticeMember", member);
		}

	    return "board/noticeboard";
	}


	
	// (관리자 페이지) 공지사항 게시글 관리 
	@GetMapping("/board/notice")
	public String notice(Model model, @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "searchType", required = false) String searchType, HttpSession session, HttpServletRequest request) {

		 Criteria criteria = new Criteria(page, 10); 
		 
		 List<BoardVO> notices = bservice.getListPaging(criteria);
		    int total = bservice.getTotal(criteria);

		    PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);

		    model.addAttribute("page", notices);
		    model.addAttribute("pageMaker", pageMaker);

		
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
	
	@PostMapping("/updatePrivate")
	@ResponseBody
	public String updatePrivate(@RequestParam("board_no") int board_no, @RequestParam("board_private") int board_private) {
		try {

			System.out.println("Updating board: " + board_no + " with private status: " + board_private);
			bservice.updatePrivateStatus(board_no, board_private);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@GetMapping("/write")
	public String boardEnrollGET() {

		log.info("�Խ��� ��� ������ ����");
		return "board/write";
	}
	

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
		case 4:
			return "redirect:/board/cardBoard";
		default:
			return "redirect:/";
		}
	}

	
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


	@GetMapping("/modify")
	public String boardModifyGET(int board_no, Model model/* , Criteria cri */) {

		model.addAttribute("pageInfo", bservice.getPage(board_no));
//		model.addAttribute("cri", cri);
		return "board/modify";
	}

	/* ������ ���� */
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr, int category_no) {

		int updateCount = bservice.modify(board);

	    if(updateCount > 0) {
	        rttr.addFlashAttribute("result", "modify success");
	    } else {
	        rttr.addFlashAttribute("result", "modifyFail");
	    }
	
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
	
	


	@GetMapping("/mypage/main")
	public String main() {

		return "mypage/main";
	}
	
	@GetMapping("/mypage/myComment")
	public String replyListGet(ReplyVO reply, Model model) {
		
		return "mypage/myCommnet";
	}

}