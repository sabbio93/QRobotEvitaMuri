%==============================================
% WorldTheory.pl for actor sonara
%==============================================
/*
For a QActor as a singleton statically degined in the model
*/
myname(qatusonara).	%%old version (deprecated)
actorobj(qatusonara).	%% see registerActorInProlog18 in QActor

/*
For a QActor instance of name=Name dynamically created
*/
setActorName( Name ):-
	retract( myname(X) ),
	retract( actorobj(X) ),
	text_term( TS,Name ),
	text_concat("qatu",TS,NN),
	assert( myname(NN) ),
	assert( actorobj(NN) ).
createActor(Name, Class, NewActor):-
 	actorobj(A),
	A <- getName returns CurActorName,
 	A <- getContext  returns Ctx,
	A <- getOutputEnvView returns View,
 	Ctx <- addInstance(Name),  
  	java_object(Class, [Name,Ctx,View], NewActor),
 	NewActor <-  getName returns NewActorName,
	actorPrintln( createActor(NewActorName, NewActor) ).
/*
Name generator
*/	
value(nameCounter,0). 
newName( Prot, Name,N1 ) :-
	inc(nameCounter,1,N1),
	text_term(N1S,N1),
	text_term(ProtS,Prot),
 	text_concat(ProtS,N1S,Name),
	assert( instance( Prot, N1, Name ) ),
	actorPrintln( newname(Name,N1) ) .

	
setPrologResult( Res ):-
	( retract( goalResult( _ ) ),!; true ),	%%remove previous goalResult (if any) 
	assert( goalResult(Res) ).
setTimeOut( tout( EV, A ) ):-
	( retract( tout( _._ ) ),!; true ),		    %%remove previous tout (if any) 
	assert( tout( EV, A ) ).

addRule( Rule ):-
	%%output( addRule( Rule ) ),
	assert( Rule ).
removeRule( Rule ):-
	retract( Rule ),
	%%output( removedFact(Rule) ),
	!.
removeRule( A  ):- 
	%%output( remove(A) ),
	retract( A :- B ),!.
removeRule( _  ).

setResult( A ):-
 	( retract( result( _ ) ),!; true ), %%remove previous result (if any)	
	assert( result( A ) ).

evalGuard( not(G) ) :-
	G, !, fail .
evalGuard( not(G) ):- !.
evalGuard( true ) :- !.
evalGuard( G ) :-  
	%stdout <- println( evalGuard( G ) ),
	G . 

output( M ):-stdout <- println( M ).
%-------------------------------------------------
%  TuProlo FEATURES of the QActor sonara
%-------------------------------------------------
dialog( FileName ) :-  
	java_object('javax.swing.JFileChooser', [], Dialog),
	Dialog <- showOpenDialog(_),
	Dialog <- getSelectedFile returns File,
	File <- getName returns FileName. 		 

%% :- stdout <- println(  "hello from world theory of sonara" ). 

%-------------------------------------------------
%  UTILITIES for TuProlog computations
%-------------------------------------------------
loop( N,Op ) :- 
	assign(loopcount,1),
	loop(loopcount,N,Op).

loop(I,N,Op) :-  
		value(I,V),
		%actorPrintln( values( I,V,N,Op ) ),
 		V =< N ,!,  
   		%actorPrintln( loop( I,V ) ),
      	actorOp(  Op  ) ,
		V1 is V + 1 ,
		assign(I,V1) ,   
		loop(I,N,Op).	%%tail recursion
loop(I,N,Op).

getVal( I, V ):-
	value(I,V).

assign( I,V ):-
	retract( value(I,_) ),!,
	assert( value( I,V )).
assign( I,V ):-
	assert( value( I,V )).

inc(I,K,N):-
	value( I,V ),
	N is V + K,
	assign( I,N ).

actorPrintln( X ):- actorobj(A), text_term(XS,X), A  <- println( XS ).

%-------------------------------------------------
%  User static rules about sonara
%------------------------------------------------- 
/*
------------------------------------------------------------------------
testex :- actorPrintln( testex ),
java_catch(
	java_object('Counter', ['MyCounter'], c),
	%% java_object('java.util.ArrayList', [], l),
	[ (EEE,              actorPrintln( a )) ],
	  %% ('java.lang.Exception'(Cause, Message, _),              actorPrintln( b )),
	  %% ('java.lang.ClassNotFoundException'(Cause, Message, _), actorPrintln( c ))  ],
	actorPrintln( d )
).
------------------------------------------------------------------------
*/
loadTheory(T):-
 	%% actorPrintln( loadTheory(T) ),
	consult(T), !.
loadTheory(T):-
	actorPrintln( loadTheory(T, FAILURE) ).
		
actorOp( Op )   :- actorobj(Actor),
				   % actorPrintln( actorOp( Op  ) ),
				   java_catch(
						Actor <- Op returns R, 	%% R unbound if void
 						[ ( E, setActorOpResult( Op,failure ), fail )],  				
  						setActorOpResult( Op,R )				%%executed in any way
					). 
actionResultOp( Op ):-
					% actorPrintln( actionResultOp( Op  ) ),
				   java_catch(
				   		%% actoropresult is bound to actorOp result (registered by Actor<-setActionResult)
						actoropresult <- Op returns R, 	%% R unbound if void
 						[ ( E, setActorOpResult( Op,failure ), fail )],  
  						setActorOpResult( Op,R )				%%executed in any way
					). 

%% setActorOpResulttt(Op, V ):-  actorPrintln( setActorOpResulttt(Op, V ) ),setActorOpResult( Op, V ).
setActorOpResult( Op, V ):-   unbound(V),!, storeActorOpResult( Op,void  ).	  
setActorOpResult( Op, Res ):- text_term(Res,Term),!,storeActorOpResult( Op,Term  ).
setActorOpResult( Op, Res ):- %% Res is $obj_xxx	
	cvtToString(Res,ResStr),
	%% actorPrintln( actorOpDone( Op,ResStr  ) ),  
   	storeActorOpResult( Op, ResStr ).
storeActorOpResult( Op, R ):-
	%% actorPrintln( storeActorOpResult( Op,R  ) ),  
	( retract( actorOpDone( _,_ ) ),!; true ), %%remove previous actionResult (if any) 
	assert( actorOpDone( Op, R) ).


%% setActionResult : Actor register (in Java) the result under name 'actoropresult'
cvtToString( true , "true" ):-  %% true is the result of robot move operation
	setResult(true).
cvtToString( false , "false" ):-   
	setResult(false).
cvtToString( V , "void" ):-  
	unbound(V),!,
	actorobj(Actor),
	Actor <-  setActionResult( void ).
cvtToString( V , S ):-
	number(V),!,
	setResult(V),
	text_term( S, V ).
cvtToString( V , S ):-
	( retract( result(_) ),!; true ),		%eliminate any previous numeric result
	V <- toString returns S,
	actorobj(Actor),
	Actor <- setActionResult( V ),
	!.
actorOpResult( V )   :- result(V),!.	
actorOpResult( Res ) :- actoropresult <- toString returns Res, !.
%% actorOpResult( "" ).

androidConsult(T) :- actorobj(Actor), Actor <- androidConsult(T), !.
androidConsult(T) :- actorPrintln( failure(androidConsult) ).

/*
======================================================================
PLANS
======================================================================
*/
%%% ---------  runPlan	---------------	
runPlan(P):-
	actorobj(Actor),
	execPlan(Actor,P,1).
execPlan(Actor,P,PC) :-
	plan(PC, P, S) ,
	%% actorPrintln( execPlan(S) ),
	(   runTheSentence(Actor,S),!
 	    ; true ), %%failure should be related to guards
	PC1 is PC + 1,
	execPlan(Actor,P,PC1).
execPlan(_,_,_).

%%% --------- loadPlan	--------------- 	
loadPlan( FName ):-
	actorobj(Actor),
	Actor <-  consultFromFile(  FName  ).

%%% ---------  Showplan	---------------		
executeCmd( Actor, move(showplan,P), Events, Plans ):-
	%% actorPrintln( showPlan(P) ),
	showPlan(P ).
showPlan( P ):-
	showPlan( P,1 ).
showPlan( P, PC ):-
	plan(PC, P, S) ,!,
	actorPrintln(  plan(PC, P, S )  ),
	PC1 is PC + 1,
	showPlan( P, PC1 ).
showPlan( _,_ ).

showPlan :-
	curPlan(P),
	showPlan(P).

%%% --------- storePlan	--------------- 	
storePlan( FName,P ):-
	actorobj( Actor ), 
	%% actorPrintln( storePlan( Actor, FName, P) ),
 	bagof( plan(PC, P, S) , plan(PC, pdefault, S) , L ),
	%% actorPrintln( storePlan( Actor , FName, L) ),
	Actor <-  writeListInFile( FName ,L ).

%%% --------- clearPlan	--------------- 	
clearPlan :-
	curPlan(P),
	%% class("it.unibo.robot.interpreter.RobotInterpreter") <- clearPC , 
	retractall( plan(PC, P, S) ),
	actorPrintln( clearPlan( P,done ) ).

/*
======================================================================
SENTENCES
======================================================================
*/
runTheSentence(Actor, sentence( not GUARD, MOVE, EVENTS, PLANS ) ):-
	GUARD , !, setAnswer( failure  ) .	
runTheSentence(Actor, sentence( not GUARD, MOVE, EVENTS, PLANS ) ):-
	!, runTheSentence(Actor, sentence( true, MOVE, EVENTS, PLANS ) ).
runTheSentence(Actor, sentence( GUARD, MOVE, EVENTS, PLANS ) ):-
 	 %% actorPrintln(  runTheSentence111( GUARD, MOVE, EVENTS, PLANS ) ),
  	( GUARD = - G , !, retract(G),  ! ; GUARD, ! ),
 	 %% actorPrintln(  sentence4( GUARD, MOVE, EVENTS, PLANS ) ),
  	( executeCmd(Actor, MOVE, EVENTS, PLANS, RESULT), !,
  	  %% actorPrintln(  sentence4(RESULT) ),	
  	  setAnswer( RESULT  );	  
  	  %% actorPrintln(  sentence4( failure ) ),
  	  setAnswer( done(MOVE,failure)  )
  	). 
runTheSentence(Actor, sentence( GUARD, MOVE, EVENTS, PLANS ) ):-   
	setAnswer( guard(GUARD,failed)  ).
runTheSentence(Actor, sentence( GUARD, GOAL, ANSWEREV  ) ) :- 
	%%actorPrintln(  goingToexecuteCmd( Actor, GOAL , ANSWEREV , RES) ),
	executeCmd( Actor, GOAL , ANSWEREV , RES ),
	setAnswer(RES). 

/*
-----------------------------------
Not implemented actions
-----------------------------------
*/	 
 
runTheSentence(Actor, sentence( GUARD, GOAL, DURATION, ANSWEREV, EVENTS, PLANS ) ) :-
 	actorPrintln(  "WARNING: actions asynchronous and reactive not implemented" ).
%% perhaps to remove  
solvePrologRule(GOAL):-
	actorPrintln(  solvePrologRule(GOAL) ),
	GOAL,!,
	setAnswer( GOAL  ).
solvePrologRule(GOAL):-
	%% actorPrintln(  sentence6sprry( GOAL  ) ),
	setAnswer( done(GOAL,failure)  ).

result("noresultyet").

%% Store answer (singleton) to current command
setAnswer( A ):-
	( retract( answer( _ ) ),!; true ),		    %%remove previous answer (if any)
	( retract( result( _ ) ),!; true ),		    %%remove previous result (if any)	
	addRule( result( A ) ),
 	addRule( answer( result(A) ) ).	

/*
======================================================================
MOVES
======================================================================
*/
%%% ---------  Actor move	---------------
executeCmd( Actor, move(robotmove,CMD,SPEED,DURATION,ANGLE), ENDEV, RES ):-
 	!,
 	mapCmdToMove(CMD,MOVE), 
	%% actorPrintln(  executeCmd(Actor,MOVE, SPEED, ANGLE, DURATION, ENDEV ) ),
	Actor <- execute(MOVE, SPEED, ANGLE, DURATION, ENDEV, '', '') returns AAR,
	AAR <- getResult returns RES.
executeCmd( Actor, move(robotmove,CMD,SPEED,DURATION,ANGLE), Events, Plans, RES ):-
 	!,
 	mapCmdToMove(CMD,MOVE), 
	%% actorPrintln(  executeCmd(Actor,MOVE, SPEED, ANGLE, DURATION, Events, Plans) ),
	Actor <- execute(MOVE, SPEED, ANGLE, DURATION, Events, Plans) returns AAR,
	AAR <- getResult returns RES.

%%% ---------  Play sound	---------------
executeCmd( Actor,  move(playsound,FNAME,DURATION), Events, Plans, RES ):-
	%% actorPrintln(  executeCmd(Actor, playsound1( FNAME,DURATION ), Events, Plans) ),
	!,
	Actor <- playSound( FNAME, DURATION, Events, Plans ) returns AAR,
	AAR <- getResult returns RES.
executeCmd( Actor,  move(playsound,FNAME,DURATION,ENDEVENT), Events, Plans, RES ):-
	%% actorPrintln(  executeCmd(Actor, move(playsound,FNAME,DURATION,ENDEVENT), Events, Plans) ),
	!,
	Actor <- playSound( FNAME, ENDEVENT, DURATION  ) returns AAR,
	AAR <- getResult returns RES.

%%% --------- Photo	---------------
executeCmd( Actor,  move( photo(DURATION,FNAME,ANSWEREVENT) ), Events, Plans, done(photo,FNAME) ):-
	%% actorPrintln(  executeCmd(Actor, photo( DURATION,FNAME,ANSWEREVENT )) ),
	!,
	Actor <- photo( FNAME, DURATION, ANSWEREVENT, Events, Plans ).
executeCmd( Actor, move( photo(DURATION,FNAME) ) , Events, Plans, done(photo,FNAME) ):-
	%% actorPrintln(  executeCmd(Actor, photo(DURATION,FNAME) )) ),
	Actor <- photo( FNAME, DURATION, '', Events, Plans ).
	
%%% ---------  Solve	---------------
/*
We cannot solve a goal in asynch way while pengine is engaged
Thus we ignore DURATION and Events, Plans
*/
executeCmd( Actor,   move(solve,GOAL,DURATION, ANSWEREVENT), Events, Plans, RES ):-
	%% actorPrintln(  executeCmd(Actor, move(solve,GOAL,DURATION, ANSWEREVENT) ) ),
 	Actor <- solveSentence(sentence(true, GOAL, 0, ANSWEREVENT, '', '')) returns AAR,
 	AAR   <- getResult returns RES.
	
executeCmd( Actor, move(solve,GOAL,DURATION), Events, Plans, RES ):-
	%% actorPrintln(  executeCmd(Actor, move(solve,GOAL,DURATION) ) ),
	Actor <- solveSentence(sentence(true, GOAL, 0, '', '', '')) returns AAR,
	AAR <- getResult returns RES.
	%% actorPrintln( result(GOAL,RES) ).
	%% The following  DOES NOT WORK since pengine is engaged
	%% Actor <- solveSentence(sentence(true, GOAL, DURATION, '', Events, Plans)) returns AAR.	
 	
%%% ---------  Println	---------------	
executeCmd( Actor,  move(print,ARG), Events, Plans, done(print) ):-
	text_term(ARGS,ARG),
	actorPrintln(  ARGS ).
%%% ---------  Emit	---------------	
executeCmd( Actor,  move(emit,EVID,CONTENT), Events, Plans, done(emit,EVID) ):-
	actorPrintln(  move(emit,EVID,CONTENT) ),
	Actor <- emit( EVID,CONTENT ).
%%% ---------  Forward	---------------	
executeCmd( Actor,  move(forward, DEST, MSGID, MSGCNT), Events, Plans, done(forward,MSGID,dest(DEST)) ):-
	actorPrintln(  forward( 1,Actor,MSGID,DEST,MSGCNT ) ),	
	text_term(A1,DEST),  	 
	text_concat("''",A1,A2),
	text_concat(A2,"''",DESTSTR),
 	Actor <- forwardFromProlog( MSGID , DESTSTR , MSGCNT ). 
 
%%% ---------  plan	---------------	
executeCmd( Actor, move(runplan,P), Events, Plans,done(runplan(P)) ):-
 	%% actorPrintln( runplan(P) ),
	execPlan(Actor,P,0).
executeCmd( Actor, move(resumePlan), Events, Plans,done(resume(P)) ).


/*
%-------------------------------------------------
%  Some predefined code
%------------------------------------------------- 
*/
fibo(0,1).
fibo(1,1).
fibo(2,1).
fibo(3,2).
fibo(4,3).
fibo(I,N) :- V1 is I-1, V2 is I-2,
  fibo(V1,N1), fibo(V2,N2),
  N is N1 + N2.

%% Fibonacci with cache (to be used in guards)

fib(V):-
	fibmemo( V,N ),!,
	actorPrintln( fib_a(V,N) ).
fib(V):-
	fibWithCache(V,N), 					
	actorPrintln( fib_b(V,N) ).

fib( V,R ) :-
	fibWithCache(V,R).

fibmemo( 0,1 ).
fibmemo( 1,1 ).
fibmemo( 2,1 ).
fibmemo( 3,2 ).
fibWithCache( V,N ) :-
	fibmemo( V,N ),!.
fibWithCache( V,N ) :-
	V1 is V-1, V2 is V-2,
  	fibWithCache(V1,N1), fibWithCache(V2,N2),
  	N is N1 + N2,
	%% actorPrintln( fib( V,N ) ),
	assert( fibmemo( V,N ) ).
/*
------------------------------------------------------------
initialize
------------------------------------------------------------
*/
initialize  :-  
	actorobj(Actor),
 	actorPrintln( worlTheoryLoaded(Actor) ).
 
:- initialization(initialize).
