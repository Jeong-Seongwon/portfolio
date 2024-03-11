<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="../header.jsp" %>
<%
	String userId = null;
	if (user != null) {
		userId = user.getId();
	}
	if (userId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("history.back()");
		script.println("</script>");
	}
%>
<style>
    table.search_bar{
        border-collapse: collapse;
        width: 60%;
        margin: 0 auto;
        border-bottom: 0px;

        th, td {
        padding: 10px;
        font-size: 18px;
        }
    }
</style>

    <form name="searchForm" id="searchForm" action="search.jsp" method="get">
        <table class="search_bar">
            <tr>
                <th>
                <h2>EMP 정보</h2>
                </th>
                <td>
                    <select id="key" name="key">
                        <option value="all" selected>전체</option>
                        <option value="empno">EMPNO</option>
                        <option value="eid">EID</option>
                        <option value="ename">ENAME</option>
                        <option value="job">JOB</option>
                        <option value="deptno">DEPTNO</option>
                        <option value="gender">GENDER</option>
                    </select>
                    <input type="text" id="val" name="val" />
                    <input type="submit" value="검색" />
                    <input type='button' value='추가' onclick="window.location.href='insert.jsp'">
                </td>
            </tr>
        </table>
    </form>

