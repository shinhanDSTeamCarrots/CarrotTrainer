/* Created:		23.12.01
 * Author:		전성욱
 * Description:	리뷰 mapper <-> 컨트롤러 연결
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.util.List;

public interface ReviewService {
	int insertReview(ReviewVO vo);
	int updateReview(ReviewVO vo);
	List<ReviewVO> selectReview(int goods_no, int page);
	int deleteReview(int reviewno);
	void likeReview(int review_no, int member_no);
	void dislikeReview(int review_no, int member_no);
}
