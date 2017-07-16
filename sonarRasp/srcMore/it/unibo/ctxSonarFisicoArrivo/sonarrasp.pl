%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.sonarRasp.pl 
%====================================================================================
context(ctxsonarfisicoarrivo, "localhost",  "TCP", "8133" ).  		 
%%% -------------------------------------------
qactor( sonarrasp , ctxsonarfisicoarrivo, "it.unibo.sonarrasp.MsgHandle_Sonarrasp"   ). %%store msgs 
qactor( sonarrasp_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarrasp.Sonarrasp"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

