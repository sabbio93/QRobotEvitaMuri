%====================================================================================
% Context ctxSonarArrivoMock  SYSTEM-configuration: file it.unibo.ctxSonarArrivoMock.model0.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
context(ctxsonararrivomock, "localhost",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarbmock , ctxsonararrivomock, "it.unibo.sonarbmock.MsgHandle_Sonarbmock"   ). %%store msgs 
qactor( sonarbmock_ctrl , ctxsonararrivomock, "it.unibo.sonarbmock.Sonarbmock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

