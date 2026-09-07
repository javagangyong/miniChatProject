<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<script src="${cpath }/resources/js/join.js"></script>
<style>
header {
	color: black;
}

#ch_join_section {
	padding-top: 60px;
	width: 100%;
	height: 1300px;
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
	margin-top: 150px;
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

input[type="radio"] {
	all: unset;
	display: inline-block;
	position: absolute;
	width: 250px;
	height: 50px;
}

input[type="radio"]:checked+span {
	background-color: #105dae;
	color: white;
}

.radiotext {
	position: absolute;
	display: flex;
	width: 250px;
	height: 50px;
	justify-content: center;
	align-items: center;
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

/* 	다빈수정(240308) */
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

.birthday > select {
	width: 165px;
	height: 50px;
	border: 1px solid lightgrey;
	position: relative;
}

</style>

<section id="ch_join_section">
	<div class="join_inner">
		<div>
			<h1 style="text-align: center;">회원가입</h1>
			<span id="nocontent"></span>
		</div>
		<div class="stepContainer">
			<ul id="step">
				<li style="color: #105dae; font-weight: bold;"><small>STEP1</small>
					<p>회원정보입력</p></li>
				<li id="arrow">></li>
				<li><small>STEP2</small>
					<p>회원조건입력</p></li>
			</ul>
		</div>
		<div>
			<form method="POST" id="joinForm">
				<input class="inputframe" type="text" name="userid"
					placeholder="아이디" required autofocus> <span id="check"></span>
				<p id="duplicate"
					style="color: red; width: 500px; font-size: 13px; display: none;">이미
					사용중인 아이디입니다</p>
				<p style="width: 500px; font-size: 13px; color: #105dae;">아이디는
					4글자 이상 10글자 이하의 영문자 + 숫자로만 조합할 수 있습니다.</p>
				<input class="inputframe" type="password" name="userpw"
					placeholder="패스워드" required>
				<p id="pwLength" class="hidden"
					style="width: 500px; font-size: 13px; color: #105dae;">비밀번호는
					8글자 이상 15글자 이하의 영문자 + 숫자로만 조합할 수 있습니다.</p>
				<input class="inputframe" type="text" name="username"
					placeholder="이름" required>
				<div style="display: flex;">
					<label> <input type="radio" name="gender" value="남성"
						required> <span class="radiotext">남성</span>
					</label> <label> <input type="radio" name="gender" value="여성"
						required> <span class="radiotext">여성</span>
					</label>
				</div>
				<div class="birthday">
					<select class="birthYear_sel" title="출생년" name="birthYear" style="padding: 5px 10px;" required>
						<option value="">출생년</option>
						<option value="2005">2005년</option>
						<option value="2004">2004년</option>
						<option value="2003">2003년</option>
						<option value="2002">2002년</option>
						<option value="2001">2001년</option>
						<option value="2000">2000년</option>
						<option value="1999">1999년</option>
						<option value="1998">1998년</option>
						<option value="1997">1997년</option>
						<option value="1996">1996년</option>
						<option value="1995">1995년</option>
						<option value="1994">1994년</option>
						<option value="1993">1993년</option>
						<option value="1992">1992년</option>
						<option value="1991">1991년</option>
						<option value="1990">1990년</option>
						<option value="1989">1989년</option>
						<option value="1988">1988년</option>
						<option value="1987">1987년</option>
						<option value="1986">1986년</option>
						<option value="1985">1985년</option>
						<option value="1984">1984년</option>
						<option value="1983">1983년</option>
						<option value="1982">1982년</option>
						<option value="1981">1981년</option>
						<option value="1980">1980년</option>
						<option value="1979">1979년</option>
						<option value="1978">1978년</option>
						<option value="1977">1977년</option>
						<option value="1976">1976년</option>
						<option value="1975">1975년</option>
						<option value="1974">1974년</option>
						<option value="1973">1973년</option>
						<option value="1972">1972년</option>
						<option value="1971">1971년</option>
						<option value="1970">1970년</option>
						<option value="1969">1969년</option>
						<option value="1968">1968년</option>
						<option value="1967">1967년</option>
						<option value="1966">1966년</option>
						<option value="1965">1965년</option>
						<option value="1964">1964년</option>
						<option value="1963">1963년</option>
						<option value="1962">1962년</option>
						<option value="1961">1961년</option>
						<option value="1960">1960년</option>
						<option value="1959">1959년</option>
						<option value="1958">1958년</option>
						<option value="1957">1957년</option>
						<option value="1956">1956년</option>
						<option value="1955">1955년</option>
						<option value="1954">1954년</option>
						<option value="1953">1953년</option>
						<option value="1952">1952년</option>
						<option value="1951">1951년</option>
						<option value="1950">1950년</option>
						<option value="1949">1949년</option>
						<option value="1948">1948년</option>
						<option value="1947">1947년</option>
						<option value="1946">1946년</option>
						<option value="1945">1945년</option>
						<option value="1944">1944년</option></select>
					<select class="birthMonth_sel" title="월 선택" name="birthMonth" style="padding: 5px 10px;" required>
						<option value="">월 선택</option>
						<option value="01">1월</option>
						<option value="02">2월</option>
						<option value="03">3월</option>
						<option value="04">4월</option>
						<option value="05">5월</option>
						<option value="06">6월</option>
						<option value="07">7월</option>
						<option value="08">8월</option>
						<option value="09">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option></select> 
					<select class="birthDay_sel" title="일 선택" name="birthDay" style="padding: 5px 10px;" required>
						<option value="">일 선택</option>
						<option value="01">1일</option>
						<option value="02">2일</option>
						<option value="03">3일</option>
						<option value="04">4일</option>
						<option value="05">5일</option>
						<option value="06">6일</option>
						<option value="07">7일</option>
						<option value="08">8일</option>
						<option value="09">9일</option>
						<option value="10">10일</option>
						<option value="11">11일</option>
						<option value="12">12일</option>
						<option value="13">13일</option>
						<option value="14">14일</option>
						<option value="15">15일</option>
						<option value="16">16일</option>
						<option value="17">17일</option>
						<option value="18">18일</option>
						<option value="19">19일</option>
						<option value="20">20일</option>
						<option value="21">21일</option>
						<option value="22">22일</option>
						<option value="23">23일</option>
						<option value="24">24일</option>
						<option value="25">25일</option>
						<option value="26">26일</option>
						<option value="27">27일</option>
						<option value="28">28일</option>
						<option value="29">29일</option>
						<option value="30">30일</option>
						<option value="31">31일</option></select>
				</div>
				<div class="mailSend">
					<p style="display: flex;">
						<input type="email" name="email" placeholder="이메일">
						<button id="mailBtn">인증요청</button>
					</p>
					<p class="mailMessage"></p>
				</div>
				<div class="mailAuth hidden">
					<p style="display: flex;">
						<input type="text" name="authNumber" placeholder="인증번호 입력">
						<button id="authBtn">확인</button>
					</p>
					<p class="mailMessage"></p>
					<span id="timer"></span>
				</div>
				<input class="inputframe" type="text" name="phoneNumber"
					placeholder="전화번호" maxlength="11" required>
				<button id="joinBtn" disabled>가입하기</button>
			</form>
		</div>
	</div>
</section>
<script>
	const IdInput = document.querySelector('input[name="userid"]')
	IdInput.addEventListener('keyup', IdCheckHandler)
	
	
	const pwInput = document.querySelector('input[name="userpw"]')
	pwInput.addEventListener('keyup', PasswordCheckHandler)
	
	const mailBtn = document.getElementById('mailBtn')
	const authBtn = document.getElementById('authBtn')
	
	
	let limit = 300
	
	mailBtn.onclick = emailSendHandler
	authBtn.onclick = authNumberCheckHandler
	
	const joinBtn = document.getElementById('joinBtn')
	joinBtn.addEventListener('click', (event) => {
		const mailAuth = document.querySelector('.mailAuth')
		const message = mailAuth.querySelector('p.mailMessage')
		if(message.innerText != '인증 성공') {
			event.preventDefault()
			alert('이메일 인증이 완료되지 않았습니다!')
		}
	})
</script>
</body>
</html>