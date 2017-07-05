/* Generated by AN DISI Unibo */ 
package it.unibo.robotmind;
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
public abstract class AbstractRobotmind extends QActor { 
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
	
	
		public AbstractRobotmind(String actorId, QActorContext myCtx, IOutputEnvView outEnvView )  throws Exception{
			super(actorId, myCtx,  
			"./srcMore/it/unibo/robotmind/WorldTheory.pl",
			setTheEnv( outEnvView )  , "init");		
			this.planFilePath = "./srcMore/it/unibo/robotmind/plans.txt";
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
	    		temporaryStr = "\"controller starts\"";
	    		println( temporaryStr );  
	    		if( ! planUtils.switchToPlan("listenToSonar").getGoon() ) break;
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=init WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean listenToSonar() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "listenToSonar";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "listenToSonar";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		//senseEvent
	    		aar = planUtils.senseEvents( 600000,"cmd,robotLeave,robotDetected","continue,continue,continue",
	    		"" , "",ActionExecMode.synch );
	    		if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
	    			//println("			WARNING: sense timeout");
	    			addRule("tout(senseevent,"+getName()+")");
	    		}
	    		if( (guardVars = QActorUtils.evalTheGuard(this, " !?davanti(sonara,rover)" )) != null ){
	    		//onEvent
	    		if( currentEvent.getEventId().equals("cmd") ){
	    		 		String parg = "";
	    		 		parg =  updateVars(  Term.createTerm("cmd(X)"), Term.createTerm("cmd(start)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 			if( parg != null ){
	    		 				 if( ! planUtils.switchToPlan("pianificaMossa").getGoon() ) break; 
	    		 			}//else println("guard it.unibo.xtext.qactor.impl.GuardImpl@5e421bc2 (not: false) fails");  //parg is null when there is no guard (onEvent)
	    		 }
	    		}
	    		if( (guardVars = QActorUtils.evalTheGuard(this, " !?davanti(sonara,rover)" )) != null ){
	    		//onEvent
	    		if( currentEvent.getEventId().equals("robotLeave") ){
	    		 		String parg="davanti(sonara,rover)";
	    		 		parg = updateVars( Term.createTerm("robotLeave(Sonar)"),  Term.createTerm("robotLeave(sonara)"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 		if( parg != null ) removeRule(parg);
	    		 }
	    		}
	    		else{ //onEvent
	    		if( currentEvent.getEventId().equals("robotDetected") ){
	    		 		String parg="salvaDistanzaIniziale(D)";
	    		 		parg = updateVars( Term.createTerm("robotDetected(Sonar,Posizione)"),  Term.createTerm("robotDetected(sonara,d(D))"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 			if( parg != null ) {
	    		 			    aar = QActorUtils.solveGoal(this,myCtx,pengine,parg,"",outEnvView,86400000);
	    		 				//println(getName() + " plan " + curPlanInExec  +  " interrupted=" + aar.getInterrupted() + " action goon="+aar.getGoon());
	    		 				if( aar.getInterrupted() ){
	    		 					curPlanInExec   = "listenToSonar";
	    		 					if( aar.getTimeRemained() <= 0 ) addRule("tout(demo,"+getName()+")");
	    		 					if( ! aar.getGoon() ) break;
	    		 				} 			
	    		 				if( aar.getResult().equals("failure")){
	    		 					if( ! aar.getGoon() ) break;
	    		 				}else if( ! aar.getGoon() ) break;
	    		 			}
	    		 }
	    		}//onEvent
	    		if( currentEvent.getEventId().equals("robotDetected") ){
	    		 		String parg = "";
	    		 		/* SwitchPlan */
	    		 		parg =  updateVars(  Term.createTerm("robotDetected(Sonar,Posizione)"), Term.createTerm("robotDetected(b,d(D))"), 
	    		 			    		  					Term.createTerm(currentEvent.getMsg()), parg);
	    		 			if( parg != null ){
	    		 				 if( ! planUtils.switchToPlan("pianificaMossa").getGoon() ) break; 
	    		 			}//else println("guard  fails");  //parg is null when there is no guard (onEvent)
	    		 }
	    		if( planUtils.repeatPlan(nPlanIter,0).getGoon() ) continue;
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=listenToSonar WARNING:" + e.getMessage() );
	       QActorContext.terminateQActorSystem(this); 
	       return false;  
	    }
	    }
	    public boolean pianificaMossa() throws Exception{	//public to allow reflection
	    try{
	    	int nPlanIter = 0;
	    	//curPlanInExec =  "pianificaMossa";
	    	boolean returnValue = suspendWork;		//MARCHH2017
	    while(true){
	    	curPlanInExec =  "pianificaMossa";	//within while since it can be lost by switchlan
	    	nPlanIter++;
	    		parg = "prossimaMossa(Mossa)";
	    		//tout=1 day (24 h)
	    		//aar = solveGoalReactive(parg,86400000,"","");
	    		//genCheckAar(m.name)»		
	    		QActorUtils.solveGoal(parg,pengine );
	    		if( (guardVars = QActorUtils.evalTheGuard(this, " ??soluzione(stop)" )) != null ){
	    		temporaryStr = QActorUtils.unifyMsgContent(pengine, "stop","stop", guardVars ).toString();
	    		emit( "stop", temporaryStr );
	    		}
	    		if( (guardVars = QActorUtils.evalTheGuard(this, " ??soluzione(G)" )) != null ){
	    		temporaryStr = QActorUtils.unifyMsgContent(pengine, "muovi(X)","muovi(G)", guardVars ).toString();
	    		emit( "muovi", temporaryStr );
	    		}
	    		returnValue = continueWork;  
	    break;
	    }//while
	    return returnValue;
	    }catch(Exception e){
	       //println( getName() + " plan=pianificaMossa WARNING:" + e.getMessage() );
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
	
