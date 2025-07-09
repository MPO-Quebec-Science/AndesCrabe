require(RMySQL)

get_sets <- function(andes_db_connection, mission_id = 0) {
  query <- sprintf('SELECT shared_models_sample.*, shared_models_station.name as station_name, shared_models_operation.is_fishing, shared_models_operation.is_ctd  FROM shared_models_sample 
LEFT JOIN shared_models_station
ON shared_models_station.id = shared_models_sample.station_id
LEFT JOIN shared_models_sample_operations
ON shared_models_sample_operations.sample_id = shared_models_sample.id
LEFT JOIN shared_models_operation
ON shared_models_operation.id = shared_models_sample_operations.operation_id
WHERE mission_id=%d', mission_id)
  result <- dbSendQuery(andes_db_connection, query)
  sets <- fetch(result, n = Inf)
  dbClearResult(result)
  return(sets)
}

get_fishing_sets_bsm<- function(andes_db_connection, mission_id = 0) {
    query <- sprintf("
    SELECT 
      shared_models_mission.mission_number as MISSION,
      shared_models_mission.area_of_operation as SECTEUR,
      shared_models_mission.vessel_name as NAVIRE,
      shared_models_sample.start_date as HEUR_DEB,
      shared_models_sample.start_latitude as LAT_DEB,
      shared_models_sample.start_longitude as LON_DEB,
      shared_models_sample.end_date as HEUR_FIN,
      shared_models_sample.end_latitude as LAT_FIN,
      shared_models_sample.end_longitude as LON_FIN,
      shared_models_sample.duration as DUREE,
      shared_models_sample.speed as VITESSE,
      shared_models_sample.is_valid as COMPLET,
      shared_models_sample.remarks as NOTES,
      shared_models_sample.sample_number as TRAIT,
      shared_models_sample.sample_number as NO_ECHAN,
      shared_models_station.name as STATION,
      MAX(CASE WHEN (shared_models_sampleobservationtype.special_type='gear_type') THEN shared_models_sampleobservationtypecategory.description_fra ELSE '' END) AS ENGIN
      FROM shared_models_sample 
    LEFT JOIN shared_models_mission
    ON shared_models_sample.mission_id = shared_models_mission.id
    LEFT JOIN shared_models_station
    ON shared_models_station.id = shared_models_sample.station_id
    LEFT JOIN shared_models_sample_operations
    ON shared_models_sample_operations.sample_id = shared_models_sample.id
    LEFT JOIN shared_models_operation
    ON shared_models_operation.id = shared_models_sample_operations.operation_id
    LEFT JOIN shared_models_sampleobservation
    ON shared_models_sampleobservation.sample_id=shared_models_sample.id
    LEFT JOIN shared_models_sampleobservationtype
    ON shared_models_sampleobservationtype.id=shared_models_sampleobservation.sample_observation_type_id
    LEFT JOIN shared_models_sampleobservationtypecategory
    ON shared_models_sampleobservationtype.id=shared_models_sampleobservationtypecategory.sample_observation_type_id and shared_models_sampleobservationtypecategory.code=shared_models_sampleobservation.value
    WHERE mission_id=%s
    AND is_fishing=1
    GROUP BY 
      shared_models_sample.id
    ", mission_id)
    result <- dbSendQuery(andes_db_connection, query)
    sets <- dbFetch(result, n=Inf)
    dbClearResult(result)
    # Format the dates in the sets dataframe
    sets <- format_dates(sets, reference_column = "HEUR_DEB")
    return(sets)
}

parse_andes_datetime <- function(andes_time_str) {
  # if (is.na(andes_time_str)==TRUE) {
  #   return(NA)
  # }
  parsed_time <- as.POSIXlt(andes_time_str, format = "%Y-%m-%d %H:%M:%S", tz = "UTC", optional=TRUE)
  # Convert ISO 8601 time to POSIXlt, ANDES DB time values are implicitly in UTC
  return(parsed_time)
}


format_dates <- function(df, reference_column = "HEUR_DEB") {
  # takes a dataframe with a date column and adds new columns for day, month, and year
  # this will inject JOUR, MOIS, and ANNEE columns into the dataframe
  datetimes <- parse_andes_datetime(df[,which(names(df) == reference_column)])

  df["JOUR"] <- datetimes$mday
  # Months are 0-indexed in POSIXlt, so we add 1 to get the correct month
  df["MOIS"] <- datetimes$mon + 1 
  # Years are counted from 1900 in POSIXlt, so we add 1900 to get the correct year
  df["ANNEE"] <- datetimes$year + 1900
  return(df)
}
