/* Created:		23.12.01
 * Author:		������
 * Description:	���� mapper <-> ��Ʈ�ѷ� ����
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */

package xyz.teamcarrot.myct.review;

import java.util.HashMap;
import java.util.List;

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
	public List<ReviewVO> selectReview(int goods_no, int page) {
		/*if(page == 1) {
			return mapper.selectReview(goods_no);
		}
		else {
			return mapper.selectReviewWithPage(goods_no, page);
		}*/
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("goods_no", goods_no);
		//�α��� ���¸�
		if(0==0) {
			hashmap.put("self_no",0);
		}
		else {
			//�α��� �� �� ���¸�
			hashmap.put("self_no",null);
		}
		//��ġŸ���� member_search�� Ư�� id �˻�
		//goods_search�̸� �⺻ �˻�
		hashmap.put("searchType", "goods_search");
		hashmap.put("alignType", "like_desc");
		hashmap.put("page",page-1);
		return mapper.selectReview(hashmap);
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
	public void likeReview(int review_no, int member_no) {
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

}
