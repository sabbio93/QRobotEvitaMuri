%====================================================================================
% Context ctxSonarPartenzaMock  SYSTEM-configuration: file it.unibo.ctxSonarPartenzaMock.m4.pl 
%====================================================================================
context(ctxsonarpartenzamock, "10.103.65.64",  "TCP", "8036" ).  		 
context(ctxcontroller, "10.103.65.64",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonaramock , ctxsonarpartenzamock, "it.unibo.sonaramock.MsgHandle_Sonaramock"   ). %%store msgs 
qactor( sonaramock_ctrl , ctxsonarpartenzamock, "it.unibo.sonaramock.Sonaramock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

