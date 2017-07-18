%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.m4.pl 
%====================================================================================
context(ctxcontroller, "192.168.1.100",  "TCP", "8040" ).  		 
context(ctxsonarfisicoarrivo, "192.168.1.101",  "TCP", "8022" ).  		 
%%% -------------------------------------------
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

