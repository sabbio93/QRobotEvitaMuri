# Vision
Custom language, zooming, top-down

## Requisiti

Estendiamo i requisiti visti in M1.

In questo problema si elimina l’assunzione che il robot riesca sempre a percorrere il percorso in linea retta. 
è richiesto che (**R4**) il robot arrivi ad una distanza db dal sonar B di arrivo.

Dovrà quindi attuare delle strategie che gli permettano di arrivare al punto richiesto da B. 
Osservando il mondo proposto dal prof, possiamo fare l'assunzione che il sonar il robot ce l'avrà sempre alla sua sinistra.
Dunque se il sonar gli dice che è troppo lontano, allora il robot dovrà girare verso sinistra, se invece è troppo vicino, dovrà ruotare verso destra.
 
## Analisi
### Analisi dei requisiti
User story.
(vedi quelle precedenti di M1)
Come utente, voglio che il robot si fermi quando si trova alla distanza *db* dal sonar B.
Come utente, voglio che se il robot si trova davanti al sonarB, ma a distanza > db, si muova per posizionarsi a distanza db dal sonarB.
Come utente, voglio che se il robot si trova davanti al sonarB, ma a distanza < db, si muova per posizionarsi a distanza db dal sonarB.

### Analisi del problema
Struttura  - Interazione - Comportamento
 
Struttura:
Un robot, un sonar A (di partenza), un sonar B (di arrivo) ed una console.
 
Interazione:
I sonar emettono il seguente evento quando rilevano qualcosa: "roverDetected(X, d(D))" [X: etichetta del sonar, D distanza del rilievo]. Quando quel qualcosa non è più rilevato emettono l'evento "roverLeave(X)" [X: etichetta del sonar]


Comportamento:
Alla ricezione dell’evento start, il robot inizia a muoversi avanti.
- Alla ricezione del segnale roverDetected(B, d(D)), se **D = db**, il robot si ferma.
- Alla ricezione del segnale roverDetected(B, d(D)), se **D > db**, e il robot non ha il sonar **davanti**, ruota di 90° a - sinistra e si muove avanti.
- Alla ricezione del segnale roverDetected(B, d(D)), se **D > db**, e ha il sonar **davanti**, si muove avanti.
- Alla ricezione del segnale roverDetected(B, d(D)), se **D < db**, e il robot non ha il sonar **dietro**, ruota di 90° a destra e si muove avanti.
- Alla ricezione del segnale roverDetected(B, d(D)), se **D < db**, e ha il sonar **dietro**, si muove avanti.


## Progettazione

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
