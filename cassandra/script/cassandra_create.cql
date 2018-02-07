# Creer le KeySpace meteo avec des paramètres pour lancer sur une seule machine.

CREATE KEYSPACE meteo WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
USE meteo;

# Creer la table 
# Avec le primary key comporte des 'sationID', 'longitude', 'latitude' et 'horodate'.
# le partition key est un composite key des 'sationID', 'longitude', 'latitude'.
# le clustering key est horodate.
# L'idée de modéliser ce primary key est pour adapter la situation logique et avec la partition key est la combinaison de 3 champs qui permet de stocker des données dans les nœuds selon leur positions géographiques. Comme cela pourrait diminuer des échanges des données relativement.

CREATE TABLE meteo ( 
    stationID text, 
    longitude double, 
    latitude double, 
    horodate timestamp, 
    temperature double, 
    humidite double,
    PRIMARY KEY ( (stationID, longitude, latitude), horodate) );
