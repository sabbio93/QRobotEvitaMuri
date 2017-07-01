/* Generated by AN DISI Unibo */ 
package it.unibo.ctxSonarPartenza;
import it.unibo.qactors.QActorContext;
import java.io.InputStream;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Term;
import alice.tuprolog.Var;
 
import it.unibo.is.interfaces.IBasicEnvAwt;
import it.unibo.is.interfaces.IIntent;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.system.SituatedSysKb;

public class MainCtxSonarPartenza   {
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
		    String webDir = null;
			QActorContext.initQActorSystem(
				"ctxsonarpartenza", "./srcMore/it/unibo/ctxSonarPartenza/m1.pl", 
				"./srcMore/it/unibo/ctxSonarPartenza/sysRules.pl", outEnvView,webDir, false);
 	}
 	
}
