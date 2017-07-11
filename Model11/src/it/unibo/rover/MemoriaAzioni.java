package it.unibo.rover;

import java.util.*;

public class MemoriaAzioni extends Stack<Azione> {
	private static final long serialVersionUID=-6050545224895826390L;
	private long istanteInizioUltimaAzione;
	/*public Azione push(Azione azione){
		if (!isEmpty()){
			Azione ultima=peek();
			long durataEffettivaUltima=System.currentTimeMillis()-istanteInizioUltimaAzione;
			if (durataEffettivaUltima<ultima.getDurata() || ultima.getNome().endsWith("ward"))
				ultima.setDurata((int)durataEffettivaUltima);
		}
		istanteInizioUltimaAzione=System.currentTimeMillis();
		return super.push(azione);
	}*/
	/**inserisce l'azione nello stack, eventualmente concatenandola alla precedente*/
	private void accorpa(Azione ultima){
		if (isEmpty())
			super.push(ultima);
		else {
			Azione penultima=peek();
			Azione unione=penultima.concatena(ultima);
			if (unione==null)
				super.push(ultima);
			else {
				pop();
				accorpa(unione);
			}
		}
	}
	public Azione push(Azione a){	//con accorpamenti
		if (!isEmpty()){
			Azione ultima=pop();
			long durataEffettivaUltima=System.currentTimeMillis()-istanteInizioUltimaAzione;
			if (durataEffettivaUltima<ultima.getDurata() || ultima.getNome().endsWith("ward"))
				ultima.setDurata((int)durataEffettivaUltima);
			accorpa(ultima);
		}
		System.err.println(this);
		istanteInizioUltimaAzione=System.currentTimeMillis();
		return super.push(a);
	}
}
