<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	header {
		color: black;
	}
	
	#ch_join_section {
		width: 100%;
		height: 900px;
		display: flex;
		justify-content: center;
	}
	
	.center {
		text-align: center;
	}
	
	#nocontent {
		content: "";
		width: 100px;
		height: 5px;
		background-color: #105dae;
		position: absolute;
		left: 50%;
		margin-left: -50px;
	}
	
	.stepContainer {
		margin: 50px auto;
	}
	
	ul#step {
		padding: 0;
		list-style: none;
		display: flex;
		justify-content: center;
		text-align: center;
	}
	
	#arrow {
		font-weight: bold;
		margin: 15px 50px;
	}
	
	.join_inner {
		width: 700px;
		margin-top: 60px;
	}
	
	#joinForm {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
	}
	
	.inputframe {
		width: 500px;
		height: 60px;
		border: 1px solid lightgrey;
		box-sizing: border-box;
		padding: 5px 10px;
		color: black;
		font-size: 16px;
	}
	input::placeholder {
	    color: black;
	}
	
	label {
		width: 248px;
		height: 50px;
		border: 1px solid lightgrey;
		position: relative;
	}
	
	label:first-child {
		margin-right: 5px;
	}
	
	#joinBtn {
		margin-top: 20px;
		width: 400px;
		height: 50px;
		border: 1px solid lightgrey;
		background-color: #105dae;
		font-size: 20px;
		color: white;
		text-align: center;
		font-weight: bold;
	}
	
	button:hover {
		cursor: pointer;
	}
	
	#joinBtn:disabled {
		background-color: lightgrey;
		cursor: not-allowed;
	}
	
	#check {
		position: absolute;
		font-size: 30px;
		top: 8px;
		right: 110px;
	}
	
	#joinForm>* {
		margin-top: 15px;
	}
	
	p {
		margin: 0;
		margin-top: 5px;
	}
	
	.mailSend>p>input, .mailAuth>p>input {
		width: 350px;
		height: 50px;
		border: 1px solid lightgrey;
		position: relative;
		color: black;
		padding: 5px 10px;
		font-size: 16px;
	}
	
	#mailBtn, #authBtn {
		width: 130px;
		border: 1px solid lightgrey;
		background-color: #105dae;
		color: white;
		text-align: center;
		font-weight: bold;
	}
	
	.hidden {
		display: none;
	}
	

</style>
</head>

<body>
<section id="ch_join_section">
	<div class="join_inner">
		<div>
			<h1 style="text-align: center;">회원가입</h1>
			<span id="nocontent"></span>
		</div>
		<div>
			<form method="POST" id="joinForm">
			
				<input class="inputframe" type="text" name="userid"
					placeholder="아이디" required autofocus>
					
				<input class="inputframe" type="password" name="userpw" placeholder="비밀번호" required>
				<p id="pwLengthCheck" class="hidden"
					style="width: 500px; font-size: 13px; color: #105dae;">비밀번호는
					8글자 이상 15글자 이하의 영문자 + 숫자로만 조합할 수 있습니다.</p>
					
				<input id="pwInput2" class="inputframe" type="password" placeholder="비밀번호 확인" required>
				<p id="pwCheckFalse" class="hidden"
					style="width: 500px; font-size: 13px; color: #b02a37;">비밀번호와 비밀번호 확인이 일치하지 않습니다.</p>				
				<p id="pwCheckTrue" class="hidden"
					style="width: 500px; font-size: 13px; color: #105dae;">비밀번호와 비밀번호 확인이 일치합니다.</p>
														
				<input class="inputframe" type="text" name="nickname"
					placeholder="닉네임" required>					
					
				<div class="mailSend">
					<p style="display: flex;">
						<input type="email" name="email" placeholder="이메일" required>
						<button id="mailBtn">인증요청</button>
					</p>
					<p class="mailMessage1"></p>
				</div>
				<div class="mailAuth hidden">
					<p style="display: flex;">
						<input type="text" name="authNumber" placeholder="인증번호 입력">
						<button id="authBtn">확인</button>
					</p>
					<p class="mailMessage2"></p>
					<span id="timer"></span>
				</div>
				<button id="joinBtn" disabled>가입하기</button>
			</form>
		</div>
	</div>
</section>


<script>
	
	const joinBtn = document.getElementById('joinBtn');
	// 비밀번호 특정조건 만족
	function CheckPwHandler(event) {
		const password = event.target.value;
		const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,15}$/;
		const result = regex.test(password);
		
		const pwLengthCheck = document.getElementById('pwLengthCheck');
		if(result) {
			pwLengthCheck.classList.add('hidden');
			joinBtn.disabled = false;
		} else {
			pwLengthCheck.classList.remove('hidden');
			joinBtn.disabled = true;
		}
	}
	
	const pwInput1 = document.querySelector('input[name="userpw"]');
	// key하나하나 손가락뗄때마다 함수 실행
	pwInput1.addEventListener('keyup', CheckPwHandler);	
	
	
	// 비밀번호 일치
	function ConfirmPwHandler(event) {
		const confirmPw = event.target.value;		// 두번째 비밀번호 입력값
		const pwInput1Value = pwInput1.value;		// 첫번째 비밀번호 입력값
		const pwCheckFalse = document.querySelector('#pwCheckFalse');
		const pwCheckTrue = document.querySelector('#pwCheckTrue');
		const joinBtn = document.getElementById('joinBtn');
		
		// 두번째 비밀번호 입력값도 비밀번호 특정조건 만족 했는지
		const regex = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,15}$/;
		const result = regex.test(confirmPw);
		
		// 특정조건 만족 && 첫번째 두번째값 일치 && 빈값이 아닌지
		const isMatch = result && (confirmPw === pwInput1Value) && (confirmPw !== "");
		
		if(isMatch) {
			pwCheckTrue.classList.remove('hidden');
			pwCheckFalse.classList.add('hidden');
			joinBtn.disabled = false;
		} else {
			pwCheckFalse.classList.remove('hidden');
			pwCheckTrue.classList.add('hidden');
			joinBtn.disabled = true;
		}
	}
	
	const pwInput2 = document.querySelector('#pwInput2');
	pwInput2.addEventListener('keyup', ConfirmPwHandler);
	
	
	// 이메일로 인증번호 보내기
	const mailBtn = document.getElementById('mailBtn');
	mailBtn.addEventListener('click', async (event) => {
		event.preventDefault();
		
		const url = cpath + '/testMemberAjax/testEmailSend';
		const ob = {address: document.querySelector('input[name="email"]').value}
		const opt = {
				method: 'POST',
				body: JSON.stringify(ob),
				headers: {
					'Content-Type': 'application/json;charset=utf-8'
				}
		}
		
		const result = await fetch(url, opt).then(resp => resp.text());
		if(result === '1') {
			const mailAuth = document.querySelector('.mailAuth');
			const mailMessage1 = document.querySelector('p.mailMessage1');
			
			mailMessage1.innerText = '인증번호를 발송하였습니다';
			mailMessage1.style.color = '#105dae';
			mailAuth.classList.remove('hidden');
		} else {
			alert('메일 전송 실패')
		}		
	})
	
	
	
	// 인증번호 확인
	const authBtn = document.getElementById('authBtn');
	authBtn.addEventListener('click', async (e) => {
		
		e.preventDefault();
		
		const authNumber = document.querySelector('input[name="authNumber"]');
		const url = cpath + '/testMemberAjax/authNumberCheck?checkNumber=' + authNumber.value;

		const result = await fetch(url).then(resp => resp.text());
		const mailMessage2 = document.querySelector('p.mailMessage2');
		
		if(result == 1) {
			mailMessage2.innerText = '인증 성공';
			mailMessage2.style.color = '#105dae';
			mailBtn.disabled = true;
			authBtn.disabled = true;
			joinBtn.disabled = false;
		} else {
			mailMessage2.innerText = '인증 실패';
			mailMessage2.style.color = '#b02a37';
			joinBtn.disabled = true;
		}		
	})

</script>


</body>
</html>