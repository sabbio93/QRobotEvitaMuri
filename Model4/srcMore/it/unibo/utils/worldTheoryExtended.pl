% metodi per sopperire alla mancanza di una regola per ottenere il risultato delle actorOp
% 
actorOpDone(NomeMetodo, d(Risultato)) :- actorOpDone(NomeMetodo, actorOp(d(Risultato), _)).
actorOpDone(NomeMetodo, d(Risultato), TRim) :- actorOpDone(NomeMetodo, actorOp(d(Risultato), timeremained(TRim))).

risultatoActorOp(NomeMetodo, Risultato) :- actorOpDone(NomeMetodo, actorOp(Risultato, _)).
risultatoActorOp(NomeMetodo, Risultato, TRim) :- actorOpDone(NomeMetodo, actorOp(Risultato, timeremained(TRim))).

