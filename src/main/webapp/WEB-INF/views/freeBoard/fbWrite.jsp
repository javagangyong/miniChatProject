<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	section {
		padding-top: 95px;
		width: 100%;
		height: 920px;
 		/* justify-content: center; */
 	}
 	
 	#freeBoard {
 		position: absolute;
 		left: 41%;
 		top: 15%;
 	}
 	
 	#freeWrite_inner {
 		width: 700px;
 		margin: 144px auto;
 	}
 	
 	textarea[name="content"] {
		width: 700px;
		height: 360px;
		resize: none;
	}
</style>

	
<section>
	<div id="freeBoard">
		<h1>자유게시판 글쓰기</h1>
	</div>
	
	<div id="freeWrite_inner">
		<form method="post" enctype="multipart/form-data">
			<p><input type="text" name="title" placeholder="제목" autofocus required></p>
			<p><input type="text" name="writer" value="${login.userid }" readonly></p>
			<div><textArea name="content" placeholder="내용"></textArea></div>
			<p><input type="file" name="upload"></p>
			<p><input type="submit" value="작성"></p>
		</form>
	</div>
</section>



