# Neo4j

## Description

Modéliser dans Neo4j un « LinkedIn-like » :

**Des Entreprises :**
* Nom
* Secteur d’activité
* Description
* Taille

**Des Utilisateurs :**
* Nom, Prénom
* Description
* Liste des compétences

**Relations Utilisateurs - Entreprise :**
* « A travaillé pour »
  * Du … au …
  * En tant que … (salarié, sous-traitant)
  
**Relations Utilisateurs – Utilisateurs :**
* « A travaillé avec »
* « Connait »

1. Exprimer les requêtes d’insertion   
* D’entreprises  
* D’utilisateurs  
* De relations 

Mettre en place le nécessaire pour des requêtes de recherche d’entreprises ou d’utilisateurs par nom.

2. Exprimer ces requêtes de recherche par nom.

3. Exprimer des requêtes de suggestions de relations
* Utilisateurs ayant travaillé en même temps (qu’un utilisateur donné dans une entreprise donnée)
* Utilisateurs connus par les connaissances d’un utilisateur donné


## Scripts Neo4j

### Structure de données

#### Nœud (Entreprise et Utilisateur)
```CQL
# Nœud d'entreprise
(e_x:Entreprise {nom: "nom d'entreprise", secteur: "secteur d’activité", description: "description d'entreprise", taille: effectif})

# Nœud d'utilisateur
(u_x:Utilisateur {nom: "nom d'utilisateur", prenom: "prenom d'utilisateur", description: "description d'utilisateur", liste_competence: "competence1 competence2 ..."})
```

#### Relation
```CQL
# Relation parmi des entreprises et utilisateurs
-[r_eu_x:Travailler_Pour {pendant: ["du xx/xx/xx au xx/xx/xx"], titre: ["titre d'utilisateur dans l'entreprese"]}]->

# Relation parmi des utilisateurs
-[r_uu_x:Travailler_Avec]->
-[r_uu_x:Connait]->
```

### Exprimer les requêtes d’insertion
```CQL
# Creer 2 nœuds d'entreprise
CREATE(e_0:Entreprise {nom: "XXII Group", secteur: "IT", description: "un startup se concentre sur la domaine de VR et AI", taille: 60});

CREATE(e_1:Entreprise {nom: "Telenav Xian", secteur: "IT", description: "une entreprise internationale se concentre sur les services de la navigation automobile", taille: 80});

CREATE(e_2:Entreprise {nom: "Télécom Saint-Etienne", secteur: "Education", description: "une école d'ingénieur des nouvelles technologies", taille: 120});
```
![neo4j_create_nodes_entreprise_1](./img/neo4j_create_nodes_entreprise_1.png)

```CQL
# Creer 2 nœuds d'utilisateur
CREATE(u_0:Utilisateur {nom: "ZHAN", prenom: "Haoming", description: "un élève FISE3", liste_competence: "Neo4j Cassandra"});

CREATE(u_1:Utilisateur {nom: "LAUNAY", prenom: "Nicolas", description: "un élève FISE3", liste_competence: "MongoDB Redis"});

CREATE(u_2:Utilisateur {nom: "GIRODON", prenom: "Remy", description: "l'enseignant de NoSQL", liste_competence: "MongoDB Redis Neo4j Cassandra"});
```
![neo4j_create_nodes_user_1](./img/neo4j_create_nodes_user_1.png)

```CQL
# Creer les relations parmi des entreprises et utilisateurs
MATCH(u:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) MATCH(e:Entreprise{nom:"XXII Group"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 05/03/18 au 31/08/18"], titre: ["stagiaire"]}]->(e);

MATCH(u:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(e:Entreprise{nom:"Telenav Xian"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 05/03/18 au 31/08/18"], titre: ["stagiaire"]}]->(e);

MATCH(u:Utilisateur{nom:"GIRODON", prenom:"Remy"}) MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);
```
![neo4j_create_relations_eu_1](./img/neo4j_create_relations_eu_1.png)

```CQL
# Creer les relations parmi des utilisateurs (« Connait »):
MATCH(u0:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) MATCH(u1:Utilisateur{nom:"GIRODON", prenom:"Remy"}) CREATE (u0)-[r_uu_x:Connait]->(u1);

MATCH(u0:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(u1:Utilisateur{nom:"GIRODON", prenom:"Remy"}) CREATE (u0)-[r_uu_x:Connait]->(u1);

# Creer les relations parmi des utilisateurs (« Travailler_Avec »):
MATCH(u0:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(u1:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) CREATE (u0)-[r_uu_x:Travailler_Avec]->(u1);
```
![neo4j_create_relations_uu_1](./img/neo4j_create_relations_uu_1.png)

### Mettre en place le nécessaire pour des requêtes de recherche
```CQL
# Ajouter l'indice sur nom pour 2 types de nœuds pour faciliter des opérations recherche
CREATE INDEX ON :Entreprise(nom);
CREATE INDEX ON :Utilisateur(nom);
```

### Exprimer ces requêtes de recherche par nom
```CQL
# Quelques examples des requêtes de recherche:
MATCH (e:Entreprise) WHERE e.nom STARTS WITH "X" RETURN e;
MATCH (e:Entreprise) WHERE e.nom ENDS WITH "an" RETURN e;

MATCH (u:Utilisateur) WHERE u.nom CONTAINS "UN" RETURN u;
MATCH (u:Utilisateur) WHERE u.nom =~ "(?i)zh.*" RETURN u;
```

### Exprimer des requêtes de suggestions de relations
```CQL
# Utilisateurs ayant travaillé en même temps
MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u:Utilisateur{nom:"GRAVIER", prenom:"Christophe"})-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);

MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u:Utilisateur{nom:"SUBERCAZE", prenom:"Julien"})-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);

MATCH (u)-[r]->() MATCH ({nom:"GIRODON"})-[R:Travailler_Pour]->({nom:"Télécom Saint-Etienne"}) WHERE r.pendant=R.pendant RETURN u;

# Utilisateurs connus par les connaissances d’un utilisateur donné
MATCH (u) WHERE (u)-[:Connait]->({nom: "GIRODON"}) RETURN u;
```
![requête_relation1](./img/requête_relation1.png)
![requête_relation2](./img/requête_relation1.png)
