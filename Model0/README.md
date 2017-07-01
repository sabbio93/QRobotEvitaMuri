# Vision
Custom language, zooming, top-down

## Requisiti
- Il problema prevede di far percorrere a un robot una linea retta, alla pressione di un tasto start situato su una GUI. Rilevata la presenza del robot, tramite un sonar che chiameremo sonarB, nel punto B, disposto a una distanza non nota a priori, il robot si deve fermare.
- Il robot deve andare al punto B, posto davanti a lui e dotato di un sonar, alla pressione del tasto start

--- quale versione teniamo? 

 
## Analisi
### Analisi dei requisiti
User story: Come utente, Voglio muovere un robot avanti (R1) fino a quando non raggiunge la linea B. 
### Analisi del problema
Struttura  - Interazione - Comportamento
 
Struttura:
Un robot, un sonar ed una console.
 
Interazione:
Alla pressione del pulsante, il robot riceve l’evento start. 
B emette un evento stop ricevuto dal Robot.
 
Comportamento:
Alla ricezione dell’evento start, il robot inizia a muoversi avanti.
Alla ricezione del segnale stop, il robot si ferma.
 
## Progettazione

### Sprint planning
### Test plan
-[X] Premere il pulsante start, il rover si deve mettere in moto
-[X] Quando il rover è in moto, quando passa davanti al sonarB, si deve fermare