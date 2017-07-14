%%% API %%%
ricorda(N,V,T):-robotMove(M,N,V,0,T),ricorda(M).
ricorda(M):-systemTime(T),completaSalvataggio(T),inc(nRicorda,-1,I),assign(inizioMossaAttuale,T),assign(mossaAttuale,M).

ritornaACasa:-ricorda(robotStop(0,0,0)),findall(plan(I,tornaIndietro,S),plan(I,tornaIndietro,S),L),preparaPianoRitorno(L),findall(plan(I1,tornaIndietro,S1),plan(I1,tornaIndietro,S1),L1),actorPrintln(L1),runPlan(tornaIndietro).

%%% PREPARAZIONE PIANO %%%
preparaPianoRitorno([plan(I,tornaIndietro,sentence(true,move(M),_,_))|C]):-retract(plan(I,tornaIndietro,_)),value(nRicorda,N),I2 is I-N,mossaInversa(M,M2),getSentence(M2,S2),assert(plan(I2,tornaIndietro,S2)),preparaPianoRitorno(C).
preparaPianoRitorno([]):-value(nRicorda,NN),N is -NN,getSentence(robotStop(0,0,0),S),assert(plan(N,tornaIndietro,S)).

%%% MEMORIZZAZIONE %%%
value(nRicorda,0).

completaSalvataggio(T):-value(nRicorda,0),!.
completaSalvataggio(T):-value(nRicorda,I),value(mossaAttuale,M),durataEffettiva(M,T,M1),accorpa(M1,I).

durataEffettiva(robotForward(V,X,D),TF,robotForward(V,X,DE)):-!,value(inizioMossaAttuale,TI),DE is TF-TI.
durataEffettiva(robotBackward(V,X,D),TF,robotBackward(V,X,DE)):-!,value(inizioMossaAttuale,TI),DE is TF-TI.
durataEffettiva(robotLeft(V,X,D),TF,robotLeft(V,X,DE)):-value(inizioMossaAttuale,TI),DE is TF-TI,DE<D,!.
durataEffettiva(robotRight(V,X,D),TF,robotRight(V,X,DE)):-value(inizioMossaAttuale,TI),DE is TF-TI,DE<D,!.
durataEffettiva(M,TF,M).

accorpa(M,I):-I2 is I+1,plan(I2,tornaIndietro,sentence(true,M2,_,_)),concatenaMosse(M2,M1,MC),retract(plan(I2,tornaIndietro,_)),inc(nRicorda,1,_),accorpa(MC,I2).
accorpa(M,I):-getSentence(M,S),assert(plan(I,tornaIndietro,S)),actorPrintln(S).

%%% MOSSE %%%
mossaInversa(robotLeft(V,X,T),robotRight(V,X,T)):-!.
mossaInversa(robotRight(V,X,T),robotLeft(V,X,T)):-!.
mossaInversa(M,M).

%stessoTipo(M1,M2):-functor(M1,F,A),functor(M2,F,A).

mossaOpposta(robotForward(V,X,T),robotBackward(V,X,T)):-!.
mossaOpposta(robotBackward(V,X,T),robotForward(V,X,T)):-!.
mossaOpposta(robotLeft(V,X,T),robotRight(V,X,T)):-!.
mossaOpposta(robotRight(V,X,T),robotLeft(V,X,T)):-!.
mossaOpposta(M,M).

concatenaMosse(robotStop(V,X,T),M2,M2):-!.
concatenaMosse(M1,M2,MC):-M1=..[N,V,X,T1],M2=..[N,V,X,T2],!, TC is T1+T2,M1=..[N,V,X,TC].
concatenaMosse(M1,M2,MC):-M1=..[N1,V,X,T1],M2=..[N2,V,X,T2],mossaOpposta(M1,M2), differenza(N1,T1,N2,T2,NC,TC),MC=..[NC,V,X,TC].

differenza(N1,T,N2,T,robotStop,0):-!.
differenza(N1,T1,N2,T2,N1,TC):-T1>T2,!,TC is T1-T2.
differenza(N1,T1,N2,T2,N2,TC):-T1<T2,  TC is T2-T1.

getSentence(robotForward(V,X,T),sentence(true,move(robotForward(V,X,T)),'stop,alarm,ostacolo','fermaRobotUtente,gestisciAllarme,pausaRientro')):-!.
getSentence(robotStop(0,0,0),sentence(true,move(robotStop(0,0,0)),'','')):-!.
getSentence(M,sentence(true,move(M),'stop,alarm','fermaRobotUtente,gestisciAllarme')).

%%% UTIL. %%%
systemTime(T):-class('java.lang.System')<-currentTimeMillis returns T.

