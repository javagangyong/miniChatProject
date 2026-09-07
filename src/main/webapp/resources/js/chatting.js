	function getCurrentHHmm() {
	    const d = new Date();
	    let yyyy = d.getFullYear()
	    let MM = d.getMonth() + 1
	    MM = (MM < 10) ? '0' + MM : MM
	    let dd = d.getDate()
	    dd = (dd < 10) ? '0' + dd : dd
	    let h = d.getHours();
	    let m = d.getMinutes();
	    let ampm = '오전';
	
	    // 시간이 12 이상인 경우 오후로 표시하고, 12를 빼줌
	    if (h >= 12) {
	        ampm = '오후';
	        h -= 12;
	    }
	
	    // 시간이 0인 경우 12로 변경 (자정 처리)
	    if (h === 0) {
	        h = 12;
	    }
	
	    // 한 자리 숫자일 경우 앞에 0을 붙임
	    if (h < 10)
	        h = '0' + h;
	    if (m < 10)
	        m = '0' + m;
	
	    return yyyy + '/' + MM + '/' + dd + '-' + ampm + ' ' + h + ':' + m;
	}
	
	// 채팅 수신
	async function receiveChat(chat) {
		const content = JSON.parse(chat.body)
		const from = content.from
		var roomName = content.roomName
		const sendTime = content.time
		let sendDate = null
		let time = null
		if(sendTime != null) {
			sendDate = content.time.split("-")[0]
			time = content.time.split("-")[1]
		}
		const profile = content.profile
		const profileUrl = cpath + '/upload/' + profile
		const text = content.text
		const room = document.querySelector('.room[roomname="' + roomName + '"]')
		const messageArea = document.querySelector('.messageArea[roomname="' + roomName +'"]')
		
		// 상대방과 매칭 종료시
		if(text == '매칭종료') {
			if(room.classList.contains('hidden')) {
				const talkAlarm = document.querySelector('.talkAlarm')
				const alarmBtn = talkAlarm.children[1].children[0]
				alarmBtn.setAttribute('roomname', roomName)
				let content = ''
				content +=   '<div id="ch_matching_end">' + from + '님이 매칭을 종료하셨습니다.</div>'
				talkAlarm.children[0].innerHTML = content
				talkAlarm.style.zIndex = 10
				talkAlarm.style.opacity = 1
			}
			const disconnect = room.querySelector('.disconnect')
			disconnect.classList.remove('hidden')							
			const matchingEnd = room.querySelector('.matchingEnd')
			matchingEnd.classList.add('hidden')
			stomp.unsubscribe('/broker/chat/' + roomName)
			return;
		}
		
		// 현재 상대방과의 채팅방이 숨김 상태일때 알림 표시
		if(room.classList.contains('hidden')) {
			const talkAlarm = document.querySelector('.talkAlarm')
			const alarmBtn = talkAlarm.children[1].children[0]
			alarmBtn.setAttribute('roomname', roomName)
			let content = ''
			content += 	 '<div id="ch_alarm_profile" style="background-image: url(\'' + profileUrl +' \');"></div>'
			content +=   '<div id="ch_alarm_text">' + text +'</div>'
			talkAlarm.children[0].innerHTML = content
			talkAlarm.style.zIndex = 10
			talkAlarm.style.opacity = 1
		}
		
		let who = (from == username ? 'rightMsg' : 'leftMsg')
		let finalMsg = messageArea.lastElementChild
		let str = ''
			
		// 날짜 구분용
		let today = new Date()
		let yyyy = today.getFullYear()
		let MM = today.getMonth() + 1
		let dd = today.getDate()
		MM = (MM < 10) ? ('0' + MM) : MM
		dd = (dd < 10) ? ('0' + dd) : dd
				
		// 채팅을 아직 하나도 주고받지 않은 경우
		if(finalMsg == null) {
			finalMsg = document.createElement('div')
			str += '<div class="ch_msg_date">' + yyyy + '년 ' + MM + '월 ' + dd + '일' + '</div>'	
		}	
		else if(sendDate != finalMsg.querySelector('sub').getAttribute('sendDate')) {
			// 가장 최근에 온 채팅의 날짜와 현재 수신한 채팅의 날짜가 다르면 날짜 구분 div 추가
			str += '<div class="ch_msg_date">' + yyyy + '년 ' + MM + '월 ' + dd + '일' + '</div>'
		}
		
		str += '<div class="' + who
				+ '" dir="' + who + '">'
 	    str += '<label class="' + (from == username ? 'hidden' : '') + '" id="oponent">'
 
 	    // 프로필
 	    if(messageArea.childElementCount == 0) { 	    	
 	    	str += '<span id="oponent_profile" style="background-image: url(\'' + profileUrl + '\')"></span>'
 	    	str += '<span style="font-size: 12px;">' + from + '</span>'
 	    }
 	    else if(who == finalMsg.getAttribute('dir') && finalMsg.querySelector('sub').innerText != time) {
 	    	str += '<span id="oponent_profile" style="background-image: url(\'' + profileUrl + '\')"></span>'
 	    	str += '<span style="font-size: 12px;">' + from + '</span>'
 	    	
 	    }
 	    else if(who != finalMsg.getAttribute('dir')) {
 	    	str += '<span id="oponent_profile" style="background-image: url(\'' + profileUrl + '\')"></span>'
 	    	str += '<span style="font-size: 12px;">' + from + '</span>'
 	    }
		
	    if(who == finalMsg.getAttribute('dir') && finalMsg.querySelector('sub').innerText == time) {
 	    	finalMsg.children[1].children[2].remove()
 	    }
		
		str += '</label>'
		str += '<div>'
		str += '<span style="font-size: 12px;">' + text + '</span>'
		str += '<br><sub sendDate="' + sendDate + '">' + time + '</sub>'
		str += '</div></div>'
		
		document.querySelector('.chatroom[roomname="' + roomName + '"]').children[1].children[1].innerText = text
		messageArea.innerHTML += str
		messageArea.scrollTop = messageArea.scrollHeight
	}

	function onInput(event){
		// 입력이 발생한 대상의 방 이름을 가져온다
		let roomName = event.target.parentNode.getAttribute('roomname')
		let oponent = event.target.parentNode.getAttribute('oponent')
		
		// 입력이 발생한 대상의 방 이름과 일치하는 요소를 찾아 메시지를 가져온다
		const msgInput = document.querySelector('.chatting[roomname="' + roomName +'"]').children[0]
		const text = msgInput.value
		
		
		if(text == ''){
		   return
		}
		msgInput.value = ''
		      
		stomp.send('/app/message/' + roomName, {}, JSON.stringify({     
		    from: username,
		    to: oponent,
		    text: text,
		    time: getCurrentHHmm(),
		    userid : user,
		    roomName : roomName
		    }))
		   msgInput.focus()
		}
	
	
	function sendChat(event) {
		if(event.key == 'Enter') onInput(event)		
	}
	
	
	function messageAreaHandler() {
		const areas = document.querySelectorAll('.messageArea')
		areas.forEach(e => e.scrollTop = e.scrollHeight)
	}
	
	// 채팅 리스트 가져오는 함수
	const getList = async function() {
		const url =  cpath + '/matchAjax/matchList/' + user
		
		const list = await fetch(url).then(resp => resp.json())
		
		return list
	}

	
	