%====================================================================================
% Context ctxSonarPartenzaMock  SYSTEM-configuration: file it.unibo.ctxSonarPartenzaMock.m2.pl 
%====================================================================================
context(ctxsonararrivomock, "localhost",  "TCP", "8035" ).  		 
context(ctxsonarpartenzamock, "localhost",  "TCP", "8036" ).  		 
context(ctxcontroller, "localhost",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbmock , ctxsonararrivomock, "it.unibo.sonarbmock.MsgHandle_Sonarbmock"   ). %%store msgs 
qactor( sonarbmock_ctrl , ctxsonararrivomock, "it.unibo.sonarbmock.Sonarbmock"   ). %%control-driven 
qactor( sonaramock , ctxsonarpartenzamock, "it.unibo.sonaramock.MsgHandle_Sonaramock"   ). %%store msgs 
qactor( sonaramock_ctrl , ctxsonarpartenzamock, "it.unibo.sonaramock.Sonaramock"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

