%====================================================================================
% Context ctxSonarPublisher  SYSTEM-configuration: file it.unibo.ctxSonarPublisher.sonarPublisher.pl 
%====================================================================================
context(ctxsonarpublisher, "192.168.43.229",  "TCP", "8143" ).  		 
%%% -------------------------------------------
qactor( sonarpublisher , ctxsonarpublisher, "it.unibo.sonarpublisher.MsgHandle_Sonarpublisher"   ). %%store msgs 
qactor( sonarpublisher_ctrl , ctxsonarpublisher, "it.unibo.sonarpublisher.Sonarpublisher"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

