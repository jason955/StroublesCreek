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
        <title>User Manager Home</title>
    </head>
    <body>
        <x3d id='x3dElement' showStat='false' showLog='false' style='width:100%; height:100%; border:0; margin:0; padding:0;'>
        
        <scene id='scene'>
            <Environment frustumCulling="false"></Environment>           
            <navigationInfo DEF='NavigationInfo1' type='"EXAMINE" "ANY"'></navigationInfo>

            <viewpoint id='vpp' def='vp' description='ViewPoint 1' centerofrotation='3.4625 1.73998 -5.55'
                       orientation='0 1 0 2.99229' position='4.17102 1.00905 -6.97228'
                       znear="0.001" zfar="300"></viewpoint> 


            <viewpoint def='AOPT_CAM' centerofrotation='3.4625 1.73998 -5.55' position='3.4625 1.73998 8.69028'></viewpoint>
            <background DEF='bgnd' skyColor="0 0 0"></background>
            <group id='root' render='true'>
                <anchor url="_3DBBurg_local1.x3d">
                    <group DEF='theScene'>                    
                        <transform DEF='dad_Group1' translation='0 7.75 0'>
                            <shape DEF='Sphere1'>
                                <appearance>
                                    <material DEF='Red' diffuseColor='1 0 0'></material>
                                    <!-- Add the photosphere of your choice here -->
                                    <imageTexture url="bridge1.jpg"></imageTexture>
                                </appearance>
                                <!-- Radius is set heuristically-->
                                <sphere DEF='GeoSphere1' solid='false' radius='80'></sphere> 
                            </shape>
                            <viewpoint DEF='Viewpoint1' description='Main View' position='0 0 0' fieldOfView='0.95993'></viewpoint>
                        </transform>
                        <navigationInfo DEF='NavigationInfo1' type='"EXAMINE" "ANY"'></navigationInfo>
                        <viewpoint DEF='Viewpoint2' description='Viewpoint2' position='0 1.6 4.5' fieldOfView='0.7854'></viewpoint>                 
                    </group>
                </anchor>
                <switch witchChoice='0'>
                    <group>
                        <transform DEF='dad_Group2' translation='0 2 0'>
                            <shape DEF='Sphere2'>
                                <appearance>
                                    <material DEF='Blue' diffuseColor='0 0 1'></material>
                                    <!-- Add the photosphere of your choice here -->
                                    <imageTexture url="banner.jpg"></imageTexture>
                                </appearance>
                                <!-- Radius is set heuristically-->
                                <sphere DEF='GeoSphere2' solid='false' radius='80'></sphere> 
                            </shape>
                        </transform>
                    </group>
                </switch>
            </group>

            <!-- stereo-->
            <group id = "stereo" render="false">
                <group def='left'>
                    <shape>
                        <appearance>
                            <renderedtexture id="rtLeft" stereoMode="LEFT_EYE" update='ALWAYS' oculusRiftVersion="2"
                                             dimensions='640 800 4' repeatS='false' repeatT='false'>
                                <viewpoint use='vp' containerfield='viewpoint'></viewpoint>
                                <background use='bgnd' containerfield='background'></background>
                                <group use='theScene' containerfield="scene"></group>
                            </renderedtexture>
                            <composedshader>
                                <field name='tex' type='SFInt32' value='0'></field>
                                <field name='leftEye' type='SFFloat' value='1'></field>
                                <shaderpart type='VERTEX'>
                                    attribute vec3 position;
                                    attribute vec2 texcoord;

                                    uniform mat4 modelViewProjectionMatrix;
                                    varying vec2 fragTexCoord;

                                    void main()
                                    {
                                    vec2 pos = sign(position.xy);
                                    fragTexCoord = texcoord;

                                    gl_Position = vec4((pos.x - 1.0) / 2.0, pos.y, 0.0, 1.0);
                                    //gl_Position = vec4(pos.xy / 4.0 + vec2(-0.75,0.75), 0.0, 1.0);
                                    }
                                </shaderpart>
                                <shaderpart def="frag" type='FRAGMENT'>
                                    #ifdef GL_ES
                                    precision highp float;
                                    #endif

                                    uniform sampler2D tex;
                                    varying vec2 fragTexCoord;

                                    void main()
                                    {
                                    vec3 col = texture2D(tex, fragTexCoord).rgb;
                                    gl_FragColor = vec4(col, 1.0);
                                    }                        
                                </shaderpart>
                            </composedshader>
                        </appearance>
                        <plane solid="false"></plane>
                    </shape>
                </group>
                <group def='right'>
                    <shape>
                        <appearance>
                            <renderedtexture id="rtRight" stereoMode="RIGHT_EYE" update='ALWAYS' oculusRiftVersion="2"
                                             dimensions='640 800 4' repeatS='false' repeatT='false'>
                                <viewpoint use='vp' containerfield='viewpoint'></viewpoint>
                                <background use='bgnd' containerfield='background'></background>
                                <group use='theScene' containerfield="scene"></group>
                            </renderedtexture>
                            <composedshader>
                                <field name='tex' type='SFInt32' value='0'></field>
                                <field name='leftEye' type='SFFloat' value='0'></field>
                                <shaderpart type='VERTEX'>
                                    attribute vec3 position;
                                    attribute vec2 texcoord;

                                    uniform mat4 modelViewProjectionMatrix;
                                    varying vec2 fragTexCoord;

                                    void main()
                                    {
                                    vec2 pos = sign(position.xy);
                                    fragTexCoord = texcoord;

                                    gl_Position = vec4((pos.x + 1.0) / 2.0, pos.y, 0.0, 1.0);
                                    }
                                </shaderpart>
                                <shaderpart use="frag" type='FRAGMENT'>
                                </shaderpart>
                            </composedshader>
                        </appearance>
                        <plane solid="false"></plane>
                    </shape>
                </group>
            </group>
        </scene>
    </x3d>
    
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
		<input type="submit" onclick="insertBookmark3D()" value="insert">
		<input type="submit" onclick="getBookmark3D()" value="get">
		
		
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
