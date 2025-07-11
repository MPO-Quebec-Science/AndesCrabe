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
-- Filters
    -- Just data for the active mission
    WHERE shared_models_mission.is_active = TRUE
    -- Just sets with fishing operation
    AND is_fishing=1
GROUP BY 
  shared_models_sample.id
