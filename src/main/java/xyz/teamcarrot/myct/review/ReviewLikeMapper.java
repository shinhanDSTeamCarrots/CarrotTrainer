/* Created:		23.12.01
 * Author:		������
 * Description:	�������ƿ� mapper ����
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewLikeMapper {
	void insertReviewLike(@Param("member_no") int member_no,@Param("review_no") int review_no);
	void deleteReviewLike(@Param("member_no")int member_no, @Param("review_no") int review_no);
}
