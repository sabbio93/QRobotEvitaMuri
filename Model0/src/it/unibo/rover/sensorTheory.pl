%==============================================
% sensorTheory.pl for actor rover
%==============================================
%% **** SONAR **** 
sensor( distance(DIST,DIR,POS) ):-
	!, actorobj(Actor),
	( DIST < 20,!,
	  %% Actor <- emit( sensordata, sensordata(distance(DIST,DIR,POS)) ),
	  actorPrintln( distance(DIST,DIR,POS) ) ;
	  true ).
%% **** MAGNETOMETER **** 
sensor(  magnetometer(x(VX),y(VY),z(VZ),POS) ):-
	 !, actorobj(Actor),
	 %% Actor <- emit( sensordata, sensordata(magnetometer(x(VX),y(VY),z(VZ),POS)) ),
	 actorPrintln( magnetometer(x(VX),y(VY),z(VZ),POS) ).
%% **** LINE DETECTO **** 
sensor(  line( V,POS) ):-
	 !, actorobj(Actor),
	 %% Actor <- emit( sensordata, sensordata(line(V,POS)) ),
	 actorPrintln( line( V,POS) ).

sensor( X ):-
	actorPrintln( X ).
	
/*
------------------------------------------------------------
initialize
------------------------------------------------------------
*/
initSensorTheory  :-  
	actorobj(Actor),
 	( Actor <- isSimpleActor returns R, R=true, !,
	  actorPrintln(" *** sensorTheory loaded FOR ACTORS ONLY  ***  ");
	  actorPrintln(" *** sensorTheory loaded FOR ROBOTS  *** ")
	).
 
:- initialization(initSensorTheory). 
