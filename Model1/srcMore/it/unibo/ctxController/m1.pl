%====================================================================================
% Context ctxController  SYSTEM-configuration: file it.unibo.ctxController.m1.pl 
%====================================================================================
context(ctxrover, "192.168.251.1",  "TCP", "8070" ).  		 
context(ctxsonararrivo, "192.168.251.3",  "TCP", "8035" ).  		 
context(ctxsonarpartenza, "192.168.251.4",  "TCP", "8035" ).  		 
context(ctxcontroller, "127.0.0.1",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( mocsonarb , ctxsonararrivo, "it.unibo.mocsonarb.MsgHandle_Mocsonarb"   ). %%store msgs 
qactor( mocsonarb_ctrl , ctxsonararrivo, "it.unibo.mocsonarb.Mocsonarb"   ). %%control-driven 
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
qactor( sonara , ctxsonarpartenza, "it.unibo.sonara.MsgHandle_Sonara"   ). %%store msgs 
qactor( sonara_ctrl , ctxsonarpartenza, "it.unibo.sonara.Sonara"   ). %%control-driven 
qactor( mocsonara , ctxsonarpartenza, "it.unibo.mocsonara.MsgHandle_Mocsonara"   ). %%store msgs 
qactor( mocsonara_ctrl , ctxsonarpartenza, "it.unibo.mocsonara.Mocsonara"   ). %%control-driven 
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover"   ). %%store msgs 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

