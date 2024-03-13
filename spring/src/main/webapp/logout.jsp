<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // 이미 선언된 session 객체 사용
    session = request.getSession(false); // 새 세션 생성 안 함
    if(session != null) {
        session.invalidate(); // 세션 무효화
    }
    
    // 로그아웃 후 메인 페이지로 리다이렉트
    response.sendRedirect("index.jsp");
%>