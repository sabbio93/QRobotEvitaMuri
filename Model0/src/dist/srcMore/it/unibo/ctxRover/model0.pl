%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.model0.pl 
%====================================================================================
context(ctxrover, "192.168.251.1",  "TCP", "8070" ).  		 
context(ctxsonararrivo, "192.168.251.3",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 
