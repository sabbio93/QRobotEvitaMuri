//QActorWebUI.js
var curSpeed = "low";
	
    console.log("QActorWebUI.js : server IP= "+document.location.host);
 /*
 * WEBSOCKET
 */
    var sock = new WebSocket("ws://"+document.location.host, "protocolOne");
    sock.onopen = function (event) {
         console.log("QActorWebUI.js : I am connected to server.....");
    };
    sock.onmessage = function (event) {
        console.log("QActorWebUI.js : "+event.data);
        alert( "onmessage " + event);
        //enable start button
        document.getElementById("startCommand").disable = false;

    }
    sock.onerror = function (error) {
        console.log('WebSocket Error %0',  error);
    };
    
	function send(message) {
		document.getElementById("sending").value = ""+message;
		sock.send(message);
	};
