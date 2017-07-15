%====================================================================================
% Context ctxSonarMock  SYSTEM-configuration: file it.unibo.ctxSonarMock.sonarMock.pl 
%====================================================================================
context(ctxsonarmock, "localhost",  "TCP", "8133" ).  		 
%%% -------------------------------------------
qactor( sonarmock , ctxsonarmock, "it.unibo.sonarmock.MsgHandle_Sonarmock"   ). %%store msgs 
qactor( sonarmock_ctrl , ctxsonarmock, "it.unibo.sonarmock.Sonarmock"   ). %%control-driven 
qactor( sonarobserver , ctxsonarmock, "it.unibo.sonarobserver.MsgHandle_Sonarobserver"   ). %%store msgs 
qactor( sonarobserver_ctrl , ctxsonarmock, "it.unibo.sonarobserver.Sonarobserver"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

