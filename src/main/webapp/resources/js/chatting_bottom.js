// 채팅방 온/오프 함수
function chatAppearHandler() {
	const chatArea = document.querySelector('.chat') // 채팅방 메인창
	const chatOpenBtn = document.getElementById('chat_open_btn')  // 채팅방 온 버튼
	const chatCloseBtn = document.getElementById('chat_close_btn')// 채팅방 오프 버튼
	chatArea.classList.toggle('hidden')
	chatOpenBtn.classList.toggle('hidden')
	chatCloseBtn.classList.toggle('hidden')
}
	   
// 채팅방 목록 화면으로 되돌아가는 함수
function showMainChatHandler() {
	const chatArea = document.querySelector('.chat')
	const chatBackBtn = document.getElementById('chat_close_btn')
	// room 클래스를 가진 모든 요소를 가져옵니다.
	const rooms = document.querySelectorAll('.room')

	// hidden 클래스가 없는 요소를 저장할 변수를 생성합니다.
	let visibleRoom = null

	// rooms 요소들을 순회하면서 hidden 클래스가 없는 요소를 찾습니다.
	rooms.forEach(room => {
		if (!room.classList.contains('hidden')) {
	       visibleRoom = room
	       return; // hidden 클래스가 없는 요소를 찾았으므로 반복문을 종료합니다.
		   }
		})
	chatArea.classList.remove('hidden')
	visibleRoom.classList.toggle('hidden')
	chatBackBtn.classList.remove('hidden')
}


// 채팅방 클릭시 해당 채팅방을 표시
function chatRoomHandler(event) {
	let target = event.target
	let roomName = null
	if(target.tagName != 'BUTTON') {		
		while(!target.classList.contains('chatroom')) {
			target = target.parentNode
		}
		roomName = target.getAttribute('roomname')
	}
	else {
		roomName = event.target.getAttribute('roomname')
	}
	
	// 모든 방을 일단 숨김
	const rooms = document.querySelectorAll('.room')
	rooms.forEach(e => e.classList.add('hidden'))
	
	const chatArea = document.querySelector('.chat')
	const chatroom = document.querySelector('.room[roomname="' + roomName +'"]')
	const chatOpenBtn = document.getElementById('chat_open_btn')  // 채팅방 온 버튼
	
	chatArea.classList.toggle('hidden')
	chatroom.classList.toggle('hidden')
	chatOpenBtn.classList.add('hidden')
	
	// 채팅방 스크롤을 맨 밑으로 내려가게 설정
	messageAreaHandler()
	
	// 표시된 알람이 있었다면 알람 숨김
	alarmClose()
}

// 알람 닫기 버튼 클릭시 닫기
function alarmClose() {
	const talkAlarm = document.querySelector('.talkAlarm')
	talkAlarm.style.zIndex = -5
	talkAlarm.style.opacity = 0
}

// 매칭 종료 확인창 표시
function matchingEndHandler(event) {
	let target = event.target
	while(target.tagName != 'SECTION') {
		target = target.parentNode
	}
	const roomName = target.getAttribute('roomname')
	const matchingEnd = document.querySelector('.room[roomname="' + roomName + '"]').querySelector('.matchingEnd')
	matchingEnd.classList.toggle('hidden')
}

// 매칭 종료 처리
async function disconnect(event) {
	let reqUser = user
	let respUser = event.target.getAttribute('oponent')
	let target = event.target
	while(target.tagName != 'SECTION') {
		target = target.parentNode
	}
	const roomName = target.getAttribute('roomname')
	const room = document.querySelector('.room[roomname="' + roomName +'"]')
	
	const url = cpath + '/matchAjax/disconnect'
	const ob = {
			reqUser: reqUser,
			respUser: respUser
	}	
	const opt = {
			method: "POST",
			body: JSON.stringify(ob),
			headers: {
				"Content-Type" : "application/json; charset=utf-8"
			}
	}
	
	const disconnect = room.querySelector('.disconnect')
	disconnect.classList.remove('hidden')							
	const matchingEnd = room.querySelector('.matchingEnd')
	matchingEnd.classList.add('hidden')
	stomp.unsubscribe('/broker/chat/' + roomName)
		
	const result = await fetch(url, opt).then(resp => resp.text())
	
	if(result == 1) {
		stomp.send('/app/matchover/' + roomName , {}, JSON.stringify({
			roomName: roomName,
			text: "매칭종료",
			from: username
		}))
		
	}
}

// 채팅방 리로드 함수
function chatreloadHandler() {
	const chatArea = document.querySelector('.chat') // 채팅방 메인창
	chatArea.querySelector('.chat_main').innerHTML = ''
	chatListLoadHandler()
	showMainChatHandler()
	const closeBtn = document.getElementById('chat_close_btn')
	closeBtn.classList.remove('hidden')
}

// 매칭중인 상대 리스트 불러오는 함수
async function chatListLoadHandler() {
	
	stomp.subscribe('/broker/' + user, onReceive)
	
	function ping() {
		stomp.send('/app/ping', {}, "")
	}

	setInterval(ping, 30000)

	const list = await getList()
	
	if(list.length == 0) {
		const chatArea = document.querySelector('.chat')
		chatArea.querySelector('.chat_main').innerHTML = ''
		chatArea.querySelector('.chat_main').innerHTML = '<p align="center">현재 대화 가능한 상대가 없습니다.</p>'
		return;
	}
	
	
	const rooms = document.querySelectorAll('.room')
	rooms.forEach(e => document.body.removeChild(e))
		
//		list.forEach(async dto => {
	for(let i = 0; i < list.length; i++) {
		const chatArea = document.querySelector('.chat') // 채팅방 메인창
		const dto = list[i]
		const roomName = dto.reqUser + dto.respUser
		const oponent = (dto.reqUsername == username ? dto.respUsername  : dto.reqUsername )
		let oponentId = (dto.reqUser == user ? dto.respUser : dto.reqUser)
		
		
		// 대화 상대 리스트 생성
		let tag = ''
		tag += '<div class="chatroom" roomname="' + roomName + '" onclick="chatRoomHandler(event)">'
		tag += 		'<div id="ch_room_profile"></div>'
		tag += 		'<div>' 
		tag += 			'<p>' + oponent + '</p>'
		tag += 			'<p id="ch_last_msg"></p>'
		tag += 		'</div>'
		tag += '</div>' 
		chatArea.querySelector('.chat_main').innerHTML += tag
		
		// 각 방에 구독
		stomp.subscribe('/broker/chat/' + roomName, receiveChat)
		stomp.send('/app/enter', {}, "")
		
		// 채팅 목록 불러오기
		const url =  cpath + '/chat/load'
		const ob = {
				reqUser : dto.reqUser,
				respUser : dto.respUser
		}
		const opt = {
				method: "POST",
				body: JSON.stringify(ob),
				headers: {
					"Content-Type" : "application/json; charset=utf-8"
				}
		}
		const chatList = await fetch(url, opt).then(resp => resp.json())

		// 채팅방 생성
		let room = ''
		room += '<section class="room hidden" roomname="' + roomName +'">'
		room += 	'<div class="chat_back_btn" onclick="showMainChatHandler()">↩</div>'
		room +=		'<div class="matchingEndBtn" onclick="matchingEndHandler(event)">매칭종료</div>'	
		room += 	'<div class="disconnect hidden">'
		room +=			'<div class="disconnectMsg">'
		room +=			'	상대방과의 매칭이 종료되었습니다'
		room +=			'	<br>'
		room +=			'	<a onclick="chatreloadHandler()">확인</a>'
		room +=			'</div>'
		room +=		'</div>'
		
		room += 	'<div class="matchingEnd hidden">'
		room += 		'<p style="text-align: center; color: white; font-size: 15px; font-weight: bold;">정말로 매칭을 종료하시겠어요?</p>'
		room +=			'<div>'
		room +=				'<button onclick="disconnect(event)" class="ch_yes_btn" oponent="' + oponentId +'">네</button>'
		room +=				'<button onclick="matchingEndHandler(event)" class="ch_no_btn" style="margin-left: 20px;">아니오</button>'
		room +=			'</div>'
		room +=		'</div>'
		room += 	'<div id="chatTitle">'
		room += 		'<h2 style="text-align: center; color: white; margin: 0;">' + oponent + '</h2>'
		room += 	'</div>'
		room += 	'<div class="messageArea" roomname="' + roomName +'">'
		
		// 불러온 채팅 목록을 미리 채팅방에 추가
		let previousSendTime = null; // 이전 채팅의 sendTime을 저장하기 위한 변수
		let previousUser = null;	 // 이전 채팅을 보낸 유저를 저장하기 위한 변수
		let finalMsg = null;
		for (let i = 0; i < chatList.length; i++) {
		    const chat = chatList[i];
		    let sendDate = chat.sendTime.split("-")[0]
		    const currentSendTime = chat.sendTime;	 // 현재 요소(채팅)의 전송 시간
		    const currentSendUser = chat.sendUserId; // 현재 요소(채팅)을 보낸 사람
		    let who = chat.sendUserId == user ? 'rightMsg' : 'leftMsg' // 보낸 사람이 로그인 중인 유저와 같으면 오른쪽에 표시, 다르면 왼쪽에 표시
		    let profileURL = cpath + '/upload/' + chat.profile;
		    // 채팅 생성	
		    let str = '';
		    
		    // 날짜 구분
		    if(i == 0 || previousSendTime.split("-")[0] != sendDate) {
		    	let yyyy = sendDate.split("/")[0]
		    	let MM = sendDate.split("/")[1]
		    	let dd = sendDate.split("/")[2]
		    	str += '<div class="ch_msg_date">' + yyyy + '년 ' + MM + '월 ' + dd + '일' + '</div>'
		    }
		    
		    str += '<div class="' + who + '">';
		    str += '<label class="' + (chat.sendUserId == user ? 'hidden' : '') + '" id="oponent">'; // 프로필 사진과 이름을 표시하기 위한 라벨, 보낸 사람이 자신일때는 숨김
		    if(currentSendTime != previousSendTime || previousUser != currentSendUser) {	// 이전 채팅의 전송 시간과 현재 채팅의 전송 시간이 다르거나
		    																				// 이전 채팅을 보낸 사람과 현재 채팅을 보낸 사람이 다르면
		    																				// 프로필 사진 표시
		    	str += '<span id="oponent_profile" style="background-image: url(\'' + profileURL + '\')"></span>';
		    	str += '<span style="font-size: 12px;">' + chat.sendUser + '</span>';
		    }
		    str += '</label>';
		    str += '<div>';
		    str += '<span style="font-size: 12px;">' + chat.text + '</span>';
		    
		    if(i < chatList.length - 1 && chatList[i + 1].sendUserId != currentSendUser) { // 다음 채팅을 전송한 사람과 현재 채팅을 전송한 사람이 다르면 시간 표시
		    	str += '<br><sub>' + chat.sendTime.split("-")[1] + '</sub>';
		    }
		    if (i < chatList.length - 1 && chatList[i + 1].sendTime != currentSendTime) { // 다음 채팅의 전송 시간과 현재 채팅의 전송 시간이 다르면 시간 표시
		    	str += '<br><sub>' + chat.sendTime.split("-")[1] + '</sub>';
		    }
		    if(i === chatList.length - 1) {	// 마지막 채팅이라면 시간 표시
		    	str += '<br><sub sendDate="' + chat.sendTime.split("-")[0] +'">' + chat.sendTime.split("-")[1] + '</sub>';
		    }
		    str += '</div>';
		    str += '</div>';
		    room += str;
		    
		    previousSendTime = currentSendTime
		    previousUser = currentSendUser
		    
		    if(i == chatList.length - 1) {
		    	finalMsg = chat.text
		    }
		}
		
		
		room += 	'</div>'
		room += 	'<div class="chatting" roomname="' + roomName + '" oponent="' + oponentId + '">'
		room +=			'<textarea class="chatMsg" placeholder="메시지 입력" onkeyup="sendChat(event)"></textarea>'
		room +=  		'<button class="sendMsg" onclick="onInput(event)">보내기</button>'
		room +=		'</div>'
		room +=  '</section>'
		
		document.body.innerHTML += room
		const chatroom = document.querySelector('.chatroom[roomname="' + roomName +'"]')
		chatroom.children[1].children[1].innerText = finalMsg
		let oponentProfile = await fetch(cpath + '/member/spec?userid=' + oponentId).then(resp => resp.json())
		let oponentProfileURL = cpath + '/upload/' + oponentProfile.profile
		console.log(chatroom.children[0])
		chatroom.children[0].style.backgroundImage = 'url(\'' + oponentProfileURL + '\')'
	}
}


// 소식창 표시 토글
async function newsAppearHandler() {
	const userNews = document.querySelector('.ch_user_news')
	userNews.innerText = ''
	const url = cpath + '/matchAjax/waiting?userid=' + user
	const news = await fetch(url).then(resp => resp.text())
	if(news == 0) {
		userNews.innerText = '현재는 아무런 소식이 없습니다.'
	}
	else {				
		userNews.innerText = '대기중인 매칭이 ' + news + '건 있습니다.'
	}
	
	userNews.classList.toggle('hidden')
}