
require(RMySQL)

url_bd <- "iml-science-4.ent.dfo-mpo.ca"
port_bd <- 25993
nom_bd <- "andesdb"
nom_usager <- Sys.getenv("NOM_USAGER_BD")
mot_de_passe <- Sys.getenv("MOT_DE_PASSE_BD")

# etablir la connection BD
andes_db_connection <- dbConnect(RMySQL::MySQL(),
                                dbname=nom_bd,
                                host=url_bd,
                                port=port_bd,
                                user=nom_usager,
                                password=mot_de_passe)

# RMySQL::dbListConnections( dbDriver( drv = "MySQL") )
