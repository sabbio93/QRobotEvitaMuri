%====================================================================================
% Context ctxSonarArrivoUnity  SYSTEM-configuration: file it.unibo.ctxSonarArrivoUnity.m2.pl 
%====================================================================================
context(ctxsonararrivounity, "localhost",  "TCP", "8035" ).  		 
context(ctxsonarpartenzaunity, "localhost",  "TCP", "8036" ).  		 
context(ctxcontroller, "localhost",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( sonarbunity , ctxsonararrivounity, "it.unibo.sonarbunity.MsgHandle_Sonarbunity"   ). %%store msgs 
qactor( sonarbunity_ctrl , ctxsonararrivounity, "it.unibo.sonarbunity.Sonarbunity"   ). %%control-driven 
qactor( sonaraunity , ctxsonarpartenzaunity, "it.unibo.sonaraunity.MsgHandle_Sonaraunity"   ). %%store msgs 
qactor( sonaraunity_ctrl , ctxsonarpartenzaunity, "it.unibo.sonaraunity.Sonaraunity"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

