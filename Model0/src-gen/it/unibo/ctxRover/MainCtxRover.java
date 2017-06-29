/* Generated by AN DISI Unibo */ 
package it.unibo.ctxRover;
import it.unibo.qactors.QActorContext;
import java.io.InputStream;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Term;
import alice.tuprolog.Var;
 
import it.unibo.is.interfaces.IBasicEnvAwt;
import it.unibo.is.interfaces.IIntent;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.system.SituatedSysKb;

public class MainCtxRover   {
private IBasicEnvAwt env; 
private it.unibo.qactor.robot.RobotActor robot; 
 
 	
/*
* ----------------------------------------------
* MAIN
* ----------------------------------------------
*/
 
	public static void main(String[] args) throws Exception{
			IOutputEnvView outEnvView = SituatedSysKb.standardOutEnvView;
			it.unibo.qactors.QActorUtils.setRobotBase("mock" );  
		    String webDir = "./srcMore/it/unibo/ctxRover";
			QActorContext.initQActorSystem(
				"ctxrover", "./srcMore/it/unibo/ctxRover/model0.pl", 
				"./srcMore/it/unibo/ctxRover/sysRules.pl", outEnvView,webDir, false);
 	}
 	
}