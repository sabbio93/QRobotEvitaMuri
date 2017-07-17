%====================================================================================
% Context ctxSonarFisicoPartenza  SYSTEM-configuration: file it.unibo.ctxSonarFisicoPartenza.m4.pl 
%====================================================================================
context(ctxrover, "192.168.1.213",  "TCP", "8070" ).  		 
context(ctxsonarfisicoarrivo, "192.168.1.2",  "TCP", "8025" ).  		 
context(ctxsonarfisicopartenza, "192.168.1.6",  "TCP", "8022" ).  		 
%%% -------------------------------------------
qactor( sonarafisico , ctxsonarfisicopartenza, "it.unibo.sonarafisico.MsgHandle_Sonarafisico"   ). %%store msgs 
qactor( sonarafisico_ctrl , ctxsonarfisicopartenza, "it.unibo.sonarafisico.Sonarafisico"   ). %%control-driven 
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

