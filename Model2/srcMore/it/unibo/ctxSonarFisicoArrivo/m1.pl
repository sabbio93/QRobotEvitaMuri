%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.m1.pl 
%====================================================================================
context(ctxcontroller, "10.103.65.64",  "TCP", "8040" ).  		 
context(ctxsonarfisicoarrivo, "192.168.1.105",  "TCP", "8022" ).  		 
%%% -------------------------------------------
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

