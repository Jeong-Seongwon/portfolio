<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="main.jsp" %>

<%
	EmpVO vo = new EmpVO();

	vo.setEmpno(Integer.parseInt(request.getParameter("empno")));
	vo.setEid(request.getParameter("eid"));
	vo.setPwd(request.getParameter("pwd"));
	vo.setEname(request.getParameter("ename"));
	vo.setJob(request.getParameter("job"));
	vo.setMgr(Integer.parseInt(request.getParameter("mgr")));
	vo.setHiredate(request.getParameter("hiredate"));
	vo.setSal(Float.parseFloat(request.getParameter("sal")));
	vo.setComm(Float.parseFloat(request.getParameter("comm")));
	vo.setDeptno(Integer.parseInt(request.getParameter("deptno")));
	vo.setGender(request.getParameter("gender"));
	String[] hobbies = request.getParameterValues("hobby");
	if (hobbies != null && hobbies.length > 0) {
	    StringJoiner hobbyJoiner = new StringJoiner(",");
	    for (String s : hobbies) {
	        hobbyJoiner.add(s);
	    }
	    vo.setHobby(hobbyJoiner.toString());
	} else {
	    vo.setHobby(""); // 취미가 없는 경우 기본값 설정
	}
	
	EmpDAO dao = new EmpDAO();
	int res = dao.updateEmp(vo);
	if (res > 0) {
        out.print("<script>alert('수정이 완료되었습니다.'); window.location.href='index.jsp';</script>");
    } else {
        out.print("<script>alert('수정 실패했습니다.'); window.location.href='index.jsp';</script>");
    }
%>


</body>
</html>