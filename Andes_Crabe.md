# Table mesures  
- `OBS` : simplement un no. séquentiel i.e., le num de ligne ?  
- `Mesureur` : Nom du mesureur, je peux donne les noms d'ANDES? i.e., seanfd, sauthier, sarah, isabelle,  (et pas DS, GC, SL, IL)  
- `Date` :  date-heure debut trait)
- `MISSION` : chiffres? je peux dire IML-2025-007 ?  
- `ANNEE` : doit calculer (selon date-heure debut trait)
- `MOIS` : doit calculer (selon date-heure debut trait)
- `JOUR` : doit calculer (selon date-heure debut trait)
- `TRAIT` : chiffre séquentiel? je peux donner le num. trait d'ANDES (il va parfois avoir des trous pour les traits manquants / CTDs)  
- `NO_ECHAN` : Meme chose de TRAIT?   
- `REPLICAT` : ??  
- `SPECIMEN` : On dirait le no. specimen du trait (recommence a 1 pour chauque nouveau trait.) Je peux donner le no. specimen unique d'ANDES?  
- `Espece` : Je peux donner le APHIA_ID et/ou le nom binomial ? ou les deux?  (CO etc...)
- `N_USAGER` : ??  
- `SEXE` : 1= Male, 2 = Femelle     
- `ETAT_CRA` : État de la carapace crabe  (1-3): Hyas vs (1-4): Crabe Commun vs (1-5): Crabe des neiges ?  
- `ETAT_EXO` : ??  
- `MATURITE` : Maturité  
- `LARG_CAR` : Largeur céphalo  
- `HAUT_PIN` : Hauteur pince  
- `PATT_MAN` : on diriait que c'est le nombre de pattes manquantes, je peux donner le code (ex. 1B4C5C) ?  
- `DUROMETR` : Duromètre  
- `LARG_ABD` : Largeur 5ieme segment  
- `STAT_FEM` : Stade maturité crabe (0-2)  
- `DEV_OEUF` : Développement des oeufs (crabe) (1-4)  
- `QUAL_OF` : Description des oeufs  
- `DACTYLP3` : ??  
- `DACTYLP8` : ??  
- `DACTYLP4` : ??  
- `DACTYLP9` : ??  
- `PDS_HUM` : ??    
- `TRACE_AC` : ??  
## autre
l'heure?
commentaire specimen?

# Table de traits  
- `MISSION` : Mission Andes (`shared_models_mission.mission_number`)  
- `TRAIT` : Trait Andes (`shared_models_sample.sample_number`)  
- `NO_ECHAN` : Trait Andes (`shared_models_sample.sample_number`)  
- `ANNEE` : doit calculer (selon date-heure debut trait)  
- `MOIS` : doit calculer (selon date-heure debut trait)  
- `JOUR` : doit calculer (selon date-heure debut trait)  
- `ENGIN` : Observation Trait (`shared_models_sampleobservationtypecategory.description_fra`)  
- `PROF_MOY` : doit calculer !?  
- `HEUR_DEB` : Trait Andes (`shared_models_sample.start_date`)    
- `HEUR_FIN` : Trait Andes (`shared_models_sample.end_date`)  
- `LAT_DEB` : Trait Andes (`shared_models_sample.start_latitude`)  
- `LON_DEB` : Trait Andes (`shared_models_sample.start_longitude`)  
- `LAT_FIN` : Trait Andes (`shared_models_sample.end_latitude`)  
- `LON_FIN` : Trait Andes (`shared_models_sample.end_longitude`)  
- `DUREE` : Trait Andes (`shared_models_sample.duration`)  
- `VITESSE` : Trait Andes (`shared_models_sample.speed`)  
- `TEMP_FND` : ??  
- `DATA_BIO` : ??  
- `COMPLET` : Trait Andes (`shared_models_sample.is_valid`)  
- `PONDER` : ??  
- `NAVIRE` : Mission Andes (`shared_models_mission.vessel_name`)  
- `SECTEUR` : Mission Andes (`shared_models_mission.area_of_operation`_)  

# autre (mes ajouts)
- `STATION` Station Andes (`shared_models_station.name`)
profondeur_debut
profondeur_fin
profondeur_min
profondeur_max
- `NOTES` Trait Andes(`shared_models_sample.remarks`)

## autres
tracé de profondeur (données du senseur, besoin pour profondeur moyenne?)
tracé de mission (gpx)
