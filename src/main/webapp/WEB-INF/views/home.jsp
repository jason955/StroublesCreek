<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html>
    <head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Manager Home</title>
    </head>
    <body>
    	<div align="center">
	        <h1>User List</h1>
	        <h3><a href="newUser">New User</a></h3>
	        <table border="1">
	        	<th>No</th>
	        	<th>User Name</th>
	        	<th>Password</th>
	        	<th>Bookmark</th>

	        	
				<c:forEach var="user" items="${listUser}" varStatus="status">
	        	<tr>
	        		<td>${status.index + 1}</td>
					<td>${user.name}</td>
					<td>${user.password}</td>
					<td>${user.bookmark}</td>
					<td>
						<a href="editUser?id=${user.id}">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="deleteUser?id=${user.id}">Delete</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" onclick="editBookmark(${user.id})" value="Edit Bookmark">
						
					</td>
							
	        	</tr>
				</c:forEach>	        	
			</table>
		<table>
			<tr>
				<td>User Name:</td>
				<td><input type="text" id="username"></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" id="password"></td>
			</tr>
			
			
		</table>
		<input type="submit" onclick="login()" value="login">
		
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
 			   alert(data.bookmark);
 		   },
    		error: function (data) {
            	alert(data + "error");
        	}
 		});
    }
    </script>
</html>
