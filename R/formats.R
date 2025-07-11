

#' Takes an ANDES database datetime string and converts it to a POSIXlt object
#'
#' @param andes_time_str A string representing a UTC date and time in the format "YYYY-MM-DD HH:MM:SS".
#' @return A POSIXlt object representing the date and time in UTC.
#' @export
parse_andes_datetime <- function(andes_time_str) {
  # if (is.na(andes_time_str)==TRUE) {
  #   return(NA)
  # }
  parsed_time <- as.POSIXlt(andes_time_str, format = "%Y-%m-%d %H:%M:%S", tz = "UTC", optional=TRUE)
  # Convert ISO 8601 time to POSIXlt, ANDES DB time values are implicitly in UTC
  return(parsed_time)
}

#' Takes an dataframe with a column containing ANDES database datetime strings and adds new columns for day, month, and year
#'
#' @param df A dataframe containing a datetime string representing.
#' @param reference_column The name of the column that contains the ANDES UTC datetime string in "YYYY-MM-DD HH:MM:SS".
#' @return A dataframe identical to the input dataframe with additional columns for day (JOUR), month (MOIS), and year (ANNEE).
#' @export
format_dates <- function(df, reference_column = "HEUR_DEB") {
  # takes a dataframe with a date column and adds new columns for day, month, and year
  # this will inject JOUR, MOIS, and ANNEE columns into the dataframe
  datetimes <- parse_andes_datetime(df[, which(names(df) == reference_column)])

  df["JOUR"] <- datetimes$mday
  # Months are 0-indexed in POSIXlt, so we add 1 to get the correct month
  df["MOIS"] <- datetimes$mon + 1
  # Years are counted from 1900 in POSIXlt, so we add 1900 to get the correct year
  df["ANNEE"] <- datetimes$year + 1900
  return(df)
}
