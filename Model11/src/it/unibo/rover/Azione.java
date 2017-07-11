package it.unibo.rover;

class Azione {
	private String nome;
	private int durata;
	private int velocita;
// private int nAz;
	Azione(String nome, int durata, int velocita){
		this.nome=nome;
		this.durata=durata;
		this.velocita=velocita;
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
		//case "forward":	return new Azione("backward",durata,velocita);
		//case "backward":return new Azione("forward",durata,velocita);
		case "left":	return new Azione("right",durata,velocita);
		case "right":	return new Azione("left",durata,velocita);
		default:		return this;
		}
	}
	public boolean stessoTipo(Azione a){
		return nome.equals(a.getNome());
	}
	public boolean tipoOpposto(Azione a){
		String opposto;
		switch (nome){
		case "forward":	opposto="backward"; break;
		case "backward":opposto="forward"; break;
		case "left":	opposto="right"; break;
		case "right":	opposto="left"; break;
		default:		opposto=nome;
		}
		return opposto.equals(a.getNome());
	}
	public Azione concatena(Azione a){
		if (nome.equals("stop"))
			return a;
		if (stessoTipo(a) && velocita==a.getVelocita())
			return new Azione(nome,durata+a.getDurata(),velocita);
		if (tipoOpposto(a) && velocita==a.getVelocita())
			if (durata==a.getDurata())
				return new Azione("stop",0,0);
			else if (durata>a.getDurata())
				return new Azione(nome,durata-a.getDurata(),velocita);
			else
				return new Azione(a.getNome(),a.getDurata()-durata,velocita);
		return null;
	}
	public int getVelocita(){
		return velocita;
	}
	public String toString(){
		return String.format("%s speed(%d) time(%d) ",nome,velocita,durata);
	}
//	public int getNAz(){
//		return nAz;
//	}
}
