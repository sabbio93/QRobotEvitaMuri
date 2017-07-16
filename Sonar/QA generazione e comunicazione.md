mi serve della cocaina

#### Registrazione dei QActor

I QActor sono UntypedAbstractActor, ovvero degli attori particolari ottimizzati.
Infatti derivano da AbstractActor, Attori Akka che consentono l'utilizzo delle lambda expressions.
I QActor sono quindi [Actor Akka](http://doc.akka.io/docs/akka/current/scala/general/actors.html) con funzionalità in più.

Sono organizzati in QActorContext. Un QActorContext è un contenitore di QActor all'interno dello stesso nodo (accessibile con stesso ip e porta). Ogni QActorContext ha un [Akka ActorSystem](http://doc.akka.io/docs/akka/current/scala/general/actor-systems.html).

L'ActorContext a provvedere ad [avviare gli attori](http://doc.akka.io/docs/akka/current/java/actors.html) che gli si chiede di registrare (allocazione risorse, avvio thread etc...), permette di farlo attraverso il metodo facotry .
`akkacontext_instance.actorOf(
					Proprieties, actorName );`

Essendo i QA attori devono essere anche loro avviati in questo modo.
Nel metodo `activateAkkaActorsInContext(ActorContext)` in QActorContext vengono recuperati tutti i QActor dalla knowledgebase (per nome) infine vengono inizializzati con il metodo di cui sopra. Nella classe QActorContext viene mantenuta una mappa che associa il nome del QActor con il riferimento [ActorRef](http://doc.akka.io/api/akka/2.0/akka/actor/ActorRef.html)

I QActor da attivare sono cercati attraverso nella knowledgebase del QActorContext che sta venendo avviato, usando TuProlog si ottengono i QActor (o gli EventHandler/Robot etc)


```
%====================================================================================
% Context ctxController  SYSTEM-configuration: file it.unibo.ctxController.m1.pl
%====================================================================================
context(ctxrover, "192.168.137.2",  "TCP", "8070" ).  		 
context(ctxcontroller, "192.168.137.1",  "TCP", "8040" ).  		 
%%% -------------------------------------------
qactor( robotmind , ctxcontroller, "it.unibo.robotmind.MsgHandle_Robotmind"   ). %%store msgs
qactor( robotmind_ctrl , ctxcontroller, "it.unibo.robotmind.Robotmind"   ). %%control-driven
%%% -------------------------------------------
%%% -------------------------------------------
qactor( rover , ctxrover, "it.unibo.rover.MsgHandle_Rover" ).
qactor( rover_ctrl , ctxrover, "it.unibo.rover.Rover" ).
```

Come si vede vengono caricati "nome + nome contesto + nome della classe da caricare"

Per attivare dinamicamente un nuovo QActor non basta attivarlo all'interno dell'ActorSystem, bisogna anche aggiornare KB e altri parametri interni al contesto.

Quindi bisogna usare

`qactorcontext_instance.addInstance(QActorContext ctx, String actorid, String className, IOutputEnvView view)`

Il QActor sa in quale contesto si trova dall'inizializzazione akka "actorOf", in quanto in Proprieties vengono inseriti tutti i parametri necessari nei costruttori.

Durante l'inizializzazione dei QActor vengono creati due Attori, non uno.
- Un attore con la stessa classe che ho specificato io -> chiamato *miaclasse_ctrl*
- Un attore con *packageclasse.MsgHandle_miaclasse* chiamato *miaclasse*

L'attore che esegue veramente i piani è miaclasse_ctrl. L'altro implementa l'interfaccia *it.unibo.qactors.action.IMessageQueue*, la sua responsabilità è solamente quella di ricevere e gestire i messaggi da parte degli altri attori, per fornire una visione **message-based** al QActor_Ctrl.

#### Messaggiare ai tempi di QActor
La comunicazione tra Attori Akka avviene tramite scambio di messaggi, dunque i QActor comunicano tra loro per messaggi. In Akka la comunicazione è **message-driven**: il flusso di esecuzione è interamente controllato dalla gestione dei messaggi ricevuti.

Grazie alla classe MsgHandle_mioQActor abbiamo la possibilità di comunicare in maniera **message-based**, colmando l'abstraction gap introdotto da Akka.

Quando viene mandato un messaggio viene sempre ricevuto dal QActor che gestisce i messaggi (non quello dei piani). Quando il QActor dei piani vuole fare una lettura (reciveMsg)


```
public void sendMsg(String msgID, String dest, String msgType, String msg) throws Exception {
//  		println(getName() +" sendMsg " + msgID + " to " + dest );
  //Prepare the massage
   QActorMessage mout  = QActorUtils.buildMsg(myCtx, getName(), msgID, dest, msgType, msg);

   ActorRef destActor = myCtx.getActorRefInQActorContext(dest);
   if(destActor != null) destActor.tell( mout, getSelf() );
   else{//dest should be remote
     try{
       SenderObject sa = myCtx.getSenderAgent( dest );
       msg=envelope(msg);
//			 println(getName() +" sendMsg   " + msg + " to " + sa);
       sa.sendMsg( this, dest, msgID, msgType, msg );
     }catch(Exception e){
       println("sendMsg " + getName() +" dest NOT FOUND   "  );
     }			 
   }
}
```


#### Emettere eventi ai tempi di QActor
Non ci sono più gli eventi di una volta...

Infatti in QActor gli eventi possono essere:
- globali (tutti i contesti lo ricevono)
- locali (solo i QActor appartenenti allo stesso contesto) -> bisogna aggiungere il prefisso **local_**nomeevento ****

```
public void emit( String evId, String evContent ) {
  set_evlpActorSel();
//		System.out.println("QActor " + getName() + " emit " + evId + " evContent=" + evContent   );
  //Send a message to the context event loop actor
  IEventItem ev = QActorUtils.buildEventItem(  this.getName(), evId, evContent  );
  evlpActorRef.tell(ev, getSelf());
//		println("QActor " + getName() + " emit " + evId + " evContent=" + evContent  + " evlpActorRef=" + evlpActorRef);
    if( ! evId.startsWith(QActorUtils.locEvPrefix)){
      String evRep = ev.getPrologRep();
      try {
      QActorUtils.propagateEvent(this.myCtx,evRep);
    } catch (Exception e) {
      e.printStackTrace();
    }
    }
}
```
