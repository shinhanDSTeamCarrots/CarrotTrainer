package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.stereotype.Service;

/* 
 * Service�� �߻����� ���Ǹ� �����ϴ� Ŭ�����̴�. �������̽� ����ü
 * Ŭ���̾�Ʈ ��û�� ó���ϰ� �ʿ��� ��� Mapper�� ȣ���� 
 * Service -> Mapper -> ServiceImpl   (SMS ��� ������ �ܿ�� ��������.)
 * 
 * */

@Service
public interface BoardService {
	
	/*�Խ��� ���*/
	public void enroll(BoardVO board);
	
	/* �Խ��� ���� */
    public int delete(int board_no);
    
	/*�Խ��� ��� */
	public List<BoardVO> getList();
	
	/*�Խ��� ��ȸ*/
	public BoardVO getPage(int board_no);
	
	 /* �Խ��� ���� */
    public int modify(BoardVO board);
    
    /* �Խ��� ���(����¡ ����) */
    public List<BoardVO> getListPaging(Criteria cri);
    
    /* �Խ��� �� ���� */
    public int getTotal(Criteria cri);
}
