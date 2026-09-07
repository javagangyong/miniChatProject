<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>miniChatProject</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');

	* {
		user-select: none;
	}
	
	html {
		scroll-behavior: smooth;
	}
	
	body {
		margin: 0;
		font-family: 'Noto Sans KR', sans-serif;
		overflow-x: auto;
		width: 100%;
		height: 100%;
	}
	
	body, h1, h2, h3, h4, h5, h6, input, textarea, select, pre {
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	
	button:hover {
		cursor: pointer !important;
	}
	
	nav {
		color: #ffffff;
	}
	
	ul, li, a {
		text-decoration: none;
		color: inherit;
	}
	
	nav.navBar {		
		background-color: #0d6efd;
		width: 100%;
		min-width: 1160px;
		padding: 15px 0;
	}
	
	.nav_inner_width {
		width: 1160px;
		margin: 0 auto;
		display: flex;
		justify-content: space-between;
		list-style: none;
		align-items: center;		
	}
	
	div.nav_spacer {
		min-width: 550px;
	}
	
	.nav_inner_width > div {
		white-space: nowrap; /* 텍스트가 밑으로 줄바꿈 되지 않게 */
	}
	
	.fa-solid {
		margin-right: 4px;
	}
	
	.fa-circle {
		color: #198754;
		font-size: 0.75rem;
		margin-right: 6px;
	}

	button {
	  /* 1. 브라우저 기본 스타일 제거 */
	  background: none;
	  border: none;
	  padding: 0;
	  margin: 0;
	  
	  /* 2. 폰트 및 텍스트 설정 (부모 요소의 폰트 상속) */
	  font-family: inherit;
	  font-size: inherit;
	  color: inherit;
	  line-height: inherit;
	  
	  /* 3. 클릭 및 상호작용 관련 설정 */
	  cursor: pointer;
	  outline: none; /* Focus outline 필요 시 별도 지정 */
	}
	
	.hidden {
		display: none !important;
	}
	
</style>

<body>
	
	<nav class="navBar">
		<div class="nav_inner_width">
			<div><a href="${cpath }">
				<i class="fa-solid fa-comments"></i> miniChat
			</a></div>
			<div class="nav_spacer"></div>
			<div>
				<c:if test="${not empty login }">
					<i class="fa-solid fa-circle"></i>${login.nickname }님
				</c:if>
			</div>
		</div>
	</nav>




</body>



	<script>
		// 로그인 중인 유저 확인
		var user = '${login.userid}'
 		var nickname = '${login.nickname}'
		var cpath = '${cpath}'
		
//		기존 stomp연결 로직		
// 		if (user != '') {
// 			stomp.connect({}, chatListLoadHandler)
// 			document.addEventListener('DOMContentLoaded', ChUserProfileImgHandler)
// 		}
		
		
		
		
	</script>