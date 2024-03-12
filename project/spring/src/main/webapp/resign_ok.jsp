<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>

<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

<%
    UserDAO dao = UserDAO.getInstance();
	int res = dao.resignUser(user);

        if (res > 0) {
            response.sendRedirect("logout.jsp");
        } else {
            out.print("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
        }
%>