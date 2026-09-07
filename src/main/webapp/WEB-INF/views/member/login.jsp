<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	section {
		padding-top: 95px;
		width: 100%;
		height: 670px;
		display: flex;
		justify-content: center;
	}
	
	.login_inner {
		width: 700px;
	}
	
	#loginForm {
		position: relative;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: center;
	}
	
	.inputframe {
		position: relative;
		width: 300px;
		height: 60px;
		border: 1px solid lightgrey;
		box-sizing: border-box;
		display: flex;
		align-items: center;
		padding: 5px 10px;
		font-size: 16px;
	}
	
	#loginBtn {
		margin-top: 20px;
		width: 300px;
		height: 50px;
		border: 2px solid #0b5ed7;
		border-radius: 10px;
		background-color: white;
		font-size: 20px;
		color: #0b5ed7;
		text-align: center;
		font-weight: bold;
	}
	
	#loginBtn:hover {
		cursor: pointer;
		background-color: #0a58ca;
	}
	
	.inputframe > input {
		all: unset;
		font-size: 16px;
		margin-left: 36px;
	}
	
	.inputframe > span {
		display: inline-block;
		width: 30px;
		height: 30px;
		position: absolute;
	}

	
	#people {
	    background-image: url('${cpath}/resources/image/login.png');
	    background-size: 532px 450px;
	    background-position: -186px -407px;
	    background-repeat: no-repeat;
	}
	
	input[name="userid"]:focus + #people {
		background-position: -150px -407px;
	}
	
	#lock {
		background-image: url('${cpath}/resources/image/login.png');
	    background-size: 532px 450px;
	    background-position: -257px -407px;
	    background-repeat: no-repeat;
	}
	
	input[name="userpw"]:focus + #lock {
		background-position: -221px -407px;
	}
	
	#find {
		all: unset;
		cursor: pointer;
	}
	
    .popup-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
</style>

<section>
	<div class="login_inner">
		<h1 align="center">로그인</h1>
		<form method="POST" id="loginForm">
			<div class="inputframe">
				<input type="text" name="userid" placeholder="아이디" required autofocus>
				<span id="people"></span>
			</div>
			<div class="inputframe">
				<input type="password" name="userpw" placeholder="패스워드" required>
				<span id="lock"></span>
			</div>
			
			<div style="width: 300px; display: flex; justify-content: space-between;">
				<span id="find">ID/PW찾기</span>
				<span id="save">
					 7일간 자동 로그인
					<input type="checkbox" name="save" value="1">
				</span>
			</div>
			
			<button id="loginBtn">로그인</button> 
		</form>
	</div>
</section>

<div class="modal hidden">

</div>

<script>
	const find = document.getElementById('find')
	find.onclick = () => {
		let width = 600
		let height = 600
        let left = (window.innerWidth / 2) - (width / 2)
        let top = (window.innerHeight / 2) - (height / 2)
        let options = 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
		window.open('${cpath}/member/find', 'popupWindow', options)
	}
	
</script>

</body>
</html>