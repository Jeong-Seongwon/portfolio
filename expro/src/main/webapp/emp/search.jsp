<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="main.jsp" %>

<style>
    table.searchEmp {
    width: 60%;
    border-collapse: collapse;
    margin: 0 auto;
    
    th, td {
        height: 30px;
        border-bottom: 1px solid #444444;
        padding: 10px;
        font-size: 15px;
        }
    }
</style>

<%
		String key = null;
		if (request.getParameter("key") != null) {
			key = request.getParameter("key");
		}
	    String val = null;
	    if (request.getParameter("val") != null) {
			val = request.getParameter("val");
		}
%>

	<table class="searchEmp">
		<thead>
			<tr>
				<th>EMPNO</th>
				<th>ENAME</th>
				<th>JOB</th>
				<th>HIREDATE</th>
				<th>DEPTNO</th>
				<th>EID</th>
			</tr>
		</thead>
		<tbody>	
			<%
				EmpDAO dao = new EmpDAO();
				ArrayList<EmpVO> list = dao.searchEmp(key, val);
				
				for (int i = 0; i < list.size(); i++) {
			%>
			<tr>
				<td><%= list.get(i).getEmpno() %></td>
				<td><a href="edit.jsp?empno=<%= list.get(i).getEmpno() %>"><%= list.get(i).getEname() %></a></td>
				<td><%= list.get(i).getJob() %></td>
				<td><%= list.get(i).getHiredate().substring(0, 11) %></td>
				<td><%= list.get(i).getDeptno() %></td>
				<td><%= list.get(i).getEid() %></td>
			</tr>
			<%		
				}
			%>
			
		</tbody>
	</table>


<%@ include file="../foot.jsp" %>
</body>
</html>
