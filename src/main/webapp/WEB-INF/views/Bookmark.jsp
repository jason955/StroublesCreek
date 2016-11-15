<html>
    <head>
        <title>Photosphere in WebVR 1.0 using X3DOM</title>
        <meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>
        <meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
        <script type="text/javascript" src="http://www.x3dom.org/download/dev/x3dom.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <link rel='stylesheet' type='text/css' href='http://www.x3dom.org/download/dev/x3dom.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <style>         

            #enterVR {
                background: rgba(0, 0, 0, .35) 50% 50% no-repeat;
                background-size: 70% 70%;
                color: #fff;
                height: 50px;
                width: 60px;
                border: none;
                background-color: rgba(120, 120, 120, .35);
                padding: 1px 6px;
                position:absolute;
                bottom:10px; 
                right:10px;
                cursor: pointer;
            }

            #enterFS {
                background: rgba(0, 0, 0, .35) 50% 50% no-repeat;
                background-size: 70% 70%;
                color: #fff;
                height: 50px;
                width: 70px;
                border: none;
                background-color: rgba(120, 120, 120, .35);
                padding: 1px 6px;
                position:absolute;
                bottom:10px; 
                right:80px;
                cursor: pointer;
            }

            #exitVR {
                background: rgba(0, 0, 0, .35) 50% 50% no-repeat;
                background-size: 70% 70%;
                color: #fff;
                height: 50px;
                width: 60px;
                border: none;
                background-color: rgba(120, 120, 120, .35);
                padding: 1px 6px;
                position:absolute;
                bottom:10px; 
                right:160px;
                cursor: pointer;
            }

            #enterVR:hover,#enterFS:hover, #exitVR:hover {
                background-color: rgba(120, 120, 120, .65);
            }

            .goggles {
                height: 30px;
                text-align: center;
                color: buttontext;
            }

        </style>     

    </head>
    <body style='width:100%; height:100%; border:0; margin:0; padding:0;'>

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
                                    <imageTexture url="http://localhost/bridge1.jpg"></imageTexture>
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
                                    <imageTexture url="http://localhost/banner.jpg"></imageTexture>
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

    <button id="enterFS" onclick="enterFS();">FullScreen</button>
    <button id="enterVR" onclick="onVRRequestPresent();">Enter VR</button>
    <button id="exitVR" onclick="onVRExitPresent();">Exit VR</button>
    <div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Stroubles</h4>
				</div>
				<div class="modal-body">
					<p>Hi! Welcome to Bookmark Mode. In this mode you can cycle through all your saved Bookmarks. To move forward press A and to go back press B!</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>

	<script>
		var count = 0;
		var vrPresentButton = null;
		var vrDisplay = null;
		var gp = null;
		var canvas = document.getElementsByTagName("canvas")[0];
		var presentingMessage = document.getElementById("presenting-message");
		var viewpoint = document.getElementById('vpp');
		var initDone = false;
		var runtime = null;
		var pyr = new x3dom.fields.SFVec3f(0, 0, 0);
		var coordValues = [ 0, 0 ]; //Steps moved, initialized to 0
		var coord = [ "x", "z" ]; //Coordinate axes corresponding to above coordinate values
		var axisID = [ 2, 3 ]; // Gamepad axes IDs: 2 - X axis w.r.t HMD , 3 - Z axis w.r.t HMD, 0 & 1 can be mapped to any other movement
		var prevDirection = 0; //Last direction moved (-1 negative X or Z axis, 1 positive X or Z axis, 0 neutral)
		var prevAxis = -1; // Last axis of gamepad that was moved, initialized to -1. 
		var viewpoint = document.getElementById("vpp");
		var vrB = {};
		$(document).ready(function() {
			$.ajax({
				url : 'http://localhost:8080/Stroubles/getBook3DAll',
				type : 'POST',
				dataType : 'json',
				contentType : 'application/json',
				async : false,
				success : function(data) {
					vrB = data;
				},
			});
			alert(vrB[0].orient1);
		});
		//Poll for VR Displays
		if (navigator.getVRDisplays) {
			navigator
					.getVRDisplays()
					.then(
							function(displays) {
								
								if (displays.length > 0) {
									vrDisplay = displays[0];
									if (canGame()) {
										window.addEventListener(
												"gamepadconnected", function() {
													gp = navigator
															.getGamepads()[0];
													console.log(gp);
												});
									}
									window.addEventListener(
											'vrdisplaypresentchange',
											onVRDisplayPresentChange, false);
									window.addEventListener(
											'vrdisplayactivated',
											onVRRequestPresent, false);
									window.addEventListener(
											'vrdisplaydeactivated',
											onVRExitPresent, false);
								} else {
									console
											.log("WebVR supported, no VR displays found");
								}
							});
		} else if (navigator.getVRDevices) {
			console
					.log("Your browser supports WebVR but not the latest version. See <a href='http://webvr.info'>webvr.info</a> for more info.");
		} else {
			console
					.log("Your browser does not support WebVR. See <a href='http://webvr.info'>webvr.info</a> for assistance.");
		}

		//Full Screen - does nothing except enabling fullscreen
		function enterFS() {
			var canvas = document.getElementsByTagName("canvas")[0];
			console.log(canvas);
			if (canvas.webkitRequestFullscreen) {
				canvas.webkitRequestFullscreen();
			} else if (canvas.mozRequestFullScreen) {
				canvas.mozRequestFullScreen();
			}

		}

		function onVRRequestPresent() {
			// This can only be called in response to a user gesture.      
			var canvas = document.getElementsByTagName("canvas")[0];
			vrDisplay.requestPresent([ {
				source : canvas
			} ]).then(function() {
			}, function() {
				console.log("requestPresent failed");
			});
		}

		function onVRDisplayPresentChange() {
			// When we begin or end presenting, the canvas should be resized to the
			// recommended dimensions for the display.
			onResize();
		}

		function onVRExitPresent() {
			// No sense in exiting presentation if we're not actually presenting.
			// (This may happen if we get an event like vrdisplaydeactivated when
			// we weren't presenting.)
			if (!vrDisplay.isPresenting)
				return;

			vrDisplay.exitPresent().then(function() {
				// Nothing to do because we're handling things in onVRPresentChange.
			}, function() {
				console.log("exitPresent failed.");
			});
		}

		function onResize() {

			if (vrDisplay && vrDisplay.isPresenting) {
				//Enable stereo display
				document.getElementById("stereo")
						.setAttribute("render", "true");
				document.getElementById("root").setAttribute("render", "false");

				runtime = document.getElementById('x3dElement').runtime;
				rtLeft = document.getElementById('rtLeft');
				rtRight = document.getElementById('rtRight');
				lastW = +runtime.getWidth();
				lastH = +runtime.getHeight();
				var hw = Math.round(lastW / 2);
				rtLeft.setAttribute('dimensions', hw + ' ' + lastH + ' 4');
				rtRight.setAttribute('dimensions', hw + ' ' + lastH + ' 4');
				window.addEventListener('resize', onResize);
				requestAnimationFrame(animate);

			} else {
				document.getElementById("stereo").setAttribute("render",
						"false");
				document.getElementById("root").setAttribute("render", "true");
			}
		};

		function animate() {

			if (vrDisplay) {
				//Set Viewpoint according to HMD's position and orientation

				var pose = vrDisplay.getPose();
				var viewpoint = document.getElementById('vpp');
				if (vrDisplay.isPresenting) {
					var orientation = pose.orientation;
					var position = pose.position;
					if (!orientation) {
						orientation = [ 0, 0, 0, 1 ];
					}
					if (!position) {
						position = [ 0, 0, 0 ];
					}
					if (orientation) {
						var q = new x3dom.fields.Quaternion(orientation[0],
								orientation[1], orientation[2], orientation[3]);
						var aa = q.toAxisAngle();
					//	viewpoint.setAttribute("orientation", aa[0].x + " "
					//			+ aa[0].y + " " + aa[0].z + " " + aa[1]);
					}

					if (gp === null) {
						if (position !== null) {
							var posi = viewpoint.requestFieldRef('position');
							
							//The numeric values below are initial viewpoint positions x, y & z
							posi.x = 4.17102 + position[0];
							posi.y = 1.00905 + position[1];
							posi.z = -6.97228 + position[2];
							viewpoint.releaseFieldRef('position');
						}

					} else {
						reportOnGamepad();
						requestAnimationFrame(reportOnGamepad);
					}
					//Submit Frame
					vrDisplay.submitFrame(pose);
				}
				//Set VRDisplay's frame rate
				vrDisplay.requestAnimationFrame(animate);
			}

			else {

				requestAnimationFrame(animate);
			}
		}

		function canGame() {
			return "getGamepads" in navigator;
		}

		//Main Gamepad function
		function reportOnGamepad() {
			var gp = navigator.getGamepads()[0];
			var axis = axisIndex(gp); //Get the gamepad axis which was predominantly moved (abs value > 0.75)
			var arrayIndex = axisID.indexOf(axis);
			var coordVal = arrayIndex !== -1 ? coordValues[arrayIndex] : null; //Get the number of steps moved in that coordinate axis
			var coordName = arrayIndex !== -1 ? coord[arrayIndex] : null; //Get the coordinate axis name
			if (coordVal !== null) {
				//gp.axes[axis] - Movement of gamepad axis from 0 to 1, 0 not moved, 1 fully moved 
				coordVal = move(gp.axes[axis], axis, coordVal); //Function to increase steps/reset along that direction
				coordValues[arrayIndex] = coordVal; //Set the global step count to the latest
				var state = vrDisplay.getPose();
				var vpOrientation = viewpoint.getAttribute("orientation"); //Get current head orientation
				var m = x3dom.fields.Quaternion.parseAxisAngle(vpOrientation)
						.toMatrix();
				var d = convertToVec(coordName, coordVal); //Convert steps into vector
				var cross = m.multMatrixVec(d);
				pyr = pyr.addScaled(cross, 0.001); //0.01 factor to control speed
				var position = state.position;
				//Set the viewpoint w.r.t head orientation
				if (position !== null) {
					var posi = viewpoint.requestFieldRef('position');
					//The numeric values below are initial viewpoint positions x, y & z
					posi.x = 4.17102 + pyr.x + position[0];
					posi.y = 1.00905 + pyr.y + position[1];
					posi.z = -6.97228 + (pyr.z) + position[2];
					viewpoint.releaseFieldRef('position');
				}
			}

			if (buttonPressed(gp.buttons[0])) { //A
				if (count < vrB.length) {
					viewpoint.setAttribute("orientation", vrB[count].orient1 + " "
										+ vrB[count].orient2 + " " + vrB[count].orient3 + " " + vrB[count].orient4);
					count++;
				}
				else {
					count = 0;
				}

			} else if (buttonPressed(gp.buttons[2])) {
				//alert('X');
			}
			if (buttonPressed(gp.buttons[1])) {
				count--;

				if (count >= 0) {
					viewpoint.setAttribute("orientation", vrB[count].orient1 + " "
										+ vrB[count].orient2 + " " + vrB[count].orient3 + " " + vrB[count].orient4);
				}
				else {
					count = vrB.length - 1;
				}
				//alert('B');
			} else if (buttonPressed(gp.buttons[3])) {
				//alert('Y');
			}

		}

		function buttonPressed(b) {
			if (typeof (b) == "object") {
				return b.pressed;
			}
			return b == 1.0;
		}

		//Function returns the Gamepad axis which is moved
		//0.75 is chosen as the threshold heuristically
		function axisIndex(gamepad) {
			for (var i = 0; i < gamepad.axes.length; i++) {
				if (gamepad.axes[i] > 0.75 || gamepad.axes[i] < -0.75) {
					return i;
				}
			}
		}

		//Function increases the step if proceeding in same direction
		//Resets step to zero if direction is changed
		function move(axisValue, axis, coordVal) {
			var direction = axisValue > 0.75 ? direction = 1 : direction = -1; //1 means positive X/Z direction, -1 means negative
			if (prevAxis !== axis) { //Gamepad axis is changed which means change of direction
				coordVal = 0;
			} else {
				if (prevDirection !== direction) { //Same Gamepad axis but changed from pos direction to neg direction / vice versa
					coordVal = 0;
				} else { //Proceeding in same direction as last frame                 
					coordVal = axisValue > 0.75 ? coordVal + 1 : coordVal - 1;
				}
			}
			prevAxis = axis; //Last gamepad axis to current axis
			prevDirection = direction; //Last direction (pos/neg) to current direction
			return coordVal;
		}

		//Convert steps into vector
		function convertToVec(coordName, value) {
			var d = new x3dom.fields.SFVec3f(0, 0, 0);
			switch (coordName) {
			case "x":
				d.x = value;
				break;
			case "z":
				d.z = value;
				break;
			}
			return d;
		}


	</script>
</body>
</html>
