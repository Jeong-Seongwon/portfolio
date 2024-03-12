<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.*" %>
<%
	//넘어온 데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%@ include file="header.jsp" %>

<% 
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String key = null;
		if (request.getParameter("key") != null) {
			key = request.getParameter("key");
		}
	    String val = null;
	    if (request.getParameter("val") != null) {
			val = request.getParameter("val");
		}
%>
<style>
	table.bbs {
		width:80%;
		margin:auto;
		text-align: center;
		border: 1px solid #dddddd;
	}
	tr.bbs {
		height:40px;
	}
	th.bbs {
		border-bottom: 1px solid #dddddd;
		background-color: #eeeeee;
	}
	td.bbs {
		border-bottom: 1px solid #dddddd;
	}
	a.left, a.right {
		display: inline-block; /* 인라인 요소를 블록 요소로 변경하여 여러 속성이 적용될 수 있게 함 */
	    padding: 5px 10px; /* 위아래 5px, 좌우 10px의 패딩 */
	    background-color: #eeeeee; /* 배경색 */
	    border: 1px solid #dddddd; /* 테두리 */
	    border-radius: 5px; /* 버튼 테두리 모서리 둥글게 */
	    color: rgb(0, 0, 0); /* 글자색 */
	    text-decoration: none; /* 링크의 밑줄 제거 */
	    font-weight: bold; /* 링크의 글꼴을 굵게 설정 */
	}
	a.left {
		float: left;
	}
	a.right {
		float: right;
	}
	a.bbs {
		float: left;
		padding: 5px 5px; /* 위아래 5px, 좌우 5px의 패딩 */
		color: rgb(0, 0, 0); /* 글자색 */
	    font-weight: bold; /* 링크의 글꼴을 굵게 설정 */
	}
	a.currentPage {
		float: left;
		padding: 5px 10px; /* 위아래 5px, 좌우 10px의 패딩 */
		color: rgb(150, 150, 150); /* 글자색 */
		text-decoration: none; /* 링크의 밑줄 제거 */
	    font-weight: bold; /* 링크의 글꼴을 굵게 설정 */
	}
</style>

<form onsubmit="return searchBbsCheck()" action="bbs.jsp" method="get">
	<table class="bbs">
		<thead>
			<tr class="bbs">
				<th class="bbs">번호</th>
				<th class="bbs" style="width:50%;">제목</th>
				<th class="bbs">조회수</th>
				<th class="bbs">작성자</th>
				<th class="bbs">작성일</th>
			</tr>
		</thead>
		<tbody>	
			<%
				BbsDAO bbsDAO = new BbsDAO();
				ArrayList<Bbs> list = bbsDAO.getList(pageNumber, key, val);
				
				for (int i = 0; i < list.size(); i++) {
			%>
			<tr class="bbs">
				<td class="bbs"><%= list.get(i).getBbsID() %></td>
				<td class="bbs"><a class="bbs" href="bbs_view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
				<td class="bbs"><%= list.get(i).getBbsViews() %></td>
				<td class="bbs"><%= list.get(i).getUserID() %></td>
				<td class="bbs"><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분 " %></td>
			</tr>
			<%		
				}
			%>
			<tr class="bbs">
				<td class="bbs" colspan="5" style="text-align:right;">
					<select id="key" name="key" style="font-size:16px; padding: 5px;">
                    	<option value="all" selected>전체</option>
		                <option value="bbsId">번호</option>
		                <option value="bbsTitle">제목</option>
		                <option value="bbsContent">내용</option>
		                <option value="userId">작성자</option>
		                <option value="bbsTC">제목+내용</option>
		            </select>
		            <input type="text" id="val" name="val" style="font-size:16px; padding: 5px;" />
					<input type="submit" value="검색">
				</td>
			</tr>
			<tr class="bbs">
				<td class="bbs" colspan="5">
				<% 
					int startPage = (pageNumber+9)/10;
					if (pageNumber != 1) {
				%>
						<a class="left" href="bbs.jsp?pageNumber=1&key=<%=key%>&val=<%=val%>">⋘</a>
						<a class="left" href="bbs.jsp?pageNumber=<%=pageNumber - 1%>&key=<%=key%>&val=<%=val%>">≺</a>
				<%
					} 
					for (int i=startPage; i<startPage+10 && i<=bbsDAO.lastPage(key, val); i++) {
						if (pageNumber==i) {
				%>
							<a class="currentPage"><%=i%></a>
				<%
						} else {
				%>
							<a class="bbs" href="bbs.jsp?pageNumber=<%=i%>&key=<%=key%>&val=<%=val%>"><%=i%></a>
				<%
						}

					}
					if (pageNumber < bbsDAO.lastPage(key, val)) {
				%>
						<a class="left" href="bbs.jsp?pageNumber=<%=pageNumber + 1%>&key=<%=key%>&val=<%=val%>">≻</a>
						<a class="left" href="bbs.jsp?pageNumber=<%=bbsDAO.lastPage(key, val)%>&key=<%=key%>&val=<%=val%>">⋙</a>
				<%
					}
				%>
					<a class="right" href="bbs_write.jsp">글쓰기</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
	
	<script>
        function searchBbsCheck() {
            var searchBbs = document.getElementById("val").value;
            if (searchBbs.length < 1) {
            	alert("검색 조건을 입력해주세요.");
                return false;
            } 
            return true;
        }
	</script>
	
<%@ include file="foot.jsp" %>

</body>
</html>