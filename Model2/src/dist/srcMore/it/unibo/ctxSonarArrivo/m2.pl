%====================================================================================
% Context ctxSonarArrivo  SYSTEM-configuration: file it.unibo.ctxSonarArrivo.m2.pl 
%====================================================================================
context(ctxrover, "192.168.251.1",  "TCP", "8070" ).  		 
context(ctxsonararrivo, "192.168.251.3",  "TCP", "8035" ).  		 
context(ctxsonarpartenza, "192.168.251.4",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
qactor( sonara , ctxsonarpartenza, "it.unibo.sonara.MsgHandle_Sonara"   ). %%store msgs 
qactor( sonara_ctrl , ctxsonarpartenza, "it.unibo.sonara.Sonara"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

