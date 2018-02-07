# Sélection des toutes les données de la station '70B3D580A0100594'
SELECT * FROM meteo WHERE stationID = '70B3D580A0100594' AND longitude = 45.43731477577239 AND latitude = 4.379695532843471;

# Sélection des toutes les données de la station '70B3D580A010055B' durant 17h et 19h de 08/02/2018
SELECT * FROM meteo WHERE stationID = '70B3D580A010055B' AND longitude = 45.43633979279548 AND latitude = 4.377930471673608 AND horodate > '2018-02-06 17:00:00' AND horodate < '2018-02-06 19:00:00';
