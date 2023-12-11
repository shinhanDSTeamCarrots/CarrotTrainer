package xyz.teamcarrot.myct.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	/*�Խ��� ���*/
	public void enroll(BoardVO board);
	
	/* �Խ��� ���� */
    public int delete(int board_no);
	
	/*�Խ��� ���*/
	public List<BoardVO> getList();

	/* �Խ��� ���(����¡ ����) 
	 * List�� ������ ������ �迭�� ��� ũ�Ⱑ 10���� �������ٸ�, 10���� �ʰ��ϴ� ���� ���� �� ���µ�
	 * List�� 10���� ũ��� �����ص� 11��° ���� ������ �� �������� �� ũ�Ⱑ Ŀ����.*/
    public List<BoardVO> getListPaging(Criteria cri);
	
	/*�Խ��� ��ȸ*/
	public BoardVO getPage(int board_no);
	
	/*�Խ��� ����*/
	public int modify(BoardVO board);	
	
    /* �Խ��� �� ���� */
    public int getTotal(Criteria cri);
    
    
}
