
source('connexion_andes.R')

source('trait_crabe.R')
sets <- get_fishing_sets(andes_db_connection, mission_id = 67)
View(sets)

source('specimen_crabe.R')
specimens <- get_specimen_observations(andes_db_connection, mission_id = 67)
View(specimens)

source('plot_depth_profile.R')
plot_depth_profile(andes_db_connection, mission_id = 67, set_number = 34)

