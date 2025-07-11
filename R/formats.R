

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

get_sex_from_sample_class <- function(sample_class) {
    # convert 1 and 91 to 1
    # convert 2 and 92 to 2
    # NA for anything else
    # The reasoning is because ANDES sample class 91 and 92 reprents males and females taken from biodiversity sample

    if (sample_class %in% c(1, 91)) {
        return(1)
    } else if (sample_class %in% c(2, 92)) {
        return(2)
    } else {
        return(NA)
    }
}



format_sex <- function(df) {
    sample_class <- df[, which(names(df) == "sample_class")]
    df["SEXE"] <- unlist(lapply(sample_class, get_sex_from_sample_class))
    return(df)
}

parse_missing_legs <- function( missing_legs_str) {
    # Convert the 'legs' column to numeric, replacing empty strings with NA
    num_missing_legs <- nchar(missing_legs_str)
    if ((num_missing_legs %% 2) == 1) {
        stop("Found a weird missing leg result")
        return(NA)
    } else {
        return(num_missing_legs / 2)
    }
}

format_legs <- function(df) {
    legs <- df[, which(names(df) == "missing_legs")]
    df["PATT_MAN"] <- unlist(lapply(legs, parse_missing_legs))
    return(df)
}

rename_species <- function(strap_code) {
    strap_code <- toString(strap_code)
    code_name_map <- c(
        "8196" = "LM", # crabe épineux Lithodes maja
        "8206" = "CC", # crabe commun Cancer irroratus
        "8213" = "CO", # crabe des neiges Chionoecetes opilio
        "8217" = "HC", # crabe lyre Hyas alutaceus (anciennement coartatus)
        "8219" = "HA"  # crabe araignée Hyas araneus
    )
    return(code_name_map[strap_code])
}

format_names <- function(df) {
    codes <- df[, which(names(df) == "STRAP_CODE")]
    df["Espece"] <- unlist(lapply(codes, rename_species))
    return(df)
}
