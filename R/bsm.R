
#' Gets fishing set activity
#'
#' This function executes a SQL query to retrieve fishing set data from the ANDES database.
#' The current ANDES active mission will determine for which mission the sets are returned.
#'
#' @param andes_db_connection a connection object to the ANDES database. Please
#' @return A dataframe containing fishing set data.
#' @export
get_fishing_sets_bsm<- function(andes_db_connection) {
    query <- readr::read_file(system.file("sql_queries",
                                          "fishing_sets_bsm",
                                          package = "ANDESCrabe"))
    result <- RMySQL::dbSendQuery(andes_db_connection, query)
    sets <- RMySQL::dbFetch(result, n = Inf)
    RMySQL::dbClearResult(result)
    # Format the dates in the sets dataframe
    # sets <- format_dates(sets, reference_column = "HEUR_DEB")
    return(sets)
}
