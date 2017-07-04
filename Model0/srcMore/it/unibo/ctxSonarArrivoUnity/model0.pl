%====================================================================================
% Context ctxSonarArrivoUnity  SYSTEM-configuration: file it.unibo.ctxSonarArrivoUnity.model0.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
context(ctxsonararrivounity, "localhost",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarbunity , ctxsonararrivounity, "it.unibo.sonarbunity.MsgHandle_Sonarbunity"   ). %%store msgs 
qactor( sonarbunity_ctrl , ctxsonararrivounity, "it.unibo.sonarbunity.Sonarbunity"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

