package xyz.teamcarrot.myct.healthnews;

import java.io.File;
import java.nio.file.Paths;
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

import xyz.teamcarrot.myct.board.BoardController;
import xyz.teamcarrot.myct.board.BoardFileVO;
import xyz.teamcarrot.myct.board.BoardService;
import xyz.teamcarrot.myct.board.BoardVO;
import xyz.teamcarrot.myct.member.MemberService;
import xyz.teamcarrot.myct.member.MemberVO;

@Controller
@RequestMapping("/healthnews/*")
public class HealthNewsController {

	@Autowired
    private HealthNewsService hservice;
	@Autowired
	private BoardService bservice;
	@Autowired
	private MemberService mservcie;
	
	private static final Logger log = LoggerFactory.getLogger(HealthNewsController.class);
	
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


	// 메인 페이지
	@GetMapping("/cardboard")
	public String cardboard(Model model) {
		
		model.addAttribute("page", bservice.getList());
		
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

	@GetMapping("/cardRead")
	public String cardReadDetail() {
		return "news/cardRead";
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


	@GetMapping("/write")
	public String boardEnrollGET() {
		return "board/write";
	}
}
