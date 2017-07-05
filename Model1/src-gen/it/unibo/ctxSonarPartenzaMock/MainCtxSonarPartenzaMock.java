/* Generated by AN DISI Unibo */ 
package it.unibo.ctxSonarPartenzaMock;
import it.unibo.qactors.QActorContext;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.system.SituatedSysKb;
public class MainCtxSonarPartenzaMock  {
  
//MAIN
public static QActorContext initTheContext() throws Exception{
	IOutputEnvView outEnvView = SituatedSysKb.standardOutEnvView;
	String webDir = null;
	return QActorContext.initQActorSystem(
		"ctxsonarpartenzamock", "./srcMore/it/unibo/ctxSonarPartenzaMock/m1.pl", 
		"./srcMore/it/unibo/ctxSonarPartenzaMock/sysRules.pl", outEnvView,webDir,false);
}
public static void main(String[] args) throws Exception{
	QActorContext ctx = initTheContext();
} 	
}