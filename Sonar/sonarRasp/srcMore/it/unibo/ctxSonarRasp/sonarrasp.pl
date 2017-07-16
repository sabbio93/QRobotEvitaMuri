%====================================================================================
% Context ctxSonarRasp  SYSTEM-configuration: file it.unibo.ctxSonarRasp.sonarRasp.pl 
%====================================================================================
context(ctxsonarrasp, "localhost",  "TCP", "8133" ).  		 
%%% -------------------------------------------
qactor( sonarrasp , ctxsonarrasp, "it.unibo.sonarrasp.MsgHandle_Sonarrasp"   ). %%store msgs 
qactor( sonarrasp_ctrl , ctxsonarrasp, "it.unibo.sonarrasp.Sonarrasp"   ). %%control-driven 
qactor( sonarraspobserver , ctxsonarrasp, "it.unibo.sonarraspobserver.MsgHandle_Sonarraspobserver"   ). %%store msgs 
qactor( sonarraspobserver_ctrl , ctxsonarrasp, "it.unibo.sonarraspobserver.Sonarraspobserver"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

