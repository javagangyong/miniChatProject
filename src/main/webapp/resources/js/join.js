// 아이디 중복체크
async function IdCheckHandler(event) {
		const check = document.getElementById('check')
		const joinBtn = document.getElementById('joinBtn')
	
		const IdInput = document.querySelector('input[name="userid"]')
		var userid = event.target.value
		var lengthCheck = userid.length >= 4
		if(userid.length > 10) {
			event.target.value = event.target.value.slice(0, 10)
		}
		var combCheck = /^[a-zA-Z0-9]+$/.test(userid)
		var prefixCheck = /^[a-zA-Z]{4}/.test(userid)
		
		const url = cpath + '/duplicateCheck?userid=' + userid
		const duplicateCheck = await fetch(url)
			.then(resp => resp.text())
			.then(text => {
				if(text == 1) {
					return false
				}
				else {
					return true
				}
			})
		const duplicate = document.getElementById('duplicate')
		if(lengthCheck && combCheck && prefixCheck && duplicateCheck) {
			check.innerText = '✅'
			joinBtn.disabled = false
			duplicate.style.display = 'none'
		}
		else {
			check.innerText = '❌︎'
			joinBtn.disabled = true
			if(!duplicateCheck) {
				duplicate.style.display = 'block'
			}
			else {
				duplicate.style.display = 'none'
			}
		}
	}

// 패스워드 조건 체크
function PasswordCheckHandler(event){
	const joinBtn = document.getElementById('joinBtn')
	var password = event.target.value
	var regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,15}$/;
	var pwCheck = regex.test(password)
	const pwLength = document.getElementById('pwLength')
	if(pwCheck){
		joinBtn.disabled = false
		pwLength.classList.add('hidden')
	}
	else {
		joinBtn.disabled = true
		pwLength.classList.remove('hidden')
	}
}

// 이메일 인증번호 발송
async function emailSendHandler(event){
	event.preventDefault()
	limit = 300
	const mailAuth = document.querySelector('.mailAuth')
	const mailSend = document.querySelector('.mailSend')
	const url = cpath + '/ajax/sendMail'
	const opt = {
		method: 'POST',
		body: JSON.stringify({
			address: mailSend.querySelector('input[name="email"]').value
		}),
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		}
	}
	const result = await fetch(url, opt).then(resp => resp.text())
	const message = mailSend.querySelector('p.mailMessage')
	if(result == 1){
		message.innerText = '인증번호를 발송하였습니다'
		message.style.color = '#105dae'
		mailAuth.classList.remove('hidden')
		const timer = document.getElementById('timer')
		
		
		function countDownHandler() {
			limit--
			timer.innerText = '남은 시간 : ' + '0' + Math.floor(limit / 60) + ':' + (limit % 60 < 10 ? 0 : '') + Math.floor(limit % 60)
			if(limit == 0) {
				clearInterval(timering)
			}
		}
		
		const timering = setInterval(countDownHandler, 1000)
	}
	else {
		message.innerText = '메일을 보낼 수 없습니다'
		message.style.color = 'red'
	}
}

// 이메일 인증번호 일치 확인
async function authNumberCheckHandler(event){
	event.preventDefault()
	const mailAuth = document.querySelector('.mailAuth')
	const mailSend = document.querySelector('.mailSend')
	const inputNumber = mailAuth.querySelector('input[name="authNumber"]').value
	const url = cpath + '/ajax/authNumber/' + inputNumber
	const result = await fetch(url).then(resp => resp.text())
	const message = mailAuth.querySelector('p.mailMessage')
	
	if(result == 1){
		message.innerText = '인증 성공'
		message.style.color = '#105dae'
		mailBtn.disabled = true
		authBtn.disabled = true
		document.getElementById('timer').style.display = 'none'
		joinBtn.disabled = false
	}
	else {
		message.innerText = '인증 실패'
		message.style.color = 'red'
		joinBtn.disabled = true
	}
}