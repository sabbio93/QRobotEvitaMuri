%====================================================================================
% Context ctxSonarArrivoMoc  SYSTEM-configuration: file it.unibo.ctxSonarArrivoMoc.m1.pl 
%====================================================================================
context(ctxrover, "192.168.251.1",  "TCP", "8070" ).  		 
context(ctxsonararrivomoc, "192.168.251.3",  "TCP", "8035" ).  		 
context(ctxsonarpartenzamoc, "192.168.251.4",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( mocsonarb , ctxsonararrivomoc, "it.unibo.mocsonarb.MsgHandle_Mocsonarb"   ). %%store msgs 
qactor( mocsonarb_ctrl , ctxsonararrivomoc, "it.unibo.mocsonarb.Mocsonarb"   ). %%control-driven 
qactor( mocsonara , ctxsonarpartenzamoc, "it.unibo.mocsonara.MsgHandle_Mocsonara"   ). %%store msgs 
qactor( mocsonara_ctrl , ctxsonarpartenzamoc, "it.unibo.mocsonara.Mocsonara"   ). %%control-driven 
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover"   ). %%store msgs 
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

