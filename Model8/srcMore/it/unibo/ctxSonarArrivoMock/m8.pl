%====================================================================================
% Context ctxSonarArrivoMock  SYSTEM-configuration: file it.unibo.ctxSonarArrivoMock.m8.pl 
%====================================================================================
context(ctxsonararrivomock, "localhost",  "TCP", "8035" ).  		 
context(ctxcontroller, "192.168.1.2",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbmock , ctxsonararrivomock, "it.unibo.sonarbmock.MsgHandle_Sonarbmock"   ). %%store msgs 
qactor( sonarbmock_ctrl , ctxsonararrivomock, "it.unibo.sonarbmock.Sonarbmock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

