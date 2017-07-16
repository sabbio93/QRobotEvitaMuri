%====================================================================================
% Context ctxUnity  SYSTEM-configuration: file it.unibo.ctxUnity.model0.pl 
%====================================================================================
context(ctxrover, "192.168.1.213",  "TCP", "8070" ).  		 
context(ctxunity, "192.168.1.2",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarbunity , ctxunity, "it.unibo.sonarbunity.MsgHandle_Sonarbunity"   ). %%store msgs 
qactor( sonarbunity_ctrl , ctxunity, "it.unibo.sonarbunity.Sonarbunity"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

