
source('connexion_andes.R')

source('trait_crabe_bsm.R')
sets <- get_fishing_sets_bsm(andes_db_connection, mission_id = 67)
View(sets)

traits <- format_pour_crabe_trait(sets)
View(traits)

source('specimen_crabe_BSM.R')
specimens <- get_specimen_observations_BSM(andes_db_connection, mission_id = 67)
View(specimens)

source('plot_depth_profile.R')
plot_depth_profile(andes_db_connection, mission_id = 67, set_number = 34)


mission_id <-67
