%====================================================================================
% Context ctxController  SYSTEM-configuration: file it.unibo.ctxController.m11.pl 
%====================================================================================
context(ctxcontroller, "localhost",  "TCP", "8040" ).  		 
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
%%% -------------------------------------------
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs 
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ). 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ). 
