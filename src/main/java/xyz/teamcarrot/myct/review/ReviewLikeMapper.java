/* Created:		23.12.01
 * Author:		������
 * Description:	�������ƿ� mapper ����
 * Edited:		-
 * (c) Copyright by TeamCarrot
 */
package xyz.teamcarrot.myct.review;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewLikeMapper {
	void insertReviewLike(int member_no,int review_no);
	void deleteReviewLike(int member_no, int review_no);
}
