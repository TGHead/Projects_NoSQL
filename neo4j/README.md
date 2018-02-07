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

Exprimer les requêtes d’insertion   
* D’entreprises  
* D’utilisateurs  
* De relations 

Mettre en place le nécessaire pour des requêtes de recherche d’entreprises ou d’utilisateurs par nom.

Exprimer ces requêtes de recherche par nom.

Exprimer des requêtes de suggestions de relations
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
