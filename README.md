# Projects_NoSQL
[TSE-FISE3-OPT-INFO2] les projets de module NoSQL

## Cassandra

### Description

Modéliser dans Cassandra une base de données permettant de stocker les données remontées par des stations météo

Données remontées :
* Identifiant de la station météo
* Longitude / Latitude de la mesure
* Horodate de la mesure
* Température relevée
* Humidité relevée

La modélisation doit permettre les requêtes efficaces suivantes :
* Récupération des mesures pour un identifiant de station météo donnée.
* Récupération des mesures pour un identifiant de station météo donnée et une plage de temps donnée.

&emsp;&emsp;Exprimer les requêtes d’insertion de relevés de mesure.  
&emsp;&emsp;Exprimer les requêtes de sélection mentionnées précédemment.

### Scripts Cassandra (cqlsh)

#### Create Table
```CQL
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

```

#### Exprimer les requêtes de insertion

```CQL
# Insertion des données
INSERT INTO meteo (stationID, longitude, latitude, horodate, temperature, humidite) 
     VALUES ('70B3D580A010055B',45.43633979279548, 4.377930471673608, '1517932071000', 9.5625, 0.28);
     
INSERT INTO meteo (stationID, longitude, latitude, horodate, temperature, humidite) 
     VALUES ('70B3D580A010055B',45.43633979279548, 4.377930471673608, '1517939632000', 9.625, 0.38);

INSERT INTO meteo (stationID, longitude, latitude, horodate, temperature, humidite) 
     VALUES ('70B3D580A010055B',45.43633979279548, 4.377930471673608, '1517945774000', 9.6875, 0.33);
     
INSERT INTO meteo (stationID, longitude, latitude, horodate, temperature, humidite) 
     VALUES ('70B3D580A0100594',45.43731477577239, 4.379695532843471, '1517940712000', 0.5625, 0.35);
     
INSERT INTO meteo (stationID, longitude, latitude, horodate, temperature, humidite) 
     VALUES ('70B3D580A0100594',45.43731477577239, 4.379695532843471, '1517946472000', -1.5225, 0.38);
     
```

#### Exprimer les requêtes de sélection

```CQL
# Sélection des toutes les données de la station '70B3D580A0100594'
SELECT * FROM meteo WHERE stationID = '70B3D580A0100594' AND longitude = 45.43731477577239 AND latitude = 4.379695532843471;

```
C'est le resultat de requête de select dessus:

|    stationID     |   longitude   |   latitude   |             horodate            |  humidite  |  temperature  |
| ---------------- | ------------- | ------------ | ------------------------------- | ---------- | ------------- |
| 70B3D580A0100594 |    45.43731   |     4.3797   | 2018-02-06 18:11:52.000000+0000 |    0.35    |     0.5625    |
| 70B3D580A0100594 |    45.43731   |     4.3797   | 2018-02-06 19:47:52.000000+0000 |    0.38    |    -1.5225    |

```CQL
# Sélection des toutes les données de la station '70B3D580A010055B' durant 17h et 19h de 08/02/2018
SELECT * FROM meteo WHERE stationID = '70B3D580A010055B' AND longitude = 45.43633979279548 AND latitude = 4.377930471673608 AND horodate > '2018-02-06 17:00:00' AND horodate < '2018-02-06 19:00:00';

```

C'est le resultat de requête de select dessus:


|    stationID     |   longitude   |    latitude   |             horodate            |  humidite  | temperature |
| ---------------- | ------------- | ------------- | ------------------------------- | ---------- | ----------- |
| 70B3D580A010055B |    45.43634   |     4.37793   | 2018-02-06 17:53:52.000000+0000 |    0.38    |    9.625    |
