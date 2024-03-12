<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import ='user.*' %>

<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

<%
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    
    UserDAO dao = UserDAO.getInstance();
    user = dao.loginUser(id, password);

    if(user.getId()==null){
	    // 로그인 실패
	    out.print("<script>alert('아이디 혹은 비밀번호를 확인해주세요.'); history.back();</script>");
    } else {
        session.setAttribute("user", user);
	    response.sendRedirect("index.jsp");
    }
%>

</body>
</html>