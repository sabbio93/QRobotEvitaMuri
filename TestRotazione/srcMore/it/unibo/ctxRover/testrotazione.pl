%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.testrotazione.pl 
%====================================================================================
context(ctxrover, "locahost",  "TCP", "11070" ).  		 
%%% -------------------------------------------
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

