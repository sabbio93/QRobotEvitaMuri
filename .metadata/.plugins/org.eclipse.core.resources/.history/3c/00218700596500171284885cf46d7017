%====================================================================================
% Context ctxController  SYSTEM-configuration: file it.unibo.ctxController.m1.pl 
%====================================================================================
context(ctxrover, "192.168.137.2",  "TCP", "8070" ).  		 
context(ctxcontroller, "192.168.137.1",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 

