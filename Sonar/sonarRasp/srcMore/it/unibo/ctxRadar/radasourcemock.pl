%====================================================================================
% Context ctxRadar standalone= SYSTEM-configuration: file it.unibo.ctxRadar.radaSourceMock.pl 
%====================================================================================
context(ctxradar, "localhost",  "TCP", "8033" ).  		 
%%% -------------------------------------------
qactor( radargui , ctxradar, "it.unibo.radargui.MsgHandle_Radargui"   ). %%store msgs 
qactor( radargui_ctrl , ctxradar, "it.unibo.radargui.Radargui"   ). %%control-driven 
