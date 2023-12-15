/* Created:		23.12.01
 * Author:		������
 * Description:	���� mapper <-> ��Ʈ�ѷ� ����
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */

package xyz.teamcarrot.myct.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewMapper mapper;
	
	@Autowired
	ReviewLikeMapper likeMapper;

	
	/* ���� �߰�
	 * @param: ������ ReviewVO
	 * @return: �߰��� Review �� review_no 
	 */
	@Override
	public int insertReview(ReviewVO vo) {
		//���ÿ� ��ǰ������ update
		int res =  mapper.insertReview(vo);
		mapper.goodsTableUpdate(vo.getGoods_no());
		return res;
	}

	/* ���� ����
	 * @param: ������ ReviewVO
	 * @return: ������ Review �� review_no 
	 */
	@Override
	public int updateReview(ReviewVO vo) {
		//���ÿ� ��ǰ������ update
		mapper.updateReview(vo);
		mapper.goodsTableUpdate(vo.getGoods_no());
		return vo.getReview_no();
	}

	/* ���� ����Ʈ
	 * @param goods_no	���� ��ǰ
	 * @param page		Ư�� page. default 1
	 * @return: review list
	 */
	@Override
	public List<ReviewVO> selectReview(Map<String,Object>map) {

		return mapper.selectReview(map);
	}

	/* ���� ����
	 * @param ������ ���� ��ȣ
	 * @return: ������ review no
	 */
	@Override
	public int deleteReview(int review_no) {
		mapper.deleteReview(review_no);
		//mapper.goodsTableUpdate(goods_no);
		return review_no;
	}

	/* ���� ���ƿ�
	 * @param review_no		���ƿ� �� ����
	 * @param member_no		���ƿ��� ���
	 */
	@Override
	public void likeReview(int review_no, int member_no)throws org.springframework.dao.DuplicateKeyException {
		likeMapper.insertReviewLike(member_no, review_no);
		mapper.likeReview(review_no, member_no);
	}

	/* ���� ���ƿ� ���
	 * @param review_no		���ƿ��� ����
	 * @param member_no		���ƿ��� ���
	 */
	@Override
	public void dislikeReview(int review_no, int member_no) {
		likeMapper.deleteReviewLike(member_no, review_no);
		mapper.dislikeReview(review_no, member_no);
	}
	@Override
	public Map<String,Object> selectData(int goods_no){
		return mapper.selectListData(goods_no);
	}

	@Override
	public ReviewVO getSpecificReview(int review_no) {
		return mapper.getSpecificReview(review_no);
	}

}
