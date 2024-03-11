<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="main.jsp" %>

<%
    int empno = Integer.parseInt(request.getParameter("empno"));
	
	EmpDAO dao = new EmpDAO();
	int res = dao.deleteEmp(empno);
	
	if (res > 0) {
        out.print("<script>alert('삭제가 완료되었습니다.'); window.location.href='index.jsp';</script>");
    } else {
        out.print("<script>alert('삭제 실패했습니다.'); window.location.href='index.jsp';</script>");
    }
%>

</body>
</html>