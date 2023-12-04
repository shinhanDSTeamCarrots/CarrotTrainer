/* Created:		23.12.01
 * Author:		전성욱
 * Description:	리뷰 mapper 선언
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewMapper {
	int insertReview(ReviewVO vo);
	void updateReview(ReviewVO vo);
	List<ReviewVO> selectReview(Map map);
	List<ReviewVO> selectReviewWithPage(int goods_no, int page);
	int deleteReview(int reviewno);
	int likeReview(@Param("review_no")int review_no, @Param("member_no")int member_no);
	int dislikeReview(@Param("review_no")int review_no, @Param("member_no")int member_no);
}
