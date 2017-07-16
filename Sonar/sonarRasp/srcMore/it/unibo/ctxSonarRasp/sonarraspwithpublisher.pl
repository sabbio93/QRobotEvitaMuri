%====================================================================================
% Context ctxSonarRasp  SYSTEM-configuration: file it.unibo.ctxSonarRasp.sonarRaspWithPublisher.pl 
%====================================================================================
context(ctxsonarpublisherwithpublisher, "192.168.43.229",  "TCP", "8143" ).  		 
context(ctxsonarrasp, "192.168.43.66",  "TCP", "8133" ).  		 
%%% -------------------------------------------
qactor( sonarraspwithpublisher , ctxsonarrasp, "it.unibo.sonarraspwithpublisher.MsgHandle_Sonarraspwithpublisher"   ). %%store msgs 
qactor( sonarraspwithpublisher_ctrl , ctxsonarrasp, "it.unibo.sonarraspwithpublisher.Sonarraspwithpublisher"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

