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
    	UserVO vo = new UserVO();
    
        vo.setId(request.getParameter("id"));
        vo.setPassword(request.getParameter("password"));
        vo.setName(request.getParameter("name"));
        vo.setBirth(request.getParameter("birth"));
        vo.setGender(request.getParameter("gender"));
        vo.setEmail(request.getParameter("email"));

        UserDAO dao = UserDAO.getInstance();
        int res = dao.signupUser(vo);
        
        if (res == -1) {
        	out.print("<script>alert('이미 사용 중인 아이디입니다.'); history.back();</script>");
        } else {
        	out.print("<script>alert('회원 가입에 성공했습니다.'); window.location.href='index.jsp';</script>");
        }
        
        
    %>

</body>
</html>