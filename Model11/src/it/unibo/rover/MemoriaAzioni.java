package it.unibo.rover;

import java.util.Stack;

public class MemoriaAzioni extends Stack<Azione>{
	
	private static final long serialVersionUID = -6050545224895826390L;
	
	private long istanteInizioUltimaAzione;
	
	@Override
	public Azione push(Azione azione){
		if(!isEmpty()){
			Azione ultimaAzioneEffettuata = peek();
			long durataEffettivaUltimaAzione = System.currentTimeMillis() - istanteInizioUltimaAzione;
			if(durataEffettivaUltimaAzione < ultimaAzioneEffettuata.getDurata())
				ultimaAzioneEffettuata.setDurata((int)durataEffettivaUltimaAzione);
		}
		istanteInizioUltimaAzione = System.currentTimeMillis();
		return super.push(azione);		
	}
	
}
