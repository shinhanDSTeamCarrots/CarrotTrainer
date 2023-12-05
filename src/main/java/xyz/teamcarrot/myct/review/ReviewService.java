/* Created:		23.12.01
 * Author:		������
 * Description:	���� mapper <-> ��Ʈ�ѷ� ����
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
@Service
public interface ReviewService {
	Map<String,Object> selectData(int goods_no);
	int insertReview(ReviewVO vo);
	int updateReview(ReviewVO vo);
	List<ReviewVO> selectReview(int goods_no, int self_no, int page);
	int deleteReview(int reviewno);
	void likeReview(int review_no, int member_no);
	void dislikeReview(int review_no, int member_no);
}
