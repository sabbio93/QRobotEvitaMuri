/* Generated by AN DISI Unibo */ 
package it.unibo.ctxSonarArrivoUnity;
import it.unibo.qactors.QActorContext;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.system.SituatedSysKb;
public class MainCtxSonarArrivoUnity  {
  
//MAIN
public static QActorContext initTheContext() throws Exception{
	IOutputEnvView outEnvView = SituatedSysKb.standardOutEnvView;
	String webDir = null;
	return QActorContext.initQActorSystem(
		"ctxsonararrivounity", "./srcMore/it/unibo/ctxSonarArrivoUnity/model0.pl", 
		"./srcMore/it/unibo/ctxSonarArrivoUnity/sysRules.pl", outEnvView,webDir,false);
}
public static void main(String[] args) throws Exception{
	QActorContext ctx = initTheContext();
} 	
}
