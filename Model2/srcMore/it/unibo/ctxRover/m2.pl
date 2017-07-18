%====================================================================================
% Context ctxRover  SYSTEM-configuration: file it.unibo.ctxRover.m2.pl 
%====================================================================================
context(ctxcontroller, "10.103.65.64",  "TCP", "8040" ).  		 
context(ctxrover, "192.168.1.101",  "TCP", "8070" ).  		 
%%% -------------------------------------------
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

