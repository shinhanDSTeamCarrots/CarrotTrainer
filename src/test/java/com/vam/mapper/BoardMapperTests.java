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
     
     /* �Խ��� ��� �׽�Ʈ */
     @Test
     public void testEnroll() {
         
         BoardVO vo = new BoardVO();
         
         vo.setBoard_title("mapper test");
         vo.setBoard_content("mapper test");
         vo.setCategory_no(1);
         vo.setMember_no(1);
         
         mapper.enroll(vo);
         
     }
     
     /* �Խ��� ��� �׽�Ʈ */
     @Test
     public void testGetList() {

         List list = mapper.getList();       
        /* foreach�� & ���ٽ� */
         list.forEach(board -> log.info("" + board));
         
     }
     
     /* �Խ��� ��ȸ */
     @Test
     public void testGetPage() {
    	 /*���� �����ϴ� ������ */
    	 int bno = 48;
    	 log.info("" + mapper.getPage(bno));
     }
     
     /* �Խ��� ���� */
     @Test
     public void testModify() {
    	 BoardVO board = new BoardVO();
    	 board.setBoard_no(8);
    	 board.setBoard_title("���� ����");
    	 board.setBoard_content("���� ����");
    	 
    	 int result = mapper.modify(board);
    	 log.info("result : "+result);
     }
     
     /* �Խ��� ���� */
     @Test
     public void testDelete() {
         
         int result = mapper.delete(23);
         log.info("result : " + result);
         
     }
}