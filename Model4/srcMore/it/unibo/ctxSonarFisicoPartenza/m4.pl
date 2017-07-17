%====================================================================================
% Context ctxSonarFisicoPartenza  SYSTEM-configuration: file it.unibo.ctxSonarFisicoPartenza.m4.pl 
%====================================================================================
context(ctxcontroller, "192.168.1.2",  "TCP", "8070" ).  		 
context(ctxsonarfisicopartenza, "192.168.1.6",  "TCP", "8022" ).  		 
%%% -------------------------------------------
qactor( sonarafisico , ctxsonarfisicopartenza, "it.unibo.sonarafisico.MsgHandle_Sonarafisico"   ). %%store msgs 
qactor( sonarafisico_ctrl , ctxsonarfisicopartenza, "it.unibo.sonarafisico.Sonarafisico"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

