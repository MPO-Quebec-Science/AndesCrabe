

#' Establish a connection to the andes database
#'
#' This is a wrapper for the `RMySQL::dbConnect`, see it's documentation for more details.
#' @param url_bd URL of the ANDES database server.
#' @param port_bd Port number for the ANDES database connection.
#' @param nom_usager Username for the ANDES database.
#' @param mot_de_passe Password for the ANDES database.
#' @param nom_bd Name of the ANDES database. Default is "andesdb".
#' @return A connection object to the ANDES database.
#' @export
andes_db_connect <- function(
                            url_bd,
                            port_bd,
                            nom_usager,
                            mot_de_passe,
                            nom_bd="andesdb") {
    andes_db_connection <- RMySQL::dbConnect(RMySQL::MySQL(),
                                    dbname=nom_bd,
                                    host=url_bd,
                                    port=port_bd,
                                    user=nom_usager,
                                    password=mot_de_passe)
    return(andes_db_connection)
}
