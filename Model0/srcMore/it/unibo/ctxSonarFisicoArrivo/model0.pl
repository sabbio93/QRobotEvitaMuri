%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.model0.pl 
%====================================================================================
context(ctxsonarfisicoarrivo, "192.168.1.2",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

