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
	    		temporaryStr = "\"ctxSonarPartenza start -- wait for start\"";
	    		println( temporaryStr );  
	    		//delay
	    		aar = delayReactive(1000,"" , "");
	    		if( aar.getInterrupted() ) curPlanInExec   = "init";
	    		if( ! aar.getGoon() ) break;
	    		temporaryStr = "\"invio event presente in A\"";
	    		println( temporaryStr );  
	    		temporaryStr = QActorUtils.unifyMsgContent(pengine, "robotDetected(Sonar)","robotDetected(a)", guardVars ).toString();
	    		emit( "robotDetected", temporaryStr );
	    		//delay
	    		aar = delayReactive(2000,"" , "");
	    		if( aar.getInterrupted() ) curPlanInExec   = "init";
	    		if( ! aar.getGoon() ) break;
	    		//senseEvent
	    		aar = planUtils.senseEvents( 600000,"cmd","continue",
	    		"" , "",ActionExecMode.synch );
	    		if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
	    			//println("			WARNING: sense timeout");
	    			addRule("tout(senseevent,"+getName()+")");
	    		}
	    		//onEvent
	    		if( currentEvent.getEventId().equals("cmd") ){
	    		 		String parg="robotLeave(a)";
	    		 		/* RaiseEvent */
	    		 		parg = updateVars(Term.createTerm("cmd(X)"),  Term.createTerm("cmd(start)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 		if( parg != null ) emit( "robotLeave", parg );
	    		 }
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=init WARNING:" + e.getMessage() );
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
	
