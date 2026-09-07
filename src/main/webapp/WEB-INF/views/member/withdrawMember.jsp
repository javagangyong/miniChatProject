<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
header {
	color: black;
}

section {
	padding-top: 95px;
	width: 100%;
	height: 920px;
	display: flex;
	justify-content: center;
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

.withdrawMember_inner {
	width: 700px;
	margin-top: 150px;
}

#withdrawMemberForm {
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
    color: grey;
}

#check {
	position: absolute;
	font-size: 30px;
	top: 8px;
	right: 110px;
}

#withdrawMemberForm>* {
	margin-top: 15px;
}

p {
	margin: 0;
	margin-top: 5px;
}
.wdmember {
	margin-top: 20px;
	width: 200px;
	height: 50px;
	border: 2px solid pink;
	border-radius: 10px;
	background-color: white;
	font-size: 20px;
	color: pink;
	text-align: center;
	font-weight: bold;
}
.wdmember:hover {
	cursor: pointer;
	background-color: hotpink;
}



</style>

<section>
	<div class="withdrawMember_inner">
		<div>
			<h1 style="text-align: center;">회원탈퇴</h1>
			<span id="nocontent"></span>
		</div>
		<div>
			<form method="POST" id="withdrawMemberForm">
				<input class="inputframe" type="text" name="userid"
					value="${dto.userid }" required readonly> <span id="check"></span>
				<input class="inputframe" type="password" name="userpw"
					placeholder="비밀번호 입력" required>
				<input class="inputframe" type="text" name="username"
					value="${dto.username }" required>
				<input class="wdmember" type="submit" value="회원탈퇴">
			</form>
		</div>
	</div>
</section>

</body>
</html>