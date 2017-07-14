actorName(N):-actorobj(A),A<-getName returns N.
contextName(N):-actorobj(A),A<-getQActorContext returns N.
contextHost(H):-contextName(N),getCtxHost(N,H).
contextPort(P):-contextName(N),getCtxPort(N,P).
