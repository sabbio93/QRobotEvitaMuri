%====================================================================================
% Context ctxSonarArrivo  SYSTEM-configuration: file it.unibo.ctxSonarArrivo.model0.pl 
%====================================================================================
context(ctxrover, "localhost",  "TCP", "8070" ).  		 
context(ctxsonararrivo, "localhost",  "TCP", "8035" ).  		 
%%% -------------------------------------------
qactor( sonarb , ctxsonararrivo, "it.unibo.sonarb.MsgHandle_Sonarb"   ). %%store msgs 
qactor( sonarb_ctrl , ctxsonararrivo, "it.unibo.sonarb.Sonarb"   ). %%control-driven 
%%% -------------------------------------------
%%% -------------------------------------------

