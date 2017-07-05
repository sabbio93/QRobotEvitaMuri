%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.m1.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
%%% -------------------------------------------
qactor( robotmind , ctxrover, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxrover, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

