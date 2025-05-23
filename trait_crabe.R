
get_sets <- function(andes_db_connection, mission_id = 0) {
  query <- sprintf('SELECT shared_models_sample.*, shared_models_station.name as station_name, shared_models_operation.is_fishing, shared_models_operation.is_ctd  FROM shared_models_sample 
LEFT JOIN shared_models_station
ON shared_models_station.id = shared_models_sample.station_id
LEFT JOIN shared_models_sample_operations
ON shared_models_sample_operations.sample_id = shared_models_sample.id
LEFT JOIN shared_models_operation
ON shared_models_operation.id = shared_models_sample_operations.operation_id
WHERE mission_id=%d', mission_id)
  result <-dbSendQuery(andes_db_connection, query)
  sets <- fetch(result)
  dbClearResult(result)
  return(sets)
}

get_fishing_sets<- function(andes_db_connection, mission_id = 0) {
    query <- sprintf("
    SELECT shared_models_sample.*, shared_models_station.name as station_name, shared_models_operation.is_fishing, shared_models_operation.is_ctd  FROM shared_models_sample 
    LEFT JOIN shared_models_station
    ON shared_models_station.id = shared_models_sample.station_id
    LEFT JOIN shared_models_sample_operations
    ON shared_models_sample_operations.sample_id = shared_models_sample.id
    LEFT JOIN shared_models_operation
    ON shared_models_operation.id = shared_models_sample_operations.operation_id
    WHERE mission_id=%d
    AND is_fishing=1", mission_id)
    result <-dbSendQuery(andes_db_connection, query)
    sets <- dbFetch(result, n=Inf)
    dbClearResult(result)
    return(sets)
}



