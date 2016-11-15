<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html>
    <head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script type="text/javascript" src="http://www.x3dom.org/download/dev/x3dom.js"></script>
		
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
		<style>
		body {background-image: url("localhost/river.jpg");}
		#login {
			width: 500px;
			margin-left: auto;
			margin-right: auto;
			margin-top: 200px;
			border: 1px solid;
			border-radius: 10px;
			background-color: rgba(0,0,0,0.8) ;
			padding-top: 75px;
			padding-bottom: 75px;
			
			
		}
		#log{
			color:white;
		}
		</style>
    </head>
    <body>
        
       
    
    	<div align="center">
			<div id='login'>
				<table>
					<tr>
						<td id='log'>User Name:</td>
						<td><input type="text" id="username"></td>
					</tr>
					<tr>
						<td id='log'>Password:</td>
						<td><input type="password" id="password"></td>
					</tr>
					
					
				</table>
				<input type="submit" onclick="login()" value="Login">
				<a href="newUser">Create Account</a>
			</div>
		
		
    	</div>
    </body>
    <script>
    function editBookmark(userId) {
    	var bookmark = userId + "~n0" + window.location.href;
		
    	$.ajax({ 
    		   type: "GET",
    		   dataType: "json",
     		   url: "http://localhost:8080/Stroubles/editBookmark?mark=" + bookmark,
    		   success: function(data){        
    		   }
    		});
    }
    function login() {
    	var value = document.getElementById("username").value;
    	var value2 = document.getElementById("password").value;
    	var userInfo = value + "~n0" + value2;
    	$.ajax({ 
 		   type: "POST",
  		   url: "http://localhost:8080/Stroubles/checkUser?mark=" + userInfo,
           dataType : "json",
 		   success: function(data){ 
 			   window.location.href =  "http://localhost:8080/Stroubles/goVR";
 		   },
    		error: function (data) {
            	alert(data + "error");
        	}
 		});
    }
    function insertBookmark3D() {
    	var element = document.getElementById('x3dElement');
    	var view = element.runtime.viewpoint();
    	var name = "bmark";
    	var desc = view.getAttribute('description');
    	var center = view.getAttribute('centerOfRotation');
    	var position = view.getAttribute('position');
    	var orientation = view.getAttribute('orientation');
    	alert(position);
    	var posArr = position.split(",");
    	alert(posArr[0] + " " + posArr[1]);
    	var name = "jb4";
    	var desc = "this is cool";
    	var posX = 1;
    	var posY = 2;
    	var posZ = 3;
    	var orient1 = 4;
    	var orient2 = 5;
    	var orient3 = 6;
    	var orient4 = 7;
    	var cor1 = 1;
    	var cor2 = 2;
    	var cor3 = 3;
        var bmark = {"name":name,
        		"description":desc,
        		"posX":posX,
        		"posY":posY,
        		"posZ":posZ,
        		"orient1":orient1,
        		"orient2":orient2,
        		"orient3":orient3,
        		"orient4":orient4,
        		"cor1":cor1,
        		"cor2":cor2,
        		"cor3":cor3,
        		
        		};


            $.ajax({
                url: 'http://localhost:8080/Stroubles/insertBook3D',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(bmark),
                success: function (data) {
                	alert('yep');
                },
            });
    }
    function getBookmark3D() {
 

            $.ajax({
                url: 'http://localhost:8080/Stroubles/getBook3DLast',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                	alert('yarp');
                	
                	alert("COR: " +  data.cor1 + " " + data.cor2 + " " + data.cor3 );
                	alert("pos: " + data.posX + " " + data.posY + " " + data.posZ);
                	alert("orient: " +   data.orient1 + "," + data.orient2 + "," + 
                			data.orient3 +  "," + data.orient4);   
                	
                	},
            });
    }
    </script>
</html>
