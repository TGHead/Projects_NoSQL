# Quelques examples des requêtes de recherche:
MATCH (e:Entreprise) WHERE e.nom STARTS WITH "X" RETURN e;
MATCH (e:Entreprise) WHERE e.nom ENDS WITH "an" RETURN e;

MATCH (u:Utilisateur) WHERE u.nom CONTAINS "UN" RETURN u;
MATCH (u:Utilisateur) WHERE u.nom =~ "(?i)zh.*" RETURN u;

# Utilisateurs ayant travaillé en même temps
MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u:Utilisateur{nom:"GRAVIER", prenom:"Christophe"})-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);

MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u:Utilisateur{nom:"SUBERCAZE", prenom:"Julien"})-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);

MATCH (u)-[r]->() MATCH ({nom:"GIRODON"})-[R:Travailler_Pour]->({nom:"Télécom Saint-Etienne"}) WHERE r.pendant=R.pendant RETURN u;

# Utilisateurs connus par les connaissances d’un utilisateur donné
MATCH (u) WHERE (u)-[:Connait]->({nom: "GIRODON"}) RETURN u;
