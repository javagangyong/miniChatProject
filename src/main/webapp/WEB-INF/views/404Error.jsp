<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        section {
            padding-top: 95px;
		    width: 100%;
		    /*display: flex;*/
		    justify-content: center;
            text-align: center;
       

        }
        h1 {
            margin-top: 100px;
            font-size: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .image {
            width: 100px; 
            height: auto; 
            /*margin-right: 10px;*/ 
        }
        button {
            width: 300px;
            height: 50px;
            margin-top: 20px;
            border-radius: 10px;
            background-color: white;
            font-size: 20px;
            text-align: center;
            font-weight: bold;
            align-items: center;
            justify-content: center;
        }
        #toMain {
            border: 2px solid pink;
            color: pink;
        }
        #toMain:hover {
            background-color: pink;
    	    cursor: pointer;
    	    color: white;
        }
        
        #before {
            border: 2px solid hotpink;
            color: hotpink;
        }
        #before:hover {
            background-color: hotpink;
    	    cursor: pointer;
    	    color: white;
        }
        
    </style>
</head>
<body>

	<h1>4<img src="https://www.emojiall.com/images/120/huawei/1f497.png" alt="4" class="image">4</h1>
    <section>
        <h3>죄송합니다. 현재 찾을 수 없는 페이지를 요쳥 하셨습니다.</h3>
        <p>
        페이지의 주소가 잘못 입력되었거나, <br>
        주소가 변경 또는 삭제되어 요청하신 페이지를 찾을 수 없습니다.
        </p>
        <button id="toMain">메인으로</button>
        <button id="before">이전으로</button>
    </section>
    
    <script>
        
        document.getElementById("toMain").addEventListener("click", function() {
            window.location.href = "${cpath}/duo"; 
        });
        
        document.getElementById("before").addEventListener("click", function() {
            window.history.back();
        });
    </script>
    
    
</body>
</html>