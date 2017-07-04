%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.model0.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
%%% -------------------------------------------
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

