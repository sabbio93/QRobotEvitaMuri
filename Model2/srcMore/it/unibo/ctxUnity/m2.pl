%====================================================================================
% Context ctxUnity  SYSTEM-configuration: file it.unibo.ctxUnity.m2.pl 
%====================================================================================
context(ctxunity, "localhost",  "TCP", "8035" ).  		 
context(ctxcontroller, "localhost",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbunity , ctxunity, "it.unibo.sonarbunity.MsgHandle_Sonarbunity"   ). %%store msgs 
qactor( sonarbunity_ctrl , ctxunity, "it.unibo.sonarbunity.Sonarbunity"   ). %%control-driven 
qactor( sonaraunity , ctxunity, "it.unibo.sonaraunity.MsgHandle_Sonaraunity"   ). %%store msgs 
qactor( sonaraunity_ctrl , ctxunity, "it.unibo.sonaraunity.Sonaraunity"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

