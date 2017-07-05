/* Generated by AN DISI Unibo */ 
package it.unibo.rover;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Struct;
import alice.tuprolog.Term;
import it.unibo.qactors.QActorContext;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.qactors.action.ActionReceiveTimed;
import it.unibo.qactors.action.AsynchActionResult;
import it.unibo.qactors.action.IActorAction;
import it.unibo.qactors.action.IActorAction.ActionExecMode;
import it.unibo.iot.configurator.Configurator;
import it.unibo.iot.executors.baseRobot.IBaseRobot; 
import it.unibo.iot.models.sensorData.distance.IDistanceSensorData;
import it.unibo.iot.models.sensorData.impact.IImpactSensorData;
import it.unibo.iot.models.sensorData.line.ILineSensorData;
import it.unibo.iot.models.sensorData.magnetometer.IMagnetometerSensorData;
import it.unibo.iot.sensors.ISensor; 
import it.unibo.iot.sensors.ISensorObserver;
import it.unibo.iot.sensors.distanceSensor.DistanceSensor;
import it.unibo.iot.sensors.impactSensor.ImpactSensor;
import it.unibo.iot.sensors.lineSensor.LineSensor;
import it.unibo.iot.sensors.magnetometerSensor.MagnetometerSensor;
import it.unibo.qactors.action.IMsgQueue;
import it.unibo.qactors.QActorMessage;
import it.unibo.qactors.QActorUtils;


class QaRobotActor extends it.unibo.qactor.robot.RobotActor{
	public QaRobotActor(
		String name, QActorContext ctx, String worldTheoryPath,
			IOutputEnvView outEnvView, String baserobot, String defaultPlan )  throws Exception{
		super(name, ctx, "./srcMore/it/unibo/rover/plans.txt", worldTheoryPath,
		outEnvView, it.unibo.qactor.robot.RobotSysKb.setRobotBase(ctx, baserobot) , defaultPlan);
	}
}

public class AbstractRover extends QaRobotActor { 
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


	public AbstractRover(String actorId, QActorContext myCtx, IOutputEnvView outEnvView ,String baserobot)  throws Exception{
		super(actorId, myCtx,  
		"./srcMore/it/unibo/rover/WorldTheory.pl",
		setTheEnv( outEnvView ) ,baserobot , "init");		
		this.planFilePath = "./srcMore/it/unibo/rover/plans.txt";
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
    		if( (guardVars = QActorUtils.evalTheGuard(this, " !?unity" )) != null ){
    		if( ! planUtils.switchToPlan("initUnity").getGoon() ) break;
    		}
    		if( ! planUtils.switchToPlan("attesaComandi").getGoon() ) break;
    break;
    }//while
    return returnValue;
    }catch(Exception e){
       //println( getName() + " plan=init WARNING:" + e.getMessage() );
       QActorContext.terminateQActorSystem(this); 
       return false;  
    }
    }
    public boolean initUnity() throws Exception{	//public to allow reflection
    try{
    	int nPlanIter = 0;
    	//curPlanInExec =  "initUnity";
    	boolean returnValue = suspendWork;		//MARCHH2017
    while(true){
    	curPlanInExec =  "initUnity";	//within while since it can be lost by switchlan
    	nPlanIter++;
    		//parg = "actorOp(workWithUnity(\"localhost\"))"; //JUNE2017
    		parg = "workWithUnity(\"localhost\")";
    		//ex solveGoalReactive JUNE2017
    		aar = actorOpExecuteReactive(parg,3600000,"","");
    		//println(getName() + " plan " + curPlanInExec  +  " interrupted=" + aar.getInterrupted() + " action goon="+aar.getGoon());
    		if( aar.getInterrupted() ){
    			curPlanInExec   = "initUnity";
    			if( aar.getTimeRemained() <= 0 ) addRule("tout(actorOp,"+getName()+")");
    			if( ! aar.getGoon() ) break;
    		} 			
    		else{
    		//Store actorOpDone with the result
    		 	String gg = "storeActorOpResult( X, Y )".replace("X", parg).replace("Y",aar.getResult() );
    		 	//System.out.println("actorOpExecute gg=" + gg );
    			 	 	pengine.solve(gg+".");			
    		}
    		
    		//parg = "actorOp(initPosition)"; //JUNE2017
    		parg = "initPosition";
    		//ex solveGoalReactive JUNE2017
    		aar = actorOpExecuteReactive(parg,3600000,"","");
    		//println(getName() + " plan " + curPlanInExec  +  " interrupted=" + aar.getInterrupted() + " action goon="+aar.getGoon());
    		if( aar.getInterrupted() ){
    			curPlanInExec   = "initUnity";
    			if( aar.getTimeRemained() <= 0 ) addRule("tout(actorOp,"+getName()+")");
    			if( ! aar.getGoon() ) break;
    		} 			
    		else{
    		//Store actorOpDone with the result
    		 	String gg = "storeActorOpResult( X, Y )".replace("X", parg).replace("Y",aar.getResult() );
    		 	//System.out.println("actorOpExecute gg=" + gg );
    			 	 	pengine.solve(gg+".");			
    		}
    		
    		//right
    		//if( ! execRobotMove("initUnity","right",100,0,2000, "" , "") ) break;
    		    aar = execRobotMove("initUnity","right",100,0,2000, "" , "");
    		    if( aar.getInterrupted() ){
    		    	curPlanInExec   = "initUnity";
    		    	if( ! aar.getGoon() ) break;
    		    } 			
    		temporaryStr = "\"Inizializzazione Unity completata\"";
    		println( temporaryStr );  
    		returnValue = continueWork;  
    break;
    }//while
    return returnValue;
    }catch(Exception e){
       //println( getName() + " plan=initUnity WARNING:" + e.getMessage() );
       QActorContext.terminateQActorSystem(this); 
       return false;  
    }
    }
    public boolean attesaComandi() throws Exception{	//public to allow reflection
    try{
    	int nPlanIter = 0;
    	//curPlanInExec =  "attesaComandi";
    	boolean returnValue = suspendWork;		//MARCHH2017
    while(true){
    	curPlanInExec =  "attesaComandi";	//within while since it can be lost by switchlan
    	nPlanIter++;
    		if( ! checkInMsgQueue() ){
    			//ReceiveMsg
    			 		aar = planUtils.receiveAMsg(mysupport,600000, "" , "" ); 	//could block
    				    if( ! aar.getGoon() || aar.getTimeRemained() <= 0 ){
    				    	//println("	WARNING: receivemsg timeout " + aar.getTimeRemained());
    				    	addRule("tout(receivemsg,"+getName()+")");
    				    }
    		}
    		//onMsg
    		if( currentMessage.msgId().equals("muovi") ){
    			String parg="assign(direzione,Dir)";
    			/* PHead */
    			parg =  updateVars( Term.createTerm("muovi(X)"), Term.createTerm("muovi(Dir)"), 
    				    		  					Term.createTerm(currentMessage.msgContent()), parg);
    				if( parg != null ) {
    				    aar = QActorUtils.solveGoal(this,myCtx,pengine,parg,"",outEnvView,86400000);
    					//println(getName() + " plan " + curPlanInExec  +  " interrupted=" + aar.getInterrupted() + " action goon="+aar.getGoon());
    					if( aar.getInterrupted() ){
    						curPlanInExec   = "attesaComandi";
    						if( aar.getTimeRemained() <= 0 ) addRule("tout(demo,"+getName()+")");
    						if( ! aar.getGoon() ) break;
    					} 			
    					if( aar.getResult().equals("failure")){
    						if( ! aar.getGoon() ) break;
    					}else if( ! aar.getGoon() ) break;
    				}
    		}if( (guardVars = QActorUtils.evalTheGuard(this, " !?value(direzione,destra)" )) != null ){
    		//right
    		//if( ! execRobotMove("attesaComandi","right",100,0,2000, "stop" , "fermaRobot") ) break;
    		    aar = execRobotMove("attesaComandi","right",100,0,2000, "stop" , "fermaRobot");
    		    if( aar.getInterrupted() ){
    		    	curPlanInExec   = "attesaComandi";
    		    	if( ! aar.getGoon() ) break;
    		    } 			
    		}
    		if( (guardVars = QActorUtils.evalTheGuard(this, " !?value(direzione,sinistra)" )) != null ){
    		//left
    		//if( ! execRobotMove("attesaComandi","left",100,0,2000, "stop" , "fermaRobot") ) break;
    		    aar = execRobotMove("attesaComandi","left",100,0,2000, "stop" , "fermaRobot");
    		    if( aar.getInterrupted() ){
    		    	curPlanInExec   = "attesaComandi";
    		    	if( ! aar.getGoon() ) break;
    		    } 			
    		}
    		parg = "assign(direzione,avanti)";
    		//tout=1 day (24 h)
    		//aar = solveGoalReactive(parg,86400000,"","");
    		//genCheckAar(m.name)»		
    		QActorUtils.solveGoal(parg,pengine );
    		//forward
    		//if( ! execRobotMove("attesaComandi","forward",60,0,600000, "stop" , "fermaRobot") ) break;
    		    aar = execRobotMove("attesaComandi","forward",60,0,600000, "stop" , "fermaRobot");
    		    if( aar.getInterrupted() ){
    		    	curPlanInExec   = "attesaComandi";
    		    	if( ! aar.getGoon() ) break;
    		    } 			
    		if( planUtils.repeatPlan(nPlanIter,0).getGoon() ) continue;
    break;
    }//while
    return returnValue;
    }catch(Exception e){
       //println( getName() + " plan=attesaComandi WARNING:" + e.getMessage() );
       QActorContext.terminateQActorSystem(this); 
       return false;  
    }
    }
    public boolean fermaRobot() throws Exception{	//public to allow reflection
    try{
    	int nPlanIter = 0;
    	//curPlanInExec =  "fermaRobot";
    	boolean returnValue = suspendWork;		//MARCHH2017
    while(true){
    	curPlanInExec =  "fermaRobot";	//within while since it can be lost by switchlan
    	nPlanIter++;
    		temporaryStr = "\"Stop requested\"";
    		println( temporaryStr );  
    		//stop
    		//if( ! execRobotMove("fermaRobot","stop",0,0,0, "" , "") ) break;
    		    aar = execRobotMove("fermaRobot","stop",0,0,0, "" , "");
    		    if( aar.getInterrupted() ){
    		    	curPlanInExec   = "fermaRobot";
    		    	if( ! aar.getGoon() ) break;
    		    } 			
    		if( ! planUtils.switchToPlan("attesaComandi").getGoon() ) break;
    break;
    }//while
    return returnValue;
    }catch(Exception e){
       //println( getName() + " plan=fermaRobot WARNING:" + e.getMessage() );
       QActorContext.terminateQActorSystem(this); 
       return false;  
    }
    }
    /* 
    * ------------------------------------------------------------
    * SENSORS
    * ------------------------------------------------------------
    */
    protected void initSensorSystem(){		
    	try {
    		String goal = "consult( \"./src/it/unibo/rover/sensorTheory.pl\" )";
    		SolveInfo sol = QActorUtils.solveGoal( goal ,pengine );
    		if( ! sol.isSuccess() ){
    			//println( "avatar initSensorSystem attempt to load sensorTheory "  );
    			goal = "consult( \"./sensorTheory.pl\" )";
    			QActorUtils.solveGoal( pengine, goal  );
    			//println( "avatar initSensorSystem= "  +  aar.getResult() );
    		}
    		addSensorObservers();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    /*
    //COMPONENTS
    sensor distanceMock simulated debug=0   
     RobotComponent motorleft 
     RobotComponent motorright 
    Composed component motors
    */
    protected void addSensorObservers(){
    	for (ISensor<?> sensor : Configurator.getInstance().getSensors()) {
    		//println( "rover sensor= "  + sensor.getDefStringRep() );
    		//println( "rover sensor class= "  + sensor.getClass().getName() );
        	if( sensor instanceof DistanceSensor){
        		DistanceSensor sensorDistance  = (DistanceSensor) sensor;
        		ISensorObserver<IDistanceSensorData> obs = new SensorObserver<IDistanceSensorData>(this,outEnvView);
        //		println( "avatar add observer to  "  + sensorDistance.getDefStringRep() );
        		sensorDistance.addObserver(  obs  ) ;
        	}
        	if( sensor instanceof LineSensor){
        		LineSensor sensorLine = (LineSensor) sensor;
         		ISensorObserver<ILineSensorData> obs = new SensorObserver<ILineSensorData>(this,outEnvView);
        //		println( "avatar add observer to  "  + sensorLine.getDefStringRep() );
        		sensorLine.addObserver(  obs  ) ;
        	}
         	if( sensor instanceof MagnetometerSensor){
        		MagnetometerSensor sensorMagneto = (MagnetometerSensor) sensor;
         		ISensorObserver<IMagnetometerSensorData> obs = new SensorObserver<IMagnetometerSensorData>(this,outEnvView);
        //		println( "avatar add observer to  "  + sensorMagneto.getDefStringRep() );
        		sensorMagneto.addObserver(  obs  ) ;
        	}
    		if( sensor instanceof ImpactSensor){
    			ImpactSensor sensorImpact = (ImpactSensor) sensor;
    			ISensorObserver<IImpactSensorData> obs = new SensorObserver<IImpactSensorData>(this,outEnvView);
    	//		println( "avatar add observer to  "  + sensorMagneto.getDefStringRep() );
    			sensorImpact.addObserver(  obs  ) ;
    		}
    	}		
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

