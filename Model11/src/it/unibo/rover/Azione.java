package it.unibo.rover;

class Azione {
	private String nome;
	private int durata;
	private int velocita;
//	private int nAz;
	
	Azione(String nome, int tempo, int velocita) {
		this.nome = nome;
		this.durata = tempo;
//		this.nAz = n++;
	}
	
	public int getDurata() {
		return durata;
	}
	public void setDurata(int durata) {
		this.durata = durata;
	}
	public String getNome() {
		return nome;
	}

	public Azione inverti() {
		if(nome == null) return this;
		switch(nome){
		case "robotForward": return new Azione("robotBackward", durata, velocita);
		case "robotBackward": return new Azione("robotForward", durata, velocita);
		//...
		default: return this;
		}
	}

	public int getVelocita() {
		return velocita;
	}
	
//	public int getNAz(){
//		return nAz;
//	}
}
