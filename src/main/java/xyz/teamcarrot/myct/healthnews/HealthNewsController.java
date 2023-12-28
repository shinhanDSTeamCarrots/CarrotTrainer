package xyz.teamcarrot.myct.healthnews;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.board.BoardController;
import xyz.teamcarrot.myct.board.BoardFileVO;
import xyz.teamcarrot.myct.board.BoardService;
import xyz.teamcarrot.myct.board.BoardVO;
import xyz.teamcarrot.myct.board.Criteria;
import xyz.teamcarrot.myct.board.PageMakerDTO;
import xyz.teamcarrot.myct.member.MemberService;
import xyz.teamcarrot.myct.member.MemberVO;
import xyz.teamcarrot.myct.review.ReviewController;

@Controller
@Slf4j
@RequestMapping("/healthnews/*")
public class HealthNewsController {

	@Autowired
	private HealthNewsService hservice;
	@Autowired
	private BoardService bservice;
	@Autowired
	private MemberService mservcie;

	@PostMapping("/uploadFile.do")
	public String uploadFile(@ModelAttribute("vo") BoardFileVO vo, HttpServletRequest request) {
		try {
			// 파일 처리 로직
			MultipartFile file = vo.getUploadFile();
			if (!file.isEmpty()) {
				String uploadsDir = "/img/news/";
				String realPathToUploads = request.getServletContext().getRealPath(uploadsDir);

				File dir = new File(realPathToUploads);
				if (!dir.exists()) {
					dir.mkdirs();
				}

				String orgName = file.getOriginalFilename();
				String filePath = Paths.get(realPathToUploads, orgName).toString();
				File dest = new File(filePath);
				file.transferTo(dest);

				// 파일 정보를 데이터베이스에 저장
				BoardFileVO fileVO = new BoardFileVO();
				fileVO.setFileName(orgName); // 원본 파일명 저장
				fileVO.setFile_name(realPathToUploads); // 파일 경로 저장
				// 여기서는 파일 경로를 저장하지만, 실제로는 파일의 URL이나 식별자를 저장할 수 있음.
				hservice.saveFile(fileVO); // 서비스를 통해 파일 정보 저장
			}
			// 성공적으로 파일 업로드 후 리다이렉션
			return "redirect:/healthnews/cardBoard";
		} catch (Exception e) {
			e.printStackTrace();
			// 에러 처리 및 리다이렉션
			return "redirect:/healthnews/write";
		}
	}

	@PostMapping("/uploadImages")
	public String upload(BoardFileVO vo, Model model, @RequestParam("pics") MultipartFile[] pics,
			HttpServletRequest request) {
		String path = "C:\\upload"; // 로컬 저장소 경로
		List<String> fileNames = new ArrayList<>();

		for (MultipartFile file : pics) {
			if (!file.isEmpty()) {
				try {
					String originalFilename = file.getOriginalFilename();
					String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
					String storedFilename = UUID.randomUUID().toString().substring(0, 8) + extension;

					File sfile = new File(path + '\\' + storedFilename);
					file.transferTo(sfile);
					fileNames.add(storedFilename); // 파일명을 리스트에 추가

				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}

		model.addAttribute("fileNames", fileNames); // 파일명 리스트 모델에 추가
		return "redirect:/healthnews/cardRead"; // 이미지를 불러올 페이지로 리다이렉트
	}

	// 메인 페이지
	@GetMapping("/cardboard")
	public String cardboard(Model model, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpSession session) {
		int category_no = 4;

		Criteria criteria = new Criteria(page, 10);
		criteria.setKeyword(searchKeyword);
		criteria.setType("T");
		List<BoardVO> qnaList = bservice.getListPaging(criteria, category_no);
		model.addAttribute("page", qnaList);

		int total = bservice.getTotal(criteria);
		PageMakerDTO pageMaker = new PageMakerDTO(criteria, total);
		model.addAttribute("pageMaker", pageMaker);

		// 기타 필요한 정보 (예: 현재 로그인한 사용자 정보)
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		if (member != null) {
			model.addAttribute("member", member);
		}

		return "news/cardBoard";
	}

	// 관리자 페이지
	@GetMapping("/adminNews")
	public String adminNews() {

		return "admin/healthnews/adminNews";
	}

	@GetMapping("/adminWrite")
	public String adminWrite() {

		return "admin/healthnews/adminWrite";
	}

	/*
	 * @GetMapping("/cardRead") public String cardReadDetail(Model model, int
	 * board_no) {
	 * 
	 * BoardVO board = bservice.getPage(board_no); model.addAttribute("pageInfo",
	 * board); return "news/cardRead"; }
	 */

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

	@GetMapping("/cardwrite")
	public String cardwrite() {
		return "news/cardWrite";
	}

	@GetMapping("/write")
	public String boardEnrollGET() {
		return "board/write";
	}

	@GetMapping("/cardRead")
	public String cardReadDetail(Model model,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		int category_no = 4;

		Criteria criteria = new Criteria(page, 10);
		criteria.setKeyword(searchKeyword);
		criteria.setType("T");
		List<BoardVO> qnaList = bservice.getListPaging(criteria, category_no);
		model.addAttribute("page", qnaList);
		return "news/cardRead";
	}

	@GetMapping("/cardRead2")
	public String cardReadDetail2(Model model) {

		return "news/cardRead2";
	}

	@GetMapping("/cardRead3")
	public String cardReadDetail3(Model model) {

		return "news/cardRead3";
	}
}
