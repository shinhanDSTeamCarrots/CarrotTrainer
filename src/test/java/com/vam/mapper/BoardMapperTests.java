package com.vam.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import xyz.teamcarrot.myct.board.BoardMapper;
import xyz.teamcarrot.myct.board.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {xyz.teamcarrot.myct.config.MvcConfig.class})
@WebAppConfiguration
public class BoardMapperTests {
 
     private static final Logger log = LoggerFactory.getLogger(BoardMapperTests.class);
     
     @Autowired
     private BoardMapper mapper;
     
     /* 게시판 등록 테스트 */
     @Test
     public void testEnroll() {
         
         BoardVO vo = new BoardVO();
         
         vo.setBoard_title("mapper test");
         vo.setBoard_content("mapper test");
         vo.setCategory_no(1);
         vo.setMember_no(1);
         
         mapper.enroll(vo);
         
     }
     
     /* 게시판 목록 테스트 */
     @Test
     public void testGetList() {

         List list = mapper.getList();       
        /* foreach문 & 람다식 */
         list.forEach(board -> log.info("" + board));
         
     }
     
     /* 게시판 조회 */
     @Test
     public void testGetPage() {
    	 /*실제 존재하는 페이지 */
    	 int bno = 48;
    	 log.info("" + mapper.getPage(bno));
     }
     
     /* 게시판 수정 */
     @Test
     public void testModify() {
    	 BoardVO board = new BoardVO();
    	 board.setBoard_no(8);
    	 board.setBoard_title("수정 제목");
    	 board.setBoard_content("수정 내용");
    	 
    	 int result = mapper.modify(board);
    	 log.info("result : "+result);
     }
     
     /* 게시판 삭제 */
     @Test
     public void testDelete() {
         
         int result = mapper.delete(23);
         log.info("result : " + result);
         
     }
}