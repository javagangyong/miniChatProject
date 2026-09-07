<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width: 100%;
		height: 600px;
	}
	
	div.find {
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-25%, -25%);
	}
	
	
	.find > button {
		all: unset;
		width: 200px;
		height: 50px;
		border: 2px solid skyblue;
		border-radius: 12px;
		text-align: center;
		font-weight: 300;
		font-size: 20px;
		margin-bottom: 10px;
	}
	
	.find > button:hover {
		cursor: pointer;
		background-color: lightskyblue;
	}
	
	.findnewpw {
		all: unset;
		width: 200px;
		height: 50px;
		border: 2px solid skyblue;
		border-radius: 12px;
		text-align: center;
		font-weight: 300;
		font-size: 20px;
		margin-bottom: 10px;
	}
	.findnewpw:hover {
		cursor: pointer;
		background-color: lightskyblue;
	}
	
	p {
		margin: 0;
	}
	
	p > input {
		width: 200px;
		height: 50px;
	}
	
	form {
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
	}
	
	.inputframe{
		width: 300px;
		height: 60px;
 		margin: 10px;
		border: 1px solid lightgrey;
		box-sizing: border-box;
		padding: 5px 10px;
		color: black;
		font-size: 16px;
	}
</style>
</head>
<body>

	<section>
		<h2 align="center" style="font-weight: 200;">ID/PW찾기</h2>
		<div class="find">		
			<button id="findID">ID찾기</button>
			<button id="findPW">PW찾기</button>
		</div>
	</section>
	
	
	<script>
    document.getElementById('findID').addEventListener('click', function() {
        // 작은 윈도우 창 열기
        const popup = window.open('', 'findIDPopup', 'width=400,height=300');
        
        // 작은 윈도우 창에 HTML 삽입
        popup.document.write(`
            <html>
            <head>
            <style>
        	.find{
        		all: unset;
        		position: absolute;
        		margin-top: 20px;
    			top: 50%;
    			left: 50%;
    			transform: translate(-50%, -50%);
        		border: 2px solid skyblue;
        		border-radius: 12px;
        		width: 100px;
        		height: 30px;
        		font-size: 20px;
        		text-align: center;			
        	}
            .inputframe{
        		width: 250px;
        		height: 30px;
        		border: 1px solid lightgrey;
        		box-sizing: border-box;
        		padding: 5px 10px;
        		color: black;
        		font-size: 16px;
            	justify-content: center;
    			align-items: center;
            	border-radius: 5px;
        	}
            #findIDForm{
            	all: unset;
	    		width: 150px;
	    		height: 40px;
	    		border-radius: 12px;
	    		text-align: center;
	    		font-weight: 300;
	    		font-size: 20px;
	    		margin-bottom: 10px;
            }
            .find:hover {
            	cursor: pointer;
            	background-color: lightskyblue;
            }
            
        </style>
                <title>ID 찾기</title>
            </head>
            
            <body>
                <h2 align="center" style="font-weight: 200;">ID 찾기</h2>
                <div>
                    <form id="findIDForm">
                        <p><input class="inputframe" type="text" name="username" placeholder="이름"></p>
                        <p><input class="inputframe" type="email" name="email" placeholder="이메일"></p>
                        <input class="find" type="submit" value="찾기">
                    </form>
                </div>
            </body>
            </html>
        `);

        // 작은 윈도우 창에서 폼 제출 시 처리
        popup.document.getElementById('findIDForm').onsubmit = async function(event) {
            event.preventDefault();
            const url = '${cpath}/member/findID'; // 데이터베이스에서 아이디 찾는 엔드포인트
            const ob = {
                username: event.target.querySelector('input[name="username"]').value,
                email: event.target.querySelector('input[name="email"]').value
            };
            const opt = {
                method: 'POST',
                body: JSON.stringify(ob),
                headers: {
                    'Content-Type': 'application/json; charset=utf-8'
                }
            };
            const result = await fetch(url, opt).then(resp => resp.text());
            if (result !== 'not_found') {
                alert('ID가 이메일로 전송되었습니다.');
            } else {
                alert('일치하는 정보가 없습니다.');
            }
            popup.close(); // 작은 윈도우 창 닫기
        };
    });
</script>
	
<script>
   const sec = document.querySelector('section')
   const findPW = document.getElementById('findPW')
   
   
   
   
   findPW.onclick = () => {
      sec.innerHTML = ''
      let tag = ''
      tag += '<h2 align="center" style="font-weight: 200;">PW찾기</h2>'
      tag += '<div>'
      tag += '   <form>'
      tag += '      <p><input class="inputframe" type="text" name="userid" placeholder="ID"></p>'
      tag += '      <p><input class="inputframe" type="text" name="username" placeholder="NAME"></p>'
      tag += '      <p><input class="inputframe" type="email" name="email" placeholder="EMAIL"></p>'
      tag += '      <input class="findnewpw" name="verify" type="submit" value="제출하기">'
      tag += '   </form>'
//       tag += '   <div style="display: flex; width: 300px; margin: 10px auto;">'
//       tag += '      <input type="text" name="verify" placeholder="인증번호 입력" disabled="true">'
//       tag += '      <button style="margin-left: 10px;" id="verify">확인</button>'
//       tag += '   </div>'
      tag += '</div>'
      sec.innerHTML = tag
      sec.querySelector('form').onsubmit = async function(event) {
         event.preventDefault()
         const url = '${cpath}/member/findPW'
         const ob = {
               userid: event.target.querySelector('input[name="userid"]').value,
               username: event.target.querySelector('input[name="username"]').value,
               email: event.target.querySelector('input[name="email"]').value
         }
         const opt = {
            method: 'POST',
            body: JSON.stringify(ob),
            headers: {
               'Content-Type': 'application/json; charset=utf-8'
            }
         }
         const result = await fetch(url,opt).then(resp => resp.text())
         if(result == 'fail') {
            alert('계정정보가 일치하지 않습니다. 올바르게 입력해주세요')
         }
         else {
            const verify = event.target.parentNode.querySelector('input[name="verify"]')
            verify.disabled = false
            alert('임시 비밀번호를 발송했습니다. 메일을 확인해주세요')
            const verifyBtn = document.getElementById('verify')
            verifyBtn.onclick = function() {
               if(verify.value == result) {
                  location.href = '${cpath}/member/findresetPass'
               }
               else {
                  alert('인증번호를 잘못 입력하셨습니다. 다시 확인해주세요.')
               }
            }
         }
      }
   }
</script>

</body>
</html>