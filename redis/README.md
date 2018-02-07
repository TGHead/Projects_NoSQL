# Redis



## Pour créer un nouvel appel :


```CQL
# On crée d'abord un compteur qui va servir d'identifiant aux appels et on l'initialise à 0 :

SET callId 0
INCR callId
GET callId
# 1 est ici la valeur de callId
HMSET call:1 hour "20:10"
HMSET call:1 number "0240762550"
HMSET call:1 status "non affected"
HMSET call:1 duration "25s"
HMSET call:1 opId "5"
HMSET call:1 text "he wants to talk to the manager"
```

Lorsqu'un appel est compl

# On crée un compteur qui va servir d'identifiant aux opérateurs:
```CQL
SET opId 0
```

# Pour créer un nouvel opérateur : 
```CQL
INCR opId
GET opId
#1 est ici la valeur de opId
HMSET op:1 name "Jacques"
HMSET op:1 name "Chiraq"
```

# Ensemble des appels en cours: 
Je n'ai pas réussi à implémenter redis dans node malgré mes efforts, donc je n'ai pas pu vérifier que les commandes suivantes marchaient

client.get("callId", function(err,reply){
	var callnb=reply;
});

