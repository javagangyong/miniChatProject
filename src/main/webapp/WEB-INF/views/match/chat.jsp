<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<style>
	.chat {
		display: flex;
		position: relative;
		justify-content: center;
		align-items: center;
		flex-direction: column;
	}
	
	.chat > div {
		box-sizing: border-box;
	}
	
	#chatTitle {
		position: relative;
		background-color: #4B89DC;
		width: 600px;
		display: flex;
		justify-content: center;
		align-items: center;
		border: 1px solid black;
	}
	
	.messageArea {
		width: 600px;
		height: 700px;
		border: 1px solid black;
		background-color: #aeceef;
		overflow-y: scroll;
	}
	
	.messageArea::-webkit-scrollbar {
    	display: none; 
	}
	
	.chatting {
		width: 600px;
		height: 80px;
		background-color: white;
		display: flex;
		justify-content: space-between;
	}
	
	#chatMsg {
		all: unset;
		border: 1px solid black; flex : 3;
		height: 100%;
		resize: none;
		box-sizing: border-box;
		padding: 5px;
		flex: 3;
	}
	
	#sendMsg {
		all: unset;
		flex: 1;
		height: 100%;
		background-color: yellow;
		font-weight: bold;
		text-align: center;
		border: 2px solid black;
		box-sizing: border-box;
	}
	
	.leftMsg {
		margin-top: 10px;
		margin-left: 10px;
		display: flex;
		align-items: flex-start;
		flex-direction: column;
	}
	
	.rightMsg {
		margin-top: 20px;
		margin-right: 5px;
		display: flex;
		align-items: flex-end;
		flex-direction: column;
	}
	
	.leftMsg > div {
		position: relative;
		width: fit-content;
		min-width: 30px;
		max-width: 200px;
		border-radius: 10px;
		background-color: white;
		box-sizing: border-box;
		padding: 5px;
		margin-left: 35px;
		margin-bottom: 10px;
		transform: translate(10px, -14px);
	}
	
	.rightMsg > div {
		position: relative;
		width: fit-content;
		min-width: 30px;
    	text-align: center;
		max-width: 200px;
		max-height: 500px;
		border-radius: 5px;
		background-color: yellow;
		box-sizing: border-box;
		padding: 5px;
		margin-right: 10px;
		margin-bottom: 10px;
	}
	
	.leftMsg > div::before {
		content: '';
	    position: absolute;
	    right: 100%;
	    margin-top: -8px;
	    border-width: 10px;
	    border-style: solid;
	    border-color: transparent transparent transparent #ffffff;
	    transform: rotate(105deg) translate(0, -11px);
	}
	
	.rightMsg > div::before {
		content: '';
	    position: absolute;
	    left: 100%;
	    margin-top: -15px;
	    border-width: 10px;
	    border-style: solid;
	    border-color: transparent #ffff00 transparent transparent;
	    transform: rotate(20deg) translate(-18px, 8px);
	}
	
	
	.leftMsg sub {
		font-size: 12px;
	    position: absolute;
	    top: 100%;
	    left: 100%;
	    width: 70px;
	    transform: translate(6px, -16px);
   	}
   	
   	.rightMsg sub {
	    font-size: 12px;
	    position: absolute;
	    width: 70px;
	    top: 100%;
	    right: 100%;
	    transform: translate(2px, -16px);
   	}
   	
   	#oponent {
   		display: flex;
   	}
   	
   	#oponent_profile {
   		display: inline-block;
   		width: 35px;
   		height: 35px;
   		border-radius: 5px;
   		background-position: center;
   		background-size: 100%;
   		margin-right: 10px;
   	}
   	
   	.chatOpt {
   		position: absolute;
   		top: 0;
   		left: 0;
   	}
   	
   	#kick {
   		all: unset;
   		font-size: 13px;
   		display: inline-block;
   		width: 68px;
   		height: 30px;
   		border: 2px solid hotpink;
   		color: hotpink;
   		text-align: center;
   		background-color: white;
   	}
   	
   	#kick:hover {
   		cursor: pointer;
   	}
   	
   	.matchingEnd {
		position: fixed;
	    display: flex;
	    width: 250px;
	    height: 100px;
	    flex-direction: column;
	    justify-content: center;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background-color: rgba(0, 0, 255, 0.5);
	    align-items: center;
	    border-radius: 20px;
   	}
   	
   	
   	.matchingEnd button {
   		all: unset;
   		cursor: pointer;
   		color: white;
   		font-weight: bold;
   		text-align: center;
   	}
   	
   	.disconnect {
		position: absolute;
   		top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
   		background-color: rgba(0, 0, 0, 0.6);
   		display: flex;
	    width: 600px;
	    height: 860px;
   		justify-content: center;
   		align-items: center;
   		color: white;
   		font-size: 17px;
   		font-weight: bold;
   		z-index: 5;
   	}
   	
   	#disconnectMsg {
   		text-align: center;
   	}
   	
   	#disconnectMsg > a {
   		all: unset;
   		margin-top: 10px;
   	}
   	
   	#disconnectMsg > a:hover {
   		cursor: pointer;
   		color: lightgrey;
   	}
</style>


<script>


	function getCurrentHHmm() {
	    const d = new Date();
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
	
	    return ampm + ' ' + h + ':' + m;
	}


	async function receiveChat(chat) {
		const content = JSON.parse(chat.body)
		const from = content.from
		const text = content.text
		
		if(from == 'admin') {
			const url = '${cpath}/matchAjax/disconnect'
			const ob = {
					reqUser: '${login.userid}',
					respUser: '${oponent}'
			}
			
			const opt = {
					method: "POST",
					body: JSON.stringify(ob),
					headers: {
						"Content-Type" : "application/json; charset=utf-8"
					}
			}
			
			const result = await fetch(url, opt).then(resp => resp.text())
			if(result == 1) {				
				const disconnect = document.querySelector('.disconnect')
				disconnect.classList.remove('hidden')
			}
			return
		}
		
		if(text == '이미 끝난 매칭입니다') {
			location.href = '${cpath}/match/mymatch'
			return
		}
		
		const time = content.time
		const profile = content.profile
		const profileUrl = cpath + '/upload/' + profile
		let str = ''
		str += '<div class="' + (from == username ? 'rightMsg' : 'leftMsg')
				+ '">'
 	    str += '<label class="' + (from == username ? 'hidden' : '') + '" id="oponent">'
		str += '<span id="oponent_profile" style="background-image: url(\'' + profileUrl + '\')"></span>'
		str += '<span style="font-size: 12px;">' + from + '</span>'
		str += '</label>'
		str += '<div>'
		str += '<span style="font-size: 12px;">' + text + '</span>'
		str += '<br><sub>' + content.time + '</sub>'
		str += '</div></div>'
		
		messageArea.innerHTML += str
		messageArea.scrollTop = messageArea.scrollHeight
	}

	function entering() {
		console.log('채팅방 입장~')
		stomp.subscribe('/broker/chat/${roomName}', receiveChat)
		stomp.send('/app/enter', {}, "")
	}

	function matchOver() {
		stomp.send('/app/matchover/${roomName}', {}, JSON.stringify({
			text: "상대방과의 매칭이 종료되었습니다."
		}))
	}
	
	
	function onInput(){
		const text = document.getElementById('chatMsg').value
		if(text == ''){
		   return
		 }
		document.getElementById('chatMsg').value = ''
		      
		stomp.send('/app/message/${roomName}', {}, JSON.stringify({      // 서버에게 입장 메시지와 시간을 보낸다.
		    from: username,
		    to: '${oponent}',
		    text: text,
		    time: getCurrentHHmm(),
		    userid : '${login.userid}'
		    }))
		   document.getElementById('chatMsg').focus()
		}
	
	const username = '${login.username}'
</script>

<section class="chat frame">
	<div id="chatTitle">
		<h2 style="text-align: center; color: white;">${oponent }님과의 채팅방</h2>
		<div class="chatOpt">
			<button id="kick">매칭 종료</button>
		</div>
	</div>

	<div class="messageArea">
		<c:forEach var="msg" items="${list }">
			<div class="${msg.sendUser == login.username ? 'rightMsg' : 'leftMsg'}">
				<label class="${msg.sendUser == login.username ? 'hidden' : ''}" id="oponent">
					<span id="oponent_profile" style="background-image: url('${cpath}/upload/${msg.profile }');"></span>
					<span style="font-size: 12px;">${msg.sendUser }</span>
				</label>
				<div>
					<span style="font-size: 12px;">${msg.text }</span>
					<br><sub>${(msg.sendTime).split("-")[1] }</sub>
				</div>
			</div>
		</c:forEach>
	</div>

	<div class="chatting">
		<textarea id="chatMsg" placeholder="메시지 입력"></textarea>
		<button id="sendMsg">보내기</button>
	</div>
	
	<div class="matchingEnd hidden">
		<p style="text-align: center; color: white; font-size: 15px; font-weight: bold;">정말로 매칭을 종료하시겠어요?</p>
		<div>	
			<button id="ch_yes_btn">네</button>
			<button id="ch_no_btn" style="margin-left: 20px;">아니오</button>
		</div>
	</div>
	
	<div class="disconnect hidden">
		<div id="disconnectMsg">	
			상대방과의 매칭이 종료되었습니다
			<br>	
			<a href="${cpath }/match/mymatch">나가기</a>
		</div>
	</div>
</section>






<script>
	const sendBtn = document.getElementById('sendMsg')
	const messageArea = document.querySelector('.messageArea')
	const chatMsg = document.getElementById('chatMsg')
	
	stomp.connect({}, entering)
	
	sendBtn.onclick = onInput
	chatMsg.onkeyup = function(e) {
		if(e.key == 'Enter') onInput()
	}
	
	messageArea.scrollTop = messageArea.scrollHeight
	
	const kickBtn = document.getElementById('kick')
	const matchingEnd = document.querySelector('.matchingEnd')
	kickBtn.onclick = () => { matchingEnd.classList.toggle('hidden') }
	
	const yesBtn = document.getElementById('ch_yes_btn')
	const noBtn = document.getElementById('ch_no_btn')
	
	noBtn.onclick = () => matchingEnd.classList.add('hidden')
	
	yesBtn.onclick = function() {
		matchingEnd.classList.add('hidden')
		matchOver()
	}
	
	
</script>

</body>
</html>
