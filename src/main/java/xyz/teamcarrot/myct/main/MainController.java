
package xyz.teamcarrot.myct.main;

import java.lang.System.Logger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.cj.log.Log;

import lombok.extern.slf4j.Slf4j;
import xyz.teamcarrot.myct.board.BoardService;
import xyz.teamcarrot.myct.board.BoardVO;
import xyz.teamcarrot.myct.board.Criteria;
import xyz.teamcarrot.myct.goods.GoodsService;
import xyz.teamcarrot.myct.goods.GoodsVO;
@Slf4j
@Controller
public class MainController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	GoodsService goodsService;
	
	
	@GetMapping("/")
	public ModelAndView mainTop() {
		ModelAndView mav = new ModelAndView();
		
		//메인페이지 정보 1
		//공지사항 글 리스트
		Criteria criteria = new Criteria(1, 10);
		criteria.setKeyword("");
		criteria.setType("T");
		List<BoardVO> notices = boardService.getListPaging(criteria, 1);
		mav.addObject("noticeList", notices);
		log.info("===========================================================");
		//메인페이지 정보 2
		//상품 정보
		List<GoodsVO> hotGoodsList = goodsService.hotGoodsList();
		mav.addObject("hotGoodsList",hotGoodsList );
		
		//메인페이지 정보 3
		//자유게시판 정보
		log.info("===========================================================");
		List<BoardVO> hotBoardList = boardService.getListPaging();
		mav.addObject("hotBoardList",hotBoardList);
		
		mav.setViewName("home");
		return mav;
	}
}
