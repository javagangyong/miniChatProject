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
	div.center_main_title {
		font-weight: bold;
	}
	div.new_chat, div.center_main_title {
		margin-bottom: 20px;
		width: 450px;
	}
	
	
	/* 우측 프로필 카드 전체 박스 */
	/* 우측 프로필 카드 전체 박스 */
	.profile_card {
	  width: 240px;
	  padding: 24px 16px;
	  background-color: #ffffff;
	  border-radius: 12px;
	  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  box-sizing: border-box;
	}
	
	/* 프로필 이미지 */
	.profile_img {
	  width: 90px;
	  height: 110px;
	  object-fit: cover;
	  border-radius: 8px;
	  margin-bottom: 12px;
	}
	
	/* 이름 및 아이디 */
	.profile_name {
	  font-size: 16px;
	  font-weight: 700;
	  color: #1e293b;
	  margin-bottom: 2px;
	}
	
	.profile_id {
	  font-size: 13px;
	  color: #64748b;
	  margin-bottom: 20px;
	}
	
	/* [핵심] 내가 참여 중인 방 버튼 */
	.btn_my_rooms {
	  width: 100%;
	  padding: 10px 14px;
	  background-color: #f1f5f9;
	  border: 1px solid #e2e8f0;
	  border-radius: 8px;
	  display: flex;
	  align-items: center;
	  justify-content: space-between;
	  cursor: pointer;
	  transition: all 0.2s ease;
	  margin-bottom: 12px;
	}
	
	.btn_my_rooms:hover {
	  background-color: #e2e8f0;
	  border-color: #cbd5e1;
	}
	
	.btn_my_rooms .label {
	  font-size: 13px;
	  font-weight: 600;
	  color: #334155;
	}
	
	/* 참여 방 개수 배지 */
	.btn_my_rooms .badge_count {
	  background-color: #2563eb;
	  color: #ffffff;
	  font-size: 11px;
	  font-weight: 700;
	  padding: 2px 8px;
	  border-radius: 12px;
	}
	
	/* 로그아웃 버튼 */
	.btn_logout {
	  background: none;
	  border: none;
	  font-size: 13px;
	  color: #94a3b8;
	  cursor: pointer;
	  text-decoration: underline;
	  transition: color 0.2s ease;
	}
	
	.btn_logout:hover {
	  color: #ef4444;
	}
	
	
	/* 채팅방 리스트 */
	/* 채팅방 리스트 */
	div.chatting_box {
		width: 450px;
		height: 75px;
		padding: 0 18px;
		background-color: #ffffff;
		border: 1px solid #edf2f7;
		border-radius: 12px;
		margin-bottom: 12px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
		
		display: flex;
		align-items: center;
		justify-content: space-between;
		box-sizing: border-box;
		transition: all 0.2s ease-in-out;
	}
	
	/* 마우스 호버 시 살짝 떠오르는 반응형 효과 */
	div.chatting_box:hover {
		cursor: pointer;
		transform: translateY(-2px);
		box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
		border-color: #cbd5e1;
	}
	
	/* 왼쪽 영역 (번호 + 타이틀/타입 + 정원) */
	.chat_left {
		display: flex;
		align-items: center;
		gap: 12px;
		overflow: hidden;
	}
	
	/* 방 번호 배지 */
	.chat_no {
		font-size: 12px;
		font-weight: 700;
		color: #64748b;
		background-color: #f1f5f9;
		padding: 6px 9px;
		border-radius: 8px;
		white-space: nowrap;
	}
	
	/* 방 정보 감싸는 블록 */
	.chat_info {
		display: flex;
		flex-direction: column;
		gap: 4px;
		overflow: hidden;
	}
	
	/* 타입 배지와 제목 줄 */
	.chat_title_wrap {
		display: flex;
		align-items: center;
		gap: 6px;
		overflow: hidden;
	}
	
	/* 방 제목 (길어지면 ... 처리) */
	.chat_title {
		font-size: 15px;
		font-weight: 600;
		color: #1e293b;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	/* 방 타입 태그 (그룹/1:1 색상 구분) */
	.badge_type {
		font-size: 11px;
		font-weight: 600;
		padding: 2px 6px;
		border-radius: 4px;
		white-space: nowrap;
	}
	.badge_type.group {
		color: #2563eb;
		background-color: #eff6ff;
	}
	.badge_type.direct {
		color: #059669;
		background-color: #ecfdf5;
	}
	
	/* 정원 제한 표시 */
	.chat_maxUser {
		font-size: 12px;
		color: #94a3b8;
	}
	
	/* 오른쪽 입장 화살표 */
	.enter_arrow {
		font-size: 16px;
		color: #cbd5e1;
		font-weight: bold;
		transition: color 0.2s ease, transform 0.2s ease;
	}
	
	div.chatting_box:hover .enter_arrow {
		color: #2563eb;
		transform: translateX(3px); /* 호버 시 화살표가 오른쪽으로 슬쩍 이동 */
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
		top: 35%;
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
	
	
	
	
	
	/* 화면 오른쪽아래 채팅 모달 스타일 */
	.chat_modal_multi {
		position: fixed;
		bottom: 20px;
		right: 20px;
		width: 380px;
		height: 630px;
		border: 1px solid black;
		border-radius: 12px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.2);
		background-color: #E3F2FD;
		overflow: hidden;
		display: flex;
		flex-direction: column;
		z-index: 10;
	}
	div.chat_header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-weight: bold;
		padding: 12px 15px;
		background-color: #BBDEFB;
	}
	.btns_header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 120px;
	}
	.btn_unsubscribe {
		color: #757575;
   		font-size: 14px; 
	}
	.btn_unsubscribe:hover {
		color: #E57373;
	}
	
	/* 대화창 내부 및 스크롤 설정 */
	div.chat_body {
		padding: 15px;
		flex: 1;		/* 다른 박스를 뺀 나머지 공간 차지 */
		overflow-y: auto;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}
	div.chat_message {
		display: flex;
		flex-direction: column;
 		max-width: 70%;		/* 말풍선이 길어지면 자동으로 줄바꿈 */
	}
	
/* 	말풍선 + 안읽은 사람 수 숫자를 가로배치 */
	div.bubble_container {
		display: flex;
 		align-items: flex-end;	/* 숫자, 말풍선이 바닥쪽에 붙도록 */
		gap: 6px;
	}
	/* 안 읽은 사람 수 */
	.unread_flag {
		font-size: 11px;
		font-weight: bold;
		color: #F57C00;
		user-select: none;		/* 드래그 방지 */
	}
	
	/* 상대방 메세지 (왼쪽 흰색) */
	div.other_chat {
		align-self: flex-start;		/* align-items는 부모 align-self는 자식이 개인 적용 */	
	}
	div.other_chat .sender {
		font-size: 12px;
		color: #666;
		margin-bottom: 2px;
	}
	div.other_chat .bubble {
		background-color: #ffffff;
		padding: 8px 12px;
		border-radius: 10px;
		margin-top: 3px;
	}
	
	/* 내 메세지 (오른쪽) */
	div.my_chat {
		align-self: flex-end;
	}
	div.my_chat .bubble {
		background-color: #FFF9C4;
		padding: 8px 12px;
		border-radius: 10px;
	}
	
	.chat_footer {
		padding: 10px;
		background-color: #ffffff;
		display: flex;
		gap: 5px;
	}
	.chat_footer input {
		flex: 1;
		padding: 8px;
		border: 1px solid #ddd;
		border-radius: 4px;
	}
	
	/* 채팅방 내리기 */
	#chat_dock_bar {
		position: fixed;
		display: flex;
		bottom: 0;
		left: 20px;
		gap: 8px;
		z-index: 1000;
	}
	.chat_chip {
		padding: 8px 14px;
		background-color: #333;
		color: #fff;
		border-radius: 10px 10px 0 0;
		cursor: pointer;
		font-size: 13px;
	}
</style>
<body>


	<div class="container">
		<div class="left_side_bar">
			<div class="sidebar_title">메뉴(Menu)</div>
			<div class="sidebar_menu">
				<button type="button" id="allChatRoom">
					<i class="fa-solid fa-earth-americas"></i>전체 채팅방
				</button>
				<div><i class="fa-solid fa-lock"></i> 1:1 비밀채팅</div>
				<div><i class="fa-solid fa-user-group"></i> 친구 목록</div>
				<div><i class="fa-regular fa-comments"></i> 
					<a href="${cpath }/freeBoard/fbList/1">자유게시판</a>
				</div>
			</div>
		</div>
		
		<div class="center_main">
			<div class="center_main_title"></div>
			<div class="new_chat"><i class="fa-solid fa-plus"></i>
				<button id="create_chatroom_btn">새 채팅방 만들기</button>
			</div>
			<div id="chatting_list"></div>
		</div>
		
		<div class="right_profile">
			<div class="sidebar_title">내 프로필 / 현황</div>
			<div class="sidebar_menu">
				<c:if test="${not empty login }">
					<div class="profile_card">
					  <!-- 프로필 이미지 및 기본 정보 -->
					  <img id="user_profile_img" class="profile_img" alt="프로필">
					  <div class="profile_name">${login.nickname }님</div>
					  <div class="profile_id">${login.userid }</div>
					
					  <!-- 참여 중인 방 전용 버튼 (클릭 시 내가 들어간 방만 필터링) -->
					  <button type="button" class="btn_my_rooms" id="btnMyRooms">
					    <span class="label">💬 내가 참여 중인 방</span>
					    <span class="badge_count" id="myRoomsCount"></span>
					  </button>
					
					  <!-- 로그아웃 버튼 -->
					  <a href="${cpath }/member/logout">
					  	<button type="button" class="btn_logout">로그아웃</button>
					  </a>
					  
					</div>
				</c:if>
				<c:if test="${empty login }">
					<div><a href="${cpath }/member/login">로그인</a></div>
					<div><a href="${cpath }/member/signUp">회원가입</a></div>
				</c:if>
			</div>
		</div>
		
		
		<!-- 채팅방 만들기 -->
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
		
		
		<!-- 채팅방 최소화 바 -->
		<div id="chat_dock_bar"></div>

		
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
		
		
		// 전체 채팅방(기본 화면)
		const allChatRoom = document.getElementById('allChatRoom');
		allChatRoom.addEventListener('click', (e) => {
			const center_main_title = document.querySelector('.center_main_title');
			center_main_title.innerHTML = '참여 가능한 채팅방';
			center_main_title.classList.remove('hidden');
			reloadChatListHandler();
		})
		
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
		
		
		const chatting_list = document.getElementById('chatting_list');
		// 채팅방 리로드 함수
		async function reloadChatListHandler() {
			const url = cpath + '/homeAjax/chatList';
			const chatList = await fetch(url).then(resp => resp.json());
			
			// 스크립트 반복문
			const tag = chatList.map(function(dto) {
			    let item = '';
			    
			    // 방 타입별 아이콘 및 텍스트 설정
			    let isGroup = dto.roomType === 'group';
			    let typeBadge = isGroup ? '<span class="badge_type group">그룹</span>' : '<span class="badge_type direct">1:1</span>';
			    let userCountText = isGroup ? dto.maxUserCount + '명 제한' : '개인 채팅';
			
			 	// data-*는 사용자 커스텀 데이터 공식표기법(?)
			    item += '<div class="chatting_box" data-room-no="' + dto.roomNo + '" data-room-title="' + dto.roomTitle + '">';
			    item += '	<div class="chat_left">';
			    item += '		<span class="chat_no">#' + dto.roomNo + '</span>';
			    item += '		<div class="chat_info">';
			    item += '			<div class="chat_title_wrap">';
			    item += 				typeBadge;
			    item += '				<span class="chat_title">' + dto.roomTitle + '</span>';
			    item += '			</div>';
			    item += '			<div class="chat_meta">';
			    item += '				<span class="chat_maxUser">' + userCountText + '</span>';
			    item += '			</div>';
			    item += '		</div>';
			    item += '	</div>';
			    item += '	<div class="chat_right">';
			    item += '		<span class="enter_arrow">→</span>';
			    item += '	</div>';
			    item += '</div>';
			
			    return item;
			}).join('');	// 배열안의 요소들을 하나의 긴 문자열로 싹 합쳐라
			
			chatting_list.innerHTML = tag;
		}
		
		
		
		
		// 이미 열려있는 방 다시 눌렀을 때 중복 생성 방지(Set)
		const activeRooms = new Set();
		
		
		// 채팅방 들어가기
		chatting_list.addEventListener('click', async (e) => {
			// 클릭된 요소 중에서 가장 가까운 .chatting_box 찾기
			const chatting_box = e.target.closest('.chatting_box');
			if(!chatting_box) return;	
			
			// 방번호 저장
			const roomNo = chatting_box.dataset.roomNo;
			console.log('선택한 방 번호: ', roomNo);
			
			// 방이름 저장
			const roomTitle = chatting_box.dataset.roomTitle;
			
			// 이미 열려있는 채팅방이면 강조
			if(activeRooms.has(roomNo)) {
				const existingModal = document.getElementById('chat_modal_' + roomNo);
				if(existingModal) {
					document.querySelectorAll('.chat_modal_multi').forEach(m => m.style.zIndex = "100");
					existingModal.style.zIndex = "1000";
				}
				return;
			}
			
			// 방 참여 DB저장
			const chatRoomJoinUrl = cpath + '/homeAjax/insertRoomJoin';
			const ob = {roomNo: roomNo, userid: user}
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type' : 'application/json;charset=utf-8'
					}
			}
			const chatRoomJoinRow = await fetch(chatRoomJoinUrl, opt).then(resp => resp.text());
			console.log(chatRoomJoinRow.trim() === '1' ? '방 참여 정보 저장' : '기존 참여 방 또는 방 참여 저장 실패')
			
			// 저장된 방번호로 이전 대화 내역 불러오기
			const chatHistoryUrl = cpath + '/homeAjax/chatHistory?roomNo='+ roomNo +'&userid=' + user;
			const chatMessage = await fetch(chatHistoryUrl).then(resp => resp.json());
			
			// 내가 입력, 상대방이 입력을 다르게 적용
			const tag = chatMessage.map(function(dto) {
				let item = '';
				
				// 안 읽은 사람 수 태그(0보다 클때만 표시)
				const unreadHtml = dto.unreadCount > 0 ? '<span class="unread_flag">' + dto.unreadCount + '</span>' : '';
				
				if(dto.senderId !== user) {	// 상대방 메세지
					item += '<div class="chat_message other_chat">';
					item += '	<div class="sender">' + dto.senderId + '</div>';
					item += '	<div class="bubble_container" data-msg-no="'+ dto.msgNo +'">';
					item += '		<div class="bubble">' + dto.messageContent + '</div>';
					item += '		' + unreadHtml;	// 상대방 메세지는 말풍선 오른쪽
					item += '	</div>'
					item += '</div>';
				} else {	// 내 메세지
					item += '<div class="chat_message my_chat">'
					item += '	<div class="bubble_container" data-msg-no="'+ dto.msgNo +'">';
					item += '		' + unreadHtml;	// 내 메세지는 말풍선 왼쪽
					item += '		<div class="bubble">' + dto.messageContent + '</div>';
					item += '	</div>'
					item += '</div>';
				}
				return item;
			}).join('');
			
			// ※※ 이 방 전용 동적 모달 HTML 생성하기 ※※
			const modalDiv = document.createElement('div');
			modalDiv.className = 'chat_modal_multi';
			modalDiv.id = 'chat_modal_' + roomNo;
			
			document.querySelectorAll('.chat_modal_multi').forEach(m => m.style.zIndex = "100");
			modalDiv.style.zIndex = "1000";
			
			// 여러개 띄울 때 계단식으로 띄우기
			const offset = activeRooms.size * 40;
			modalDiv.style.right = (20 + offset) + 'px';
			modalDiv.style.bottom = (20 + offset) + 'px';
			
			let modalTag = '';
			modalTag += '<div class="chat_header">';
			modalTag += '	<span>' + roomTitle + '</span>';
			modalTag += '	<div class="btns_header">';
			modalTag += '		<button class="btn_unsubscribe" onclick="unsubscribeChat(\''+ roomNo +'\')" type="button">방 나가기</button>';
			modalTag += '		<button onclick="minimizedChat(\''+ roomNo +'\', \''+ roomTitle +'\')" type="button">ㅡ</button>';
			modalTag += '		<button onclick="exitChat(\''+ roomNo +'\')" type="button">X</button>';
			modalTag += '		';
			modalTag += '	</div>';
			modalTag += '</div>';
			modalTag += '<div class="chat_body" id="chat_body_'+ roomNo +'">';
			modalTag += 	tag;
			modalTag += '</div>';
			modalTag += '<form onsubmit="sendChatMessage(event, this, \''+ roomNo +'\')" class="chat_footer">';
			modalTag += '	<input type="text" name="messageContent" placeholder="메세지를 입력하세요..">';
			modalTag += '	<button type="submit">전송</button>';
			modalTag += '</form>';
			
			modalDiv.innerHTML = modalTag;
			
			document.body.appendChild(modalDiv);
			activeRooms.add(roomNo);	// 활성화된 방 등록
			
			const chatBody = document.getElementById('chat_body_' + roomNo);
			// 모달창 그리기 전에 실행 방지
			setTimeout(() => {
				//	스크롤 위에서부터 = 스크롤 전체길이(만큼 내려라)
				chatBody.scrollTop = chatBody.scrollHeight;
			}, 10);
			
			// 창 껐다 다시 켰을때를 위해
			updateWatching(roomNo, user, 'Y');
			updateLastReadMsgNo(roomNo, user);
			// 해당 방 동시 구독하기
			subscribeToRoom(roomNo);
		})
		
		
		
		
		// 각 방별 구독 객체(구독 해제용)
		const subscriptions = {};
		
		function subscribeToRoom(roomNo) {
			roomNo = String(roomNo);	// 타입 안정성 확보
			if(!stompClient || !stompClient.connected) return;
			
			// 구독 중이 아니라면 구독 시작 + 실시간 채팅
			if(!subscriptions[roomNo]) {
				subscriptions[roomNo] = stompClient.subscribe('/broker/' + roomNo, (response) => {
					const dto = JSON.parse(response.body);
					
					const targetChatBody = document.getElementById('chat_body_' + roomNo);
					if(targetChatBody) {	// if이유는 모달창 껐을때 들어오는 메세지로 인한 오류 방지
						let item = '';
					
						// 안 읽은 사람 수 태그(0보다 클때만 표시)
						const unreadHtml = dto.unreadCount > 0 ? '<span class="unread_flag">' + dto.unreadCount + '</span>' : '';
						
						if(dto.senderId !== user) {	// 상대방 메세지
							item += '<div class="chat_message other_chat">';
							item += '	<div class="sender">' + dto.senderId + '</div>';
							item += '	<div class="bubble_container" data-msg-no="'+ dto.msgNo +'">';
							item += '		<div class="bubble">' + dto.messageContent + '</div>';
							item += '		' + unreadHtml;	// 상대방 메세지는 말풍선 오른쪽
							item += '	</div>'
							item += '</div>';
						} else {	// 내 메세지
							item += '<div class="chat_message my_chat">'
							item += '	<div class="bubble_container" data-msg-no="'+ dto.msgNo +'">';
							item += '		' + unreadHtml;	// 내 메세지는 말풍선 왼쪽
							item += '		<div class="bubble">' + dto.messageContent + '</div>';
							item += '	</div>'
							item += '</div>';
						}
						// insertAdjacentHTML 'beforeend'는 밑에 추가로 하나씩 붙이는거
						targetChatBody.insertAdjacentHTML('beforeend', item);
						targetChatBody.scrollTop = targetChatBody.scrollHeight;
					}
				});
				console.log(roomNo + '번 방 실시간 구독 등록 완료');
			}
		}
		
		// 메세지 보내기
		function sendChatMessage(e, form, roomNo) {
			e.preventDefault();
			const inputEl = form.messageContent;	// 입력칸
			const messageContent = inputEl.value;
			
			if(messageContent === '') return;	// 빈 메세지 방지
			
			stompClient.send('/app/sendChatMessage/' + roomNo, {}, JSON.stringify({
				roomNo: roomNo,
				messageContent: messageContent,
				senderId: user
			}))
			
			// 입력 후 빈칸 처리 및 포커스 유지
			inputEl.value = '';
			inputEl.focus();
		}
		
		
		// 창 내리기
		function minimizedChat(roomNo, roomTitle) {
			const modalDiv = document.getElementById('chat_modal_' + roomNo);
			if(modalDiv) modalDiv.classList.add('hidden');
			
			// 바닥 칩 생성
			const chip = document.createElement('div');
			chip.id = 'chat_chip_' + roomNo;
			chip.className = 'chat_chip';
			chip.innerText = '💬 ' + roomTitle;
			
			// 칩 클릭시 모달 복원
			chip.addEventListener('click', () => {
				restoreChatModal(roomNo);
			})
			
			// 바닥 도크바에 추가
			document.getElementById('chat_dock_bar').appendChild(chip);
			updateWatching(roomNo, user, 'N');	// 이즈왓칭 갱신
		}
		
		// 창 올리기
		async function restoreChatModal(roomNo) {
			const chip = document.getElementById('chat_chip_' + roomNo);
			if(chip) chip.remove();
			
			const modalDiv = document.getElementById('chat_modal_' + roomNo);
			if(modalDiv) modalDiv.classList.remove('hidden');
			await updateWatching(roomNo, user, 'Y');	// 1. 이즈왓칭 갱신
			await unReadCount(roomNo, user);			// 2. 메세지 안읽은 사람 수 -1
			await updateLastReadMsgNo(roomNo, user);	// 3. 마지막 읽은 메세지 번호 갱신
														// 순서지켜야함 특히 2번 먼저 후 3번
			
														
														
			
		}
		
		// 채팅방 끄기
		function exitChat(roomNo) {
			const chatModal = document.getElementById('chat_modal_' + roomNo);
			chatModal.remove();			// 채팅방 모달 삭제
			activeRooms.delete(roomNo);	// 열려있는 방 삭제
			updateWatching(roomNo, user, 'N');	// 이즈왓칭 갱신
		}
		
		// 채팅방 나가기
		function unsubscribeChat(roomNo) {
			roomNo = String(roomNo);	// 타입 변환 에러 방지
			// 구독 먼저 해제
			if(subscriptions[roomNo]) {
				subscriptions[roomNo].unsubscribe();
				delete subscriptions[roomNo];
			}
			
			// 화면에서 모달 요소 삭제
			const modal = document.getElementById('chat_modal_' + roomNo);
			if(modal) modal.remove();
			activeRooms.delete(roomNo);
		}
		
		// 이즈왓칭 변경
		async function updateWatching(roomNo, user, isWatching) {
			const url = cpath + '/homeAjax/updateWatching';
			const ob = {
					roomNo: roomNo,
					userid: user,
					isWatching: isWatching
			}
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type': 'application/json;charset=utf-8'
					}
			}
			const row = await fetch(url, opt).then(resp => resp.text());
			console.log(row.trim() !== "1" ? roomNo + '번방 이즈왓칭 실패' : roomNo + '번방 이즈왓칭 성공!');
		}
		
		// 마지막 읽은 메세지 번호 갱신
		async function updateLastReadMsgNo(roomNo, user) {
			const url = cpath + '/homeAjax/updateLastReadMsgNo';
			const ob = {roomNo: roomNo, userid: user}
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type': 'application/json;charset=utf-8'
					}
			}
			await fetch(url, opt);
		}
		
		// 메세지 안읽은 사람 수 -1
		async function unReadCount(roomNo, user) {
			const url = cpath + '/homeAjax/unReadCount';
			const ob = {roomNo: roomNo, userid: user};
			const opt = {
					method: 'POST',
					body: JSON.stringify(ob),
					headers: {
						'Content-Type' : 'application/json;charset=utf-8'
					}
			}
			await fetch(url, opt);
		}
		
		// 내가 참여중인 방 카운트
		async function myRoomsCountHandler() {
			const myRoomsCount = document.getElementById('myRoomsCount');
			const url = cpath + '/homeAjax/myRoomsCount?userid=' + user
			const count = await fetch(url).then(resp => resp.text());
			
			myRoomsCount.innerHTML = count;
		}
		
		// 내가 참여중인 방
		const btnMyRooms = document.getElementById('btnMyRooms');
		if(btnMyRooms) {
			btnMyRooms.addEventListener('click', async() => {
				const url = cpath + '/homeAjax/selectMyRooms?userid=' + user;
				const myRoomList = await fetch(url).then(resp => resp.json());
				const tag = myRoomList.map(function(dto) {
				    let item = '';
				    
				    let isGroup = dto.roomType === 'group';
				    let typeBadge = isGroup ? '<span class="badge_type group">그룹</span>' : '<span class="badge_type direct">1:1</span>';
				    let userCountText = isGroup ? dto.maxUserCount + '명 제한' : '개인 채팅';
				
				    item += '<div class="chatting_box" data-room-no="' + dto.roomNo + '" data-room-title="' + dto.roomTitle + '">';
				    item += '	<div class="chat_left">';
				    item += '		<span class="chat_no">#' + dto.roomNo + '</span>';
				    item += '		<div class="chat_info">';
				    item += '			<div class="chat_title_wrap">';
				    item += 				typeBadge;
				    item += '				<span class="chat_title">' + dto.roomTitle + '</span>';
				    item += '			</div>';
				    item += '			<div class="chat_meta">';
				    item += '				<span class="chat_maxUser">' + userCountText + '</span>';
				    item += '			</div>';
				    item += '		</div>';
				    item += '	</div>';
				    item += '	<div class="chat_right">';
				    item += '		<span class="enter_arrow">→</span>';
				    item += '	</div>';
				    item += '</div>';
				
				    return item;
				}).join('');
				
				document.querySelector('.center_main_title').classList.add('hidden');
				chatting_list.innerHTML = tag;
			})
		}
		
		
		
		
		
		// 로그인시 최초호출
		if(user) {
			userProfileImgHandler()	// 유저 프로필 생성
			myRoomsCountHandler()	// 내가 참여중인 방 카운트
		}
		
		
		// 화면 로드시 전체 채팅방 클릭
		allChatRoom.dispatchEvent(new Event('click'));
		
		
		
		
	</script>

</body>
</html>