

rm()

# Infos mission andes
url_bd <- "iml-science-4.ent.dfo-mpo.ca"
port_bd <- 25993
nom_bd <- "andesdb"
nom_usager <- Sys.getenv("NOM_USAGER_BD")
mot_de_passe <- Sys.getenv("MOT_DE_PASSE_BD")


# établir connexion BD (il faut être sur le réseau MPO)
andes_db_connection <- andes_db_connect(
  url_bd = url_bd,
  port_bd = port_bd,
  nom_usager = nom_usager,
  mot_de_passe = mot_de_passe,
  nom_bd = nom_bd
)

# les traits
traits <- get_fishing_sets_bsm(andes_db_connection)
View(traits)

# les spécimens
specimens <- get_specimen_bsm(andes_db_connection)
View(specimens)

