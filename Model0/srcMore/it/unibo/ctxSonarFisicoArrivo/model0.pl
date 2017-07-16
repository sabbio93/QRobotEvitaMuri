%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.model0.pl 
%====================================================================================
context(ctxrover, "192.168.1.213",  "TCP", "8070" ).  		 
context(ctxsonarfisicoarrivo, "192.168.1.221",  "TCP", "8022" ).  		 
%%% -------------------------------------------
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

