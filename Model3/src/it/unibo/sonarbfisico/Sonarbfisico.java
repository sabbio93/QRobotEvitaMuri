/* Generated by AN DISI Unibo */ 
/*
This code is generated only ONCE
*/
package it.unibo.sonarbfisico;
import it.unibo.is.interfaces.IOutputEnvView;
import it.unibo.qactors.QActorContext;
import it.unibo.sonarrasp.Sonarrasp;

public class Sonarbfisico extends AbstractSonarbfisico { 
	private final String nomeSonarFisico;
	
	public Sonarbfisico(String actorId, QActorContext myCtx, IOutputEnvView outEnvView )  throws Exception{
		super(actorId, myCtx, outEnvView);
		println("Sonarb fisico creato ---------------------------------");		
		nomeSonarFisico=getName().replace("_ctrl", "")+"InnerSonar";	
	}
	
	public String initSonar(){
		println("Proviamo l'inizializzazione");
		try {
			QActorContext ctx = getQActorContext();
			ctx.addInstance(ctx, nomeSonarFisico, Sonarrasp.class.getName(), outEnvView);			
		} catch (Exception e) {
			println("[Eccezione]: "+e.getLocalizedMessage());
		}
		return nomeSonarFisico+"_ctrl";
	}
}
