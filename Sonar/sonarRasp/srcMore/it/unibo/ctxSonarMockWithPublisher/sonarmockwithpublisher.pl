%====================================================================================
% Context ctxSonarMockWithPublisher  SYSTEM-configuration: file it.unibo.ctxSonarMockWithPublisher.sonarMockWithPublisher.pl 
%====================================================================================
context(ctxsonarmockwithpublisher, "localhost",  "TCP", "8133" ).  		 
context(ctxsonarpublisher, "localhost",  "TCP", "8143" ).  		 
%%% -------------------------------------------
qactor( sonarmockwithpublisher , ctxsonarmockwithpublisher, "it.unibo.sonarmockwithpublisher.MsgHandle_Sonarmockwithpublisher"   ). %%store msgs 
qactor( sonarmockwithpublisher_ctrl , ctxsonarmockwithpublisher, "it.unibo.sonarmockwithpublisher.Sonarmockwithpublisher"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

