%====================================================================================
% Context ctxSonarPartenza  SYSTEM-configuration: file it.unibo.ctxSonarPartenza.m2.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
context(ctxcontroller, "localhost",  "TCP", "8040" ).  		 
context(ctxsonararrivo, "192.168.251.3",  "TCP", "8035" ).  		 
context(ctxsonarpartenza, "192.168.251.4",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
qactor( sonara , ctxsonarpartenza, "it.unibo.sonara.MsgHandle_Sonara"   ). %%store msgs 
qactor( sonara_ctrl , ctxsonarpartenza, "it.unibo.sonara.Sonara"   ). %%control-driven 
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

