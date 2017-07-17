%====================================================================================
% Context ctxSonarArrivoMock  SYSTEM-configuration: file it.unibo.ctxSonarArrivoMock.m6.pl 
%====================================================================================
context(ctxsonararrivomock, "192.168.1.2",  "TCP", "8037" ).  		 
context(ctxsonarpartenzamock, "192.168.1.2",  "TCP", "8036" ).  		 
context(ctxcontroller, "192.168.1.2",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbmock , ctxsonararrivomock, "it.unibo.sonarbmock.MsgHandle_Sonarbmock"   ). %%store msgs 
qactor( sonarbmock_ctrl , ctxsonararrivomock, "it.unibo.sonarbmock.Sonarbmock"   ). %%control-driven 
qactor( sonaramock , ctxsonarpartenzamock, "it.unibo.sonaramock.MsgHandle_Sonaramock"   ). %%store msgs 
qactor( sonaramock_ctrl , ctxsonarpartenzamock, "it.unibo.sonaramock.Sonaramock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

