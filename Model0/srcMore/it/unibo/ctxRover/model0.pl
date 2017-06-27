%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.model0.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
context(ctxsonararrivo, "localhost",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
qactor( rilevatorearrivo , ctxsonararrivo, "it.unibo.rilevatorearrivo.MsgHandle_Rilevatorearrivo"   ). %%store msgs 
qactor( rilevatorearrivo_ctrl , ctxsonararrivo, "it.unibo.rilevatorearrivo.Rilevatorearrivo"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

