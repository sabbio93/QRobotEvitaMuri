%====================================================================================
% Context ctxSonarPartenzaMock  SYSTEM-configuration: file it.unibo.ctxSonarPartenzaMock.m8.pl 
%====================================================================================
context(ctxsonarpartenzamock, "localhost",  "TCP", "8036" ).  		 
context(ctxcontroller, "192.168.1.2",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonaramock , ctxsonarpartenzamock, "it.unibo.sonaramock.MsgHandle_Sonaramock"   ). %%store msgs 
qactor( sonaramock_ctrl , ctxsonarpartenzamock, "it.unibo.sonaramock.Sonaramock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

