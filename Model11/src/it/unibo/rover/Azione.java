package it.unibo.rover;

class Azione {
	private String nome;
	private int durata;
	private int velocita;
// private int nAz;
	Azione(String nome, int tempo, int velocita){
		this.nome=nome;
		this.durata=tempo;
//		this.nAz=n++;
	}
	public int getDurata(){
		return durata;
	}
	public void setDurata(int durata){
		this.durata=durata;
	}
	public String getNome(){
		return nome;
	}
	public Azione inverti(){
		if (nome==null)
			return this;
		switch (nome){
		case "robotForward":	return new Azione("robotBackward",durata,velocita);
		case "robotBackward":	return new Azione("robotForward",durata,velocita);
		case "robotLeft":		return new Azione("robotRight",durata,velocita);
		case "robotRight":		return new Azione("robotLeft",durata,velocita);
		default:				return this;
		}
	}
	public boolean stessoTipo(Azione a){
		return nome.equals(a.getNome());
	}
	public boolean tipoOpposto(Azione a){
		return inverti().getNome().equals(a.getNome());
	}
	public Azione concatena(Azione a){
		if (nome.equals("RobotStop"))
			return a;
		if (stessoTipo(a) && velocita==a.getVelocita())
			return new Azione(nome,durata+a.getDurata(),velocita);
		if (tipoOpposto(a) && velocita==a.getVelocita())
			if (durata==a.getDurata())
				return new Azione("robotStop",0,0);
			else if (durata>a.getDurata())
				return new Azione(nome,durata-a.getDurata(),velocita);
			else
				return new Azione(a.getNome(),a.getDurata()-durata,velocita);
		return null;
	}
	public int getVelocita(){
		return velocita;
	}
//	public int getNAz(){
//		return nAz;
//	}
}
