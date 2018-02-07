# Creer 2 nœuds d'entreprise
CREATE(e_0:Entreprise {nom: "XXII Group", secteur: "IT", description: "un startup se concentre sur la domaine de VR et AI", taille: 60});

CREATE(e_1:Entreprise {nom: "Telenav Xian", secteur: "IT", description: "une entreprise internationale se concentre sur les services de la navigation automobile", taille: 80});

CREATE(e_2:Entreprise {nom: "Télécom Saint-Etienne", secteur: "Education", description: "une école d'ingénieur des nouvelles technologies", taille: 120});

# Creer 2 nœuds d'utilisateur
CREATE(u_0:Utilisateur {nom: "ZHAN", prenom: "Haoming", description: "un élève FISE3", liste_competence: "Neo4j Cassandra"});

CREATE(u_1:Utilisateur {nom: "LAUNAY", prenom: "Nicolas", description: "un élève FISE3", liste_competence: "MongoDB Redis"});

CREATE(u_2:Utilisateur {nom: "GIRODON", prenom: "Remy", description: "l'enseignant de NoSQL", liste_competence: "MongoDB Redis Neo4j Cassandra"});

# Creer les relations parmi des entreprises et utilisateurs
MATCH(u:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) MATCH(e:Entreprise{nom:"XXII Group"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 05/03/18 au 31/08/18"], titre: ["stagiaire"]}]->(e);

MATCH(u:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(e:Entreprise{nom:"Telenav Xian"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 05/03/18 au 31/08/18"], titre: ["stagiaire"]}]->(e);

MATCH(u:Utilisateur{nom:"GIRODON", prenom:"Remy"}) MATCH(e:Entreprise{nom:"Télécom Saint-Etienne"}) CREATE (u)-[r_eu_x:Travailler_Pour {pendant: ["du 01/09/17 au 16/02/18"], titre: ["enseignant"]}]->(e);

# Creer les relations parmi des utilisateurs (« Connait »):
MATCH(u0:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) MATCH(u1:Utilisateur{nom:"GIRODON", prenom:"Remy"}) CREATE (u0)-[r_uu_x:Connait]->(u1);

MATCH(u0:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(u1:Utilisateur{nom:"GIRODON", prenom:"Remy"}) CREATE (u0)-[r_uu_x:Connait]->(u1);

# Creer les relations parmi des utilisateurs (« Travailler_Avec »):
MATCH(u0:Utilisateur{nom:"ZHAN", prenom:"Haoming"}) MATCH(u1:Utilisateur{nom:"LAUNAY", prenom:"Nicolas"}) CREATE (u0)-[r_uu_x:Travailler_Avec]->(u1);

# Ajouter l'indice sur nom pour 2 types de nœuds pour faciliter des opérations recherche
CREATE INDEX ON :Entreprise(nom);
CREATE INDEX ON :Utilisateur(nom);
