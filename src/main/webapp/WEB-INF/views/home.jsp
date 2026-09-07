<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>miniChatProject - 홈</title>
</head>
<style>
	div.container {
		position: relative;
		margin: 0 auto;
/* 		border: 1px solid black; */
		width: 1160px;
		min-height: 750px;
		display: flex;
		background-color: #f8f9fa;
	} 
	div.left_side_bar {
		width: 290px;
/* 		border: 1px solid black; */
	}
	div.center_main {
		width: 580px;
	}
	div.right_profile {
		width: 290px;
/* 		border: 1px solid black; */
	}
	.left_side_bar, .center_main, .right_profile {
		padding: 20px 0;
		display: flex;
		flex-direction: column;
		align-items: center;
		min-height: 750px;		
	}
	.fa-circle-user {
		font-size: 24px;
	}
	div.sidebar_menu {
		display: flex;
		flex-direction: column;
 		gap: 12px;
		align-items: center;
		width: 100%;
	}
	.sidebar_menu > div {
		cursor: pointer;
	}
	div.sidebar_title {
		margin-bottom: 20px;
		text-align: left;
		font-weight: bold;
		width: 260px;
	}
	div.chatting_box {
		width: 450px;
		height: 150px;
		box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
		background-color: #ffffff;
		border-radius: 8px;
		margin-bottom: 15px;
	}
	div.center_main_title {
		font-weight: bold;
	}
	div.new_chat, div.center_main_title {
		margin-bottom: 20px;
		width: 450px;
	}
	
	#user_profile_img {
		width: 100px;
		height: 100px;
	}
	
	
	/* 채팅방 만들기 스타일 */
	.input_frame {
		display: block;
		width: 200px;
		height: 30px;
		border: none;
		border-bottom: 1px solid #e0e0e0;
		margin-bottom: 10px;
	}
	div.flex {
		display: flex;
		gap: 10px;
	}
	.form_btn {
 		background-color: #eff6ff;
 		border: 1px solid #bfdbfe;
 		width: 50px;
 		height: 35px;
 		font-size: 14px;
 		border-radius: 5px;
	}
	.cancel_btn {
		background-color: #ffffff;
 		border: 1px solid #e5e7eb;
 		width: 50px;
 		height: 35px;
 		font-size: 14px;
 		border-radius: 5px;
	}
	
	div.create_chatroom {
		position: absolute;
		top: 45%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 250px;
		height: 270px;
		border: 1px solid black;
		border-radius: 5px;
		background-color: #ffffff;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 2;
	}
	.create_chatroom_font {
		color: #4b5563;
		margin-top: 0;
	}
	.input_cover {
		font-size: 15px;
		margin-bottom: 5px;
	}
	div.create_chatroom_overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.25);
		z-index: 1;
	}
</style>
<body>


	<div class="container">
		<div class="left_side_bar">
			<div class="sidebar_title">메뉴(Menu)</div>
			<div class="sidebar_menu">
				<div><i class="fa-solid fa-earth-americas"></i> 전체 채팅방</div>
				<div><i class="fa-solid fa-lock"></i> 1:1 비밀채팅</div>
				<div><i class="fa-solid fa-user-group"></i> 친구 목록</div>
				<div><i class="fa-regular fa-comments"></i> 
					<a href="${cpath }/freeBoard/fbList/1">자유게시판</a>
				</div>
			</div>
		</div>
		<div class="center_main">
			<div class="center_main_title">참여 가능한 채팅방</div>
			<div class="new_chat"><i class="fa-solid fa-plus"></i>
				<button id="create_chatroom_btn">새 채팅방 만들기</button>
			</div>
			<div id="chatting_list"></div>
		</div>
		<div class="right_profile">
			<div class="sidebar_title">내 프로필 / 현황</div>
			<div class="sidebar_menu">
				<c:if test="${not empty login }">
					<div><img id="user_profile_img"></div>
					<div><i class="fa-solid fa-circle-user"></i>${login.nickname }님</div>
					<div>${login.userid }</div>					
					<div>참여중인 방 : 3개</div>
					<div>읽지 않은 채팅 : 2개</div>
					<div><a href="${cpath }/member/logout">로그아웃</a></div>
				</c:if>
				<c:if test="${empty login }">
					<div><a href="${cpath }/member/login">로그인</a></div>
					<div><a href="${cpath }/member/signUp">회원가입</a></div>
				</c:if>
			</div>
		</div>
		
		
		<div class="create_chatroom hidden">
			<form method="POST" id="create_chatroom_form">
				<p class="create_chatroom_font">채팅방 만들기</p>
				<p class="input_cover">채팅방 이름</p>
				<input class="input_frame" type="text" name="roomTitle" placeholder="채팅방 이름을 입력해 주세요">
				<p class="input_cover">인원수</p>
				<input class="input_frame" type="text" name="maxUserCount" placeholder="인원수를 입력해 주세요" maxlength="3">
				<div class="flex">
					<button class="form_btn">확인</button>
					<button class="cancel_btn" type="button">취소</button>
				</div>
			</form>
		</div>
		<div class="create_chatroom_overlay hidden"></div>
		
		
	</div>
	
	
	
	<script>
		// 유저 프로필 생성
		async function userProfileImgHandler() {
			const user_profile_img = document.getElementById('user_profile_img');
			const url = cpath + '/memberAjax/selectOne?userid=' + user;
			const userInfo = await fetch(url).then(resp => resp.json());
			const profile = userInfo.profileImg ? userInfo.profileImg : 'default_profile.png';
			
			user_profile_img.src = cpath + '/upload/' + profile;
		}
		
		userProfileImgHandler()
		
		// 채팅방 만들기 모달 생성
		const create_chatroom = document.querySelector('.create_chatroom');
		const create_chatroom_overlay = document.querySelector('.create_chatroom_overlay');
		const btns = [
			document.getElementById('create_chatroom_btn'),
			create_chatroom_overlay,
			document.querySelector('.cancel_btn'),
			document.querySelector('.form_btn')
		]
		btns.forEach(b => b.addEventListener('click', () => {
				create_chatroom.classList.toggle('hidden');
				create_chatroom_overlay.classList.toggle('hidden');
		}))
		
		
		// 채팅방 만들기 form submit
		const create_chatroom_form = document.getElementById('create_chatroom_form');
		create_chatroom_form.addEventListener('submit', async (e) => {
			e.preventDefault();
			
			const url = cpath + '/homeAjax/createChatroom';
			const ob = {};
			const formData = new FormData(e.target);
			for(let key of formData.entries()) {
				ob[key[0]] = key[1]; 
			}
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type' : 'application/json;charset=utf-8'
					}
			};
			
			const result = await fetch(url, opt).then(resp => resp.json());
			if(result === 1) {
				await reloadChatListHandler();
				e.target.reset();
			} else {
				alert('방 생성 실패');
			}
		})
		
		
		// 채팅방 리로드 함수
		async function reloadChatListHandler() {
			const chatting_list = document.getElementById('chatting_list');
			const url = cpath + '/homeAjax/chatList';
			const chatList = await fetch(url).then(resp => resp.json());
			
			// 스크립트 반복문
			const tag = chatList.map(function(dto) {
				let item = '';
				item += '<div class="chatting_box">'
				item += '	<div class="chat_no">' + dto.roomNo+ '</div>';
				item += '	<div class="chat_title">' + dto.roomTitle + '</div>';
				item += '	<div class="chat_maxUser">' + dto.maxUserCount + '명 제한</div>';
				item += '</div>';
				
				return item;
			}).join(''); // 배열안의 요소들을 하나의 긴 문자열로 싹 합쳐라
			
			chatting_list.innerHTML = tag;
		}
		
		document.addEventListener("DOMContentLoaded", reloadChatListHandler);
		
		
		
		
	</script>

</body>
</html>