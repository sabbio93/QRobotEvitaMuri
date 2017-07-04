/* Generated by AN DISI Unibo */ 
package it.unibo.sonara;
import alice.tuprolog.Struct;
import alice.tuprolog.Term;
import it.unibo.qactors.QActorContext;
import it.unibo.qactors.ActorTerminationMessage;
import it.unibo.qactors.QActorMessage;
import it.unibo.qactors.QActorUtils;
import it.unibo.contactEvent.interfaces.IEventItem;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.qactors.action.ActionReceiveTimed;
import it.unibo.qactors.action.AsynchActionResult;
import it.unibo.qactors.action.IActorAction;
import it.unibo.qactors.action.IActorAction.ActionExecMode;
import it.unibo.qactors.action.IMsgQueue;
import it.unibo.qactors.akka.QActor;


//REGENERATE AKKA: QActor instead QActorPlanned
public abstract class AbstractSonara extends QActor { 
	protected AsynchActionResult aar = null;
	protected boolean actionResult = true;
	protected alice.tuprolog.SolveInfo sol;
	//protected IMsgQueue mysupport ;  //defined in QActor
	protected String planFilePath    = null;
	protected String terminationEvId = "default";
	protected String parg="";
	protected boolean bres=false;
	protected IActorAction  action;
	
			protected static IOutputEnvView setTheEnv(IOutputEnvView outEnvView ){
				return outEnvView;
			}
	
	
		public AbstractSonara(String actorId, QActorContext myCtx, IOutputEnvView outEnvView )  throws Exception{
			super(actorId, myCtx,  
			"./srcMore/it/unibo/sonara/WorldTheory.pl",
			setTheEnv( outEnvView )  , "init");		
			this.planFilePath = "./srcMore/it/unibo/sonara/plans.txt";
			//Plan interpretation is done in Prolog
			//if(planFilePath != null) planUtils.buildPlanTable(planFilePath);
	 	}
		@Override
		protected void doJob() throws Exception {
			String name  = getName().replace("_ctrl", "");
			mysupport = (IMsgQueue) QActorUtils.getQActor( name ); 
	 		initSensorSystem();
			boolean res = init();
			//println(getName() + " doJob " + res );
			QActorContext.terminateQActorSystem(this);
		} 
		/* 
		* ------------------------------------------------------------
		* PLANS
		* ------------------------------------------------------------
		*/
	    public boolean init() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "init";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "init";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		temporaryStr = "\"SonarPartenza Start\"";
	    		println( temporaryStr );  
	    		if( ! planUtils.switchToPlan("rilevaRobotOnA").getGoon() ) break;
	    		temporaryStr = "\"rinizializzo\"";
	    		println( temporaryStr );  
	    		if( planUtils.repeatPlan(nPlanIter,0).getGoon() ) continue;
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=init WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean rilevaRobotOnA() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "rilevaRobotOnA";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "rilevaRobotOnA";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		//senseEvent
	    		aar = planUtils.senseEvents( 600000,"sonar","continue",
	    		"" , "",ActionExecMode.synch );
	    		if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
	    			//println("			WARNING: sense timeout");
	    			addRule("tout(senseevent,"+getName()+")");
	    		}
	    		//onEvent
	    		if( currentEvent.getEventId().equals("sonar") ){
	    		 		String parg="robotOnA()";
	    		 		/* RaiseEvent */
	    		 		parg = updateVars(Term.createTerm("sonar(Nome,Oggetto,Distanza)"),  Term.createTerm("sonar(sonar1,rover,D)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 		if( parg != null ) emit( "robotOnA", parg );
	    		 }
	    		if( ! planUtils.switchToPlan("rilevaRobotLeaveA").getGoon() ) break;
	    		returnValue = continueWork;  
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=rilevaRobotOnA WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean rilevaRobotLeaveA() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "rilevaRobotLeaveA";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "rilevaRobotLeaveA";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		//senseEvent
	    		aar = planUtils.senseEvents( 600000,"sonar","continue",
	    		"" , "",ActionExecMode.synch );
	    		if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
	    			//println("			WARNING: sense timeout");
	    			addRule("tout(senseevent,"+getName()+")");
	    		}
	    		//onEvent
	    		if( currentEvent.getEventId().equals("sonar") ){
	    		 		String parg="robotLeaveA()";
	    		 		/* RaiseEvent */
	    		 		parg = updateVars(Term.createTerm("sonar(Nome,Oggetto,Distanza)"),  Term.createTerm("sonar(sonar1,rover,D)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 		if( parg != null ) emit( "robotLeaveA", parg );
	    		 }
	    		returnValue = continueWork;  
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=rilevaRobotLeaveA WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    protected void initSensorSystem(){
	    	//doing nothing in a QActor
	    }
	    
	 
		/* 
		* ------------------------------------------------------------
		* APPLICATION ACTIONS
		* ------------------------------------------------------------
		*/
		/* 
		* ------------------------------------------------------------
		* QUEUE  
		* ------------------------------------------------------------
		*/
		    protected void getMsgFromInputQueue(){
	//	    	println( " %%%% getMsgFromInputQueue" ); 
		    	QActorMessage msg = mysupport.getMsgFromQueue(); //blocking
	//	    	println( " %%%% getMsgFromInputQueue continues with " + msg );
		    	this.currentMessage = msg;
		    }
	  }
	
