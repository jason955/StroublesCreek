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
        <title>Account Creation</title>
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
			<form:form action="saveUser" method="post" modelAttribute="user">
			
				<table>
					<form:hidden path="id"/>
					<tr>
						<td id='log'>User Name:</td>
						<td><form:input path="name" /></td>
					</tr>
					<tr>
						<td id='log'>Password:</td>
						<td><form:input path="password" /></td>
					</tr>
					
					<tr>
						<td colspan="2" align="center"><input type="submit" value="Save"></td>
					</tr>
				</table>
			</form:form>
			</div>
		
		
    	</div>
    </body>
</html>
