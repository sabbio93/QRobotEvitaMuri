%====================================================================================
% Context ctxSonarArrivoMock  SYSTEM-configuration: file it.unibo.ctxSonarArrivoMock.model0.pl 
%====================================================================================
context(ctxrover, "192.168.1.213",  "TCP", "8070" ).  		 
context(ctxsonararrivomock, "192.168.1.2",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarbmock , ctxsonararrivomock, "it.unibo.sonarbmock.MsgHandle_Sonarbmock"   ). %%store msgs 
qactor( sonarbmock_ctrl , ctxsonararrivomock, "it.unibo.sonarbmock.Sonarbmock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

