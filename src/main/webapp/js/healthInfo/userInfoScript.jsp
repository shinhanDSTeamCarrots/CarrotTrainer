<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
//유저 name
$(function() {
	updateUserName();
	
    function updateUserName() {
    	const userName = "${sessionScope.loginInfo.member_nickname}";
    	if (userName) {	//로그인이 되어있을 때
    		$(".sql-text-name").text(userName);
      	} else {	//비로그인일 때
      		$(".sql-text-name").text("비회원");
      	}
    }
});