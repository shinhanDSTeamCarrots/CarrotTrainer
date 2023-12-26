	package xyz.teamcarrot.myct.board;

import java.util.Arrays;

public class Criteria {
	
	
	 private int page;  // 현재 페이지 번호

	    // 페이지 번호에 대한 getter
	    public int getPage() {
	        return page;
	    }

	    // 페이지 번호에 대한 setter
	    public void setPage(int page) {
	        this.page = page;
	    }

	    private String searchType;
	    private String searchKeyword;
	    
	    public String getSearchType() {
	        return searchType;
	    }

	    public void setSearchType(String searchType) {
	        this.searchType = searchType;
	    }
	
	
	 /* ���� ������ */
    private int pageNum;
    
    /* �� ������ �� ������ �Խù� ���� */
    private int amount;
    
    /* �˻� Ű���� */
    private String keyword;
    
    /* �˻� Ÿ�� */
    private String type;
    
    /* �˻� Ÿ�� �迭 */
    private String[] typeArr;
    
    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
		this.typeArr = type.split("");
	}

	public String[] getTypeArr() {
		return typeArr;
	}

	public void setTypeArr(String[] typeArr) {
		this.typeArr = typeArr;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	/* ��ŵ �� �Խù� ��( (pageNum-1) * amount ) */
    private int skip;
    
    /* �⺻ ������ -> �⺾ ���� : pageNum = 1, amount = 10 */
    public Criteria() {
        this(1,10);
        this.skip = 0;
    }
    
    /* ������ => ���ϴ� pageNum, ���ϴ� amount */
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
        this.skip = (pageNum-1)*amount;
    }
    
   

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.skip=(pageNum-1)*this.amount;
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.skip = (this.pageNum-1)*amount;
		this.amount = amount;
	}

	public int getSkip() {
		return skip;
	}

	public void setSkip(int skip) {
		this.skip = skip;
	}

	 @Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", keyword=" + keyword + ", type=" + type
				+ ", typeArr=" + Arrays.toString(typeArr) + ", skip=" + skip + "]";
	}

}
