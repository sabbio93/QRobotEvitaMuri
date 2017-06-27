/* Generated by AN DISI Unibo */ 
package it.unibo.sonarb;
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
public abstract class AbstractSonarb extends QActor { 
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
	
	
		public AbstractSonarb(String actorId, QActorContext myCtx, IOutputEnvView outEnvView )  throws Exception{
			super(actorId, myCtx,  
			"./srcMore/it/unibo/sonarb/WorldTheory.pl",
			setTheEnv( outEnvView )  , "init");		
			this.planFilePath = "./srcMore/it/unibo/sonarb/plans.txt";
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
	    		temporaryStr = "\"ctxSonarArrivo Inizio\"";
	    		println( temporaryStr );  
	    		if( ! planUtils.switchToPlan("attesa").getGoon() ) break;
	    		temporaryStr = "\"� iniziato\"";
	    		println( temporaryStr );  
	    		//parg = "actorOp(initSonar)"; //JUNE2017
	    		parg = "initSonar";
	    		//ex solveGoalReactive JUNE2017
	    		aar = actorOpExecuteReactive(parg,3600000,"","");
	    		//println(getName() + " plan " + curPlanInExec  +  " interrupted=" + aar.getInterrupted() + " action goon="+aar.getGoon());
	    		if( aar.getInterrupted() ){
	    			curPlanInExec   = "init";
	    			if( aar.getTimeRemained() <= 0 ) addRule("tout(actorOp,"+getName()+")");
	    			if( ! aar.getGoon() ) break;
	    		} 			
	    		else{
	    		//Store actorOpDone with the result
	    		 	String gg = "storeActorOpResult( X, Y )".replace("X", parg).replace("Y",aar.getResult() );
	    		 	//System.out.println("actorOpExecute gg=" + gg );
	    			 	 	pengine.solve(gg+".");			
	    		}
	    		
	    		if( ! planUtils.switchToPlan("rileva").getGoon() ) break;
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=init WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean attesa() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "attesa";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "attesa";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		//senseEvent
	    		aar = planUtils.senseEvents( 600000,"cmd","continue",
	    		"" , "",ActionExecMode.synch );
	    		if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
	    			//println("			WARNING: sense timeout");
	    			addRule("tout(senseevent,"+getName()+")");
	    		}
	    		//onEvent
	    		if( currentEvent.getEventId().equals("cmd") ){
	    		 		String parg = "ricevuto_comando(X)";
	    		 		/* Print */
	    		 		parg =  updateVars( Term.createTerm("cmd(X)"), Term.createTerm("cmd(X)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 			if( parg != null ) println( parg );  
	    		 }
	    		//onEvent
	    		if( currentEvent.getEventId().equals("cmd") ){
	    		 		String parg = "\"start\"";
	    		 		/* Print */
	    		 		parg =  updateVars( Term.createTerm("cmd(X)"), Term.createTerm("cmd(start)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 			if( parg != null ) println( parg );  
	    		 }
	    		else{ if( planUtils.repeatPlan(nPlanIter,0).getGoon() ) continue;
	    		}returnValue = continueWork;  
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=attesa WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean rileva() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "rileva";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "rileva";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		//delay
	    		aar = delayReactive(600000,"" , "");
	    		if( aar.getInterrupted() ) curPlanInExec   = "rileva";
	    		if( ! aar.getGoon() ) break;
	    		if( planUtils.repeatPlan(nPlanIter,0).getGoon() ) continue;
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=rileva WARNING:" + e.getMessage() );
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
	
