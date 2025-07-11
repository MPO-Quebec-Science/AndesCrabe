
#' Gets fishing set activity
#'
#' This function executes a SQL query to retrieve fishing set data from the ANDES database.
#' The current ANDES active mission will determine for which mission the sets are returned.
#'
#' @param andes_db_connection a connection object to the ANDES database. Please
#' @return A dataframe containing fishing set data.
#' @seealso [get_fishing_sets_bsm_db()] for the raw database results
#' @export
get_fishing_sets_bsm<- function(andes_db_connection) {

    # first, get the raw database results
    sets <- get_fishing_sets_bsm_db(andes_db_connection)
    # Format the dates in the sets dataframe
    sets <- format_dates(sets, reference_column = "HEUR_DEB")

    return(sets)
}

#' Gets fishing set activity (raw database results)
#'
#' This function executes a SQL query to retrieve fishing set data from the ANDES database.
#' The current ANDES active mission will determine for which mission the sets are returned.
#'
#' This function is intended for internal use and returns raw results from the database.
#' It is not meant for direct use in analysis or reporting. Users should use `get_fishing_sets_bsm` 
#'
#' @param andes_db_connection a connection object to the ANDES database. Please
#' @return A dataframe containing fishing set data.
#' @seealso [get_fishing_sets_bsm()] for the formatted results
#' @export
get_fishing_sets_bsm_db<- function(andes_db_connection) {
    query <- readr::read_file(system.file("sql_queries",
                                          "fishing_sets_bsm.sql",
                                          package = "ANDESCrabe"))
    # query <- "select * from shared_models_sample"
    result <- RMySQL::dbSendQuery(andes_db_connection, query)
    sets <- RMySQL::dbFetch(result, n = Inf)
    RMySQL::dbClearResult(result)
    # Format the dates in the sets dataframe
    sets <- format_dates(sets, reference_column = "HEUR_DEB")
    return(sets)
}
