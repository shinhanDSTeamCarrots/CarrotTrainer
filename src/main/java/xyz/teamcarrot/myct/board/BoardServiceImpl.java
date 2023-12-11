package xyz.teamcarrot.myct.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	
	/* Autowired�� ������ Ŭ����(BoardMapper)�� ��(Bean)�� �ڵ����� ��������
	 * �����������̳��� �� �����̳ʿ� �������شٴ� ��
	 * ��, �������� �˾Ƽ� �������� ������ ���ش�. DI�� ���⼭ ����
	 * Autowired�� ��������ν� �ڵ��� ���յ��� ���߰� �������� ���� �� ����
	 * */
	
	/* ��(Bean)�� ���� ���ؼ� Ŭ������ ��ü�̴�
	 * �������� ���� �ν��Ͻ�ȭ, ���� �ȴ�.
	 * impl�� �������̽� ���� ��ü�̴�.
	 * */
	@Autowired
	private BoardMapper mapper;
	
	/* �Խ��� ��� */
	@Override
	public void enroll(BoardVO board) {
		mapper.enroll(board);

	}
	
	/* �Խ��� ���� */
    @Override
    public int delete(int board_no) {
        
        return mapper.delete(board_no);
    }    
	
	/*�Խ��� ���*/
	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}
	
	/*�Խ��� ��ȸ*/
	@Override
	public BoardVO getPage(int board_no) {
			
		return mapper.getPage(board_no);
	}
	
	 /* �Խ��� ���� */
    @Override
    public int modify(BoardVO board) {
        
        return mapper.modify(board);
    }
    
    /* �Խ��� ���(����¡ ����) */
    @Override
    public List<BoardVO> getListPaging(Criteria cri) {
        
        return mapper.getListPaging(cri);
    }    
    
    /* �Խù� �� ���� */
    @Override
    public int getTotal(Criteria cri) {
        
        return mapper.getTotal(cri);
    }    
}
