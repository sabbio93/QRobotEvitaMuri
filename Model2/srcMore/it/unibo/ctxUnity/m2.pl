%====================================================================================
% Context ctxUnity  SYSTEM-configuration: file it.unibo.ctxUnity.m2.pl 
%====================================================================================
context(ctxunity, "192.168.1.100",  "TCP", "8035" ).  		 
context(ctxcontroller, "10.103.65.64",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbunity , ctxunity, "it.unibo.sonarbunity.MsgHandle_Sonarbunity"   ). %%store msgs 
qactor( sonarbunity_ctrl , ctxunity, "it.unibo.sonarbunity.Sonarbunity"   ). %%control-driven 
qactor( sonaraunity , ctxunity, "it.unibo.sonaraunity.MsgHandle_Sonaraunity"   ). %%store msgs 
qactor( sonaraunity_ctrl , ctxunity, "it.unibo.sonaraunity.Sonaraunity"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

