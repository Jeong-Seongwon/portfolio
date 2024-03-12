<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.*" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

	<% 
		String userID = null;
		if (user != null) {
			userID = user.getId();
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
	%>

<style>
	table.bbs_update {
		width:80%;
		margin:auto;
		text-align: center;
		border: 1px solid #dddddd;
	}
	input[type="text"] {
        width: 100%; /* 너비 조절 */
		font-size: 20px;
    }
    textarea {
        width: 100%; /* 너비 조절 */
		font-size: 16px;
    }
</style>

	<form method="post" action="bbs_updateAction.jsp?bbsID=<%= bbsID %>">
		<table class="bbs_update">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee;">게시판 글 수정</th>						
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
				</tr>
				<tr>
					<td><textarea placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"><%= bbs.getBbsContent() %></textarea></td>						
				</tr>
				<tr>
					<td>
					<input type="button" value="취소" onclick="history.back()">
					<input type="submit" value="수정">
					</td>
				</tr>
			</tbody>
		</table>
	</form>						


<%@ include file="foot.jsp" %>

</body>
</html>