# Vision
Custom language, zooming, top-down

## Requisiti

Estendiamo i requisiti visti in M1.

In questo problema si elimina l’assunzione che il robot riesca sempre a percorrere il percorso in linea retta. 
è richiesto che *il robot arrivi ad una distanza db dal sonar B di arrivo*(**R4**) .

Dovrà quindi attuare delle strategie che gli permettano di arrivare al punto richiesto da B. 
Osservando il mondo proposto dal prof, possiamo fare l'assunzione che il sonar il robot ce l'avrà sempre alla sua sinistra.
Dunque se il sonar gli dice che è troppo lontano, allora il robot dovrà girare verso sinistra, se invece è troppo vicino, dovrà ruotare verso destra.
 
## Analisi
### Analisi dei requisiti
User story.
(vedi quelle precedenti di M1)
Come utente, voglio che il robot si fermi quando si trova ad una certa distanza "giusta" *db* (con una certa incertezza) dal sonar B.
Come utente, voglio che se il robot si trova davanti al sonarB, ma si trova troppo lontano, si avvicini al sonarB fino a raggiungere la distanza giusta.
Come utente, voglio che se il robot si trova davanti al sonarB, ma si trova troppo vicino, si allontani dal sonar fino a raggiungere la distanza giusta.

### Analisi del problema
Struttura  - Interazione - Comportamento
 
Struttura:
Un robot, un sonar A (di partenza), un sonar B (di arrivo) ed una console.
 
Interazione:
I sonar emettono il seguente evento quando rilevano qualcosa: "roverDetected(X, P)" [X: etichetta del sonar, D distanza dal sonar {near, ok, far}]. Quando quel qualcosa non è più rilevato emettono l'evento "roverLeave(X)" [X: etichetta del sonar]
Il sonar A emette sempre roverDetected(a, ok) quando rileva il rover.
Il sonar B emette:
	- roverDetected(b, ok) quando il rover è alla distanza giusta.
	- roverDetected(b, near) quando il rover è ad una distanza_rilevata < db.
	- roverDetected(b, far) quando il rover è ad una distanza_rilevata > db.
	

Comportamento:
Alla ricezione dell’evento start, il robot inizia a muoversi avanti.
- Alla ricezione del segnale roverDetected(b, ok), il robot si ferma.
- Alla ricezione del segnale roverDetected(b, near), e il robot non ha il sonar **davanti**, ruota di 90° a sinistra e si muove avanti.
- Alla ricezione del segnale roverDetected(b, far), e ha il sonar **davanti**, si muove avanti.
- Alla ricezione del segnale roverDetected(b, near), e il robot non ha il sonar **dietro**, ruota di 90° a destra e si muove avanti.
- Alla ricezione del segnale roverDetected(b, far), e ha il sonar **dietro**, si muove avanti.


## Progettazione

#### Rover
Il rover ha una percezione del suo orientamento nello spazio. Dalla modellazione del problema assumiamo inizialmente che il rover abbia il sonar B alla sua sinistra (ma più avanti rispetto a se, inizialmente infatti non è rilevato).

Per rappresentare la conoscenza dello spazio usiamo la base di conoscenza del robot. Che viene poi utilizzata per pianificare le azioni.


### TestPlan
-[ ] Mettere il robot nel punto esatto davanti a B, non deve muoversi
-[ ] Posizionare il robot troppo vicino davanti al sensore B, deve  girare a destra di 90° e muoversi avanti fino al punto esatto
-[ ] Posizionare il robot troppo lontano davanti al sensore B, deve girare a sinistra di 90° e muoversi avanti fino al punto esatto

### Sprint planning
- Modificare gli eventi di M1 per supportare anche la distanza
- Modificare il piano di stop del rover
- Creare il piano per gestire il caso in cui si è troppo lontani dal sonarB
- Creare il piano per gestire il caso in cui si è troppo vicini al sonarB
- Fare i test
