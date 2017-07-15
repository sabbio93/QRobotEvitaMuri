%====================================================================================
% Context ctxRadarAnotherSourceMock  SYSTEM-configuration: file it.unibo.ctxRadarAnotherSourceMock.radarAnotherSourceMock.pl 
%====================================================================================
context(ctxradar, "localhost",  "TCP", "8033" ).  		 
context(ctxradaranothersourcemock, "localhost",  "TCP", "8157" ).  		 
%%% -------------------------------------------
qactor( radaranothersourcemock , ctxradaranothersourcemock, "it.unibo.radaranothersourcemock.MsgHandle_Radaranothersourcemock"   ). %%store msgs 
qactor( radaranothersourcemock_ctrl , ctxradaranothersourcemock, "it.unibo.radaranothersourcemock.Radaranothersourcemock"   ). %%control-driven 
%%% -------------------------------------------
eventhandler(evh,ctxradaranothersourcemock,"it.unibo.ctxRadarAnotherSourceMock.Evh","inputcmd").  
%%% -------------------------------------------

