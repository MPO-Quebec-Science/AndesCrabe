
source('specimen_crabe_BSM.R')
specimens <- get_specimen_observations_BSM(andes_db_connection, mission_id = 67)
View(specimens)

source('plot_depth_profile.R')
plot_depth_profile(andes_db_connection, mission_id = 67, set_number = 34)



url_bd <- "iml-science-4.ent.dfo-mpo.ca"
port_bd <- 25993
nom_bd <- "andesdb"
nom_usager <- Sys.getenv("NOM_USAGER_BD")
mot_de_passe <- Sys.getenv("MOT_DE_PASSE_BD")
andes_db_connection <- andes_db_connect(
  url_bd = url_bd,
  port_bd = port_bd,
  nom_usager = nom_usager,
  mot_de_passe = mot_de_passe,
  nom_bd = nom_bd
)


sets <- get_fishing_sets_bsm(andes_db_connection)
View(sets)

specimens <- get_specimen_bsm_db(andes_db_connection)
View(specimens)

# install.packages("devtools")
# install.packages("roxygen2")
# devtools::create("ANDESCrabe")

rm()
devtools::load_all()
devtools::document()
