%====================================================================================
% Context ctxSonarFisicoArrivo  SYSTEM-configuration: file it.unibo.ctxSonarFisicoArrivo.m2.pl 
%====================================================================================
context(ctxrover, "192.168.1.101",  "TCP", "8070" ).  		 
context(ctxsonarfisicoarrivo, "192.168.1.105",  "TCP", "8022" ).  		 
context(ctxsonarfisicopartenza, "192.168.1.5",  "TCP", "8021" ).  		 
%%% -------------------------------------------
qactor( sonarafisico , ctxsonarfisicopartenza, "it.unibo.sonarafisico.MsgHandle_Sonarafisico"   ). %%store msgs 
qactor( sonarafisico_ctrl , ctxsonarfisicopartenza, "it.unibo.sonarafisico.Sonarafisico"   ). %%control-driven 
qactor( sonarbfisico , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.MsgHandle_Sonarbfisico"   ). %%store msgs 
qactor( sonarbfisico_ctrl , ctxsonarfisicoarrivo, "it.unibo.sonarbfisico.Sonarbfisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

