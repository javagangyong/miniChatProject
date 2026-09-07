<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	
	section {
		margin: 0 auto;
		padding: 95px 0 95px 0;
		width: 80%;
		height: max-content;
/* 		justify-content: center;
 */	}
	#freeBoardWriteBtn {
		position: absolute;
		left: 80%;
		top: 25%;
	}
 	#freeBoard {
 		/* position: absolute; */
 		/* left: 44%; */
 		width: max-content;
 		margin: 0 auto;
 	}
 	table {
 		margin: 86px auto 0 auto;
 		border-collapse: collapse;
 		width: 850px
 	}
 	td {
 		text-align: center;
 		vertical-align: center;
 		padding: 3px;
 		border-bottom: 1px solid black;
 	}
 	.title {
 		width: 55%;
 	}
 	.center {
 		width: max-content;
 		margin: 15px auto;
 		display: flex;
 	}
 	.bold {
 		font-weight: bold;
 		padding: 0 5px 0 5px;
 	}
 	.pageNumber {
 		padding: 0 5px 0 5px;
 	}
 	form {
 		margin-left: 15px;
 	}
	
	
	footer {
/* 		position: absolute !important;
 */		 
	}
</style>

<section>
	<div id="freeBoard">
		<h1>자유게시판</h1>
	</div>

	<div id="freeBoardWriteBtn">
		<a href="${cpath }/freeBoard/fbWrite"><button>글쓰기</button></a>
	</div>
	
	<table>
		<tr>
			<td>번호</td>
			<td class="title">제목</td>
			<td>글쓴이</td>
			<td>날짜</td>
		</tr>
		<c:forEach var="dto" items="${fbList }">
			<tr>
				<td>${dto.idx }</td>
				<td class="title"><a href="${cpath }/freeBoard/fbView/${dto.idx}">
						${dto.title } </a></td>
				<td>${dto.writer }</td>
				<td>${dto.writeDate }</td>
			</tr>
		</c:forEach>
	</table>
	
	<div class="center">
			<c:if test="${boardPaging.prev }">
				<a href="${cpath }/freeBoard/fbList/${boardPaging.begin - 1}">&lsaquo;</a>
			</c:if>
			<c:forEach var="i" begin="${boardPaging.begin }" end="${boardPaging.end }">
				<a 	class="${boardPaging.page == i ? 'bold' : 'pageNumber'}"
					href="${cpath }/freeBoard/fbList/${i}?search=${param.search}">${i}</a>
				<%-- ${param.search}는 검색결과 2페이지로 넘어갔을때 검색한 값이 남아있기 위해 --%>
			</c:forEach>
			<c:if test="${boardPaging.next }">
				<a href="${cpath }/freeBoard/fbList/${boardPaging.end + 1}">&rsaquo;</a>
			</c:if>
			<form>
				<input type="text" name="search" value="${param.search }">
				<%-- 검색 후에 검색창에 값이 남아있게 하기 위해 --%>
				<button>검색</button>
			</form>
	</div>
</section>



