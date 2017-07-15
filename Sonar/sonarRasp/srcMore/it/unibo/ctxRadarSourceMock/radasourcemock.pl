%====================================================================================
% Context ctxRadarSourceMock  SYSTEM-configuration: file it.unibo.ctxRadarSourceMock.radaSourceMock.pl 
%====================================================================================
context(ctxradar, "localhost",  "TCP", "8033" ).  		 
context(ctxradarsourcemock, "localhost",  "TCP", "8137" ).  		 
%%% -------------------------------------------
qactor( radasourcemock , ctxradarsourcemock, "it.unibo.radasourcemock.MsgHandle_Radasourcemock"   ). %%store msgs 
qactor( radasourcemock_ctrl , ctxradarsourcemock, "it.unibo.radasourcemock.Radasourcemock"   ). %%control-driven 
qactor( radargui , ctxradar, "it.unibo.radargui.MsgHandle_Radargui"   ). %%store msgs 
qactor( radargui_ctrl , ctxradar, "it.unibo.radargui.Radargui"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

