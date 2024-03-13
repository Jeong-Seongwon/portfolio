<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.*" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%> 
 
<%@ include file="header.jsp" %>
	<% 
		String userId = null;
		if (user != null) {
			userId = user.getId();
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
		BbsDAO dao = new BbsDAO();
		dao.setBbsViews(bbsID ,bbs.getBbsViews());
		
	%>
<style>
	table.bbs_view {
		width:80%;
		margin:auto;
		border: 1px solid #dddddd;
		border-collapse: collapse;
	}
	th.bbs_view, td.bbs_view {
		border: 1px solid #dddddd;
	}
</style>

	<table class="bbs_view">
		<thead>
			<tr>
				<th class="bbs_view" colspan="6" style="background-color: #eeeeee;">게시판 글보기</th>						
			</tr>
		</thead>
		<tbody>
			<tr>
				<th class="bbs_view">글제목</th>
				<td class="bbs_view" colspan="5"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
			</tr>
			<tr>
				<th class="bbs_view">작성자</th>
				<td class="bbs_view"><%= bbs.getUserID() %></td>
				<th class="bbs_view">조회수</th>
				<td class="bbs_view"><%= bbs.getBbsViews()+1 %></td>
				<th class="bbs_view">작성일자</th>
				<td class="bbs_view"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분 " %></td>
			</tr>
			<tr>
				<th class="bbs_view" style="height:400px;">내용</th>
				<td class="bbs_view" colspan="5"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
			</tr>
			<tr>
				<td class="bbs_view" colspan="6" ><input type="button" value="목록" onclick="window.location.href='bbs.jsp'">
				<%
					if (userId != null && userId.equals(bbs.getUserID())) {
				%>
						<input type="button" value="삭제" onclick="confirmAction()">
						<input type="button" value="수정" onclick="window.location.href='bbs_update.jsp?bbsID=<%=bbsID%>'">
				<%
					}
				%>	
				</td>
			</tr>
		</tbody>
	</table>
	
	<script>
		function confirmAction() {
            // 확인 팝업을 띄우고 사용자의 선택에 따라 동작 결정
            var result = confirm("글을 삭제하시겠습니까?");
            if (result) {
                // 확인을 눌렀을 때의 동작
                // 여기에 원하는 동작을 추가하세요
                window.location.href='bbs_deleteAction.jsp?bbsID=<%=bbsID%>'
            } else {
                // 취소를 눌렀을 때의 동작
                // 여기에 원하는 동작을 추가하세요
                alert("삭제가 취소되었습니다.");
            }
        }
	</script>

<%@ include file="foot.jsp" %>
</body>
</html>