/* Created:		23.12.01
 * Author:		전성욱
 * Description:	리뷰 mapper <-> 컨트롤러 연결
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */

package xyz.teamcarrot.myct.review;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewMapper mapper;
	
	@Autowired
	ReviewLikeMapper likeMapper;

	
	/* 리뷰 추가
	 * @param: 생성한 ReviewVO
	 * @return: 추가한 Review 의 review_no 
	 */
	@Override
	public int insertReview(ReviewVO vo) {
		//동시에 상품에서도 update
		return mapper.insertReview(vo);
	}

	/* 리뷰 수정
	 * @param: 수정한 ReviewVO
	 * @return: 수정한 Review 의 review_no 
	 */
	@Override
	public int updateReview(ReviewVO vo) {
		//동시에 상품에서도 update
		mapper.updateReview(vo);
		return vo.getReview_no();
	}

	/* 리뷰 리스트
	 * @param goods_no	지정 상품
	 * @param page		특정 page. default 1
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
		//로그인 상태면
		if(0==0) {
			hashmap.put("self_no",0);
		}
		else {
			//로그인 안 된 상태면
			hashmap.put("self_no",null);
		}
		//서치타입이 member_search면 특정 id 검색
		//goods_search이면 기본 검색
		hashmap.put("searchType", "goods_search");
		hashmap.put("alignType", "like_desc");
		hashmap.put("page",page-1);
		return mapper.selectReview(hashmap);
	}

	/* 리뷰 삭제
	 * @param 삭제할 리뷰 번호
	 * @return: 삭제한 review no
	 */
	@Override
	public int deleteReview(int review_no) {
		mapper.deleteReview(review_no);
		return review_no;
	}

	/* 리뷰 좋아요
	 * @param review_no		좋아요 한 리뷰
	 * @param member_no		좋아요한 멤버
	 */
	@Override
	public void likeReview(int review_no, int member_no) {
		likeMapper.insertReviewLike(member_no, review_no);
		mapper.likeReview(review_no, member_no);
	}

	/* 리뷰 좋아요 취소
	 * @param review_no		좋아요한 리뷰
	 * @param member_no		좋아요한 멤버
	 */
	@Override
	public void dislikeReview(int review_no, int member_no) {
		likeMapper.deleteReviewLike(member_no, review_no);
		mapper.dislikeReview(review_no, member_no);
	}

}
