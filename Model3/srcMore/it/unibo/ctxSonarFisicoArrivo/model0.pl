%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.model0.pl 
%====================================================================================
context(ctxrover, "192.168.137.2",  "TCP", "8070" ).  		 
context(ctxsonarfisicoarrivo, "192.168.137.6",  "TCP", "8022" ).  		 
context(ctxsonarfisicopartenza, "192.168.137.5",  "TCP", "8021" ).  		 
%%% -------------------------------------------
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
qactor( sonarafisico , ctxsonarfisicopartenza, "it.unibo.sonarafisico.MsgHandle_Sonarafisico"   ). %%store msgs 
qactor( sonarafisico_ctrl , ctxsonarfisicopartenza, "it.unibo.sonarafisico.Sonarafisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

