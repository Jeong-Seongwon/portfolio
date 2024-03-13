<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page import="java.util.*" %>

<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

    <%
        user.setPassword(request.getParameter("password"));
        user.setName(request.getParameter("name"));
        user.setBirth(request.getParameter("birth"));
        user.setGender(request.getParameter("gender"));
        user.setEmail(request.getParameter("email"));

        UserDAO dao = UserDAO.getInstance();
        int res = dao.updateUser(user);

            if (res > 0) {
                out.print("<script>alert('회원 정보 수정에 성공했습니다.'); window.location.href='index.jsp';</script>");
            } else {
                out.print("<script>alert('회원 정보 수정에 실패했습니다.'); history.back();</script>");
            }
	%>
	
</body>
</html>
