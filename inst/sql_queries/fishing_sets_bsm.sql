SELECT
    specimen_id,
    shared_models_sample.sample_number as TRAIT,
    shared_models_sample.sample_number as NO_ECHAN,
    shared_models_sample.start_date as HEUR_DEB,
    shared_models_referencecatch.code as STRAP_CODE,
    shared_models_referencecatch.scientific_name,
    shared_models_sizeclass.code as sample_class,
    MAX(CASE WHEN (shared_models_observationtype.export_name='LARG_CAR') THEN observation_value ELSE '' END) AS LARG_CAR,
    MAX(CASE WHEN (shared_models_observationtype.export_name='HAUT_PIN') THEN observation_value ELSE '' END) AS HAUT_PIN,
    MAX(CASE WHEN (shared_models_observationtype.export_name='DUROMETR') THEN observation_value ELSE '' END) AS DUROMETR,
    MAX(CASE WHEN (shared_models_observationtype.export_name='code_etat_carapace_1_3') THEN observation_value ELSE '' END) AS code_etat_carapace_1_3,   
    MAX(CASE WHEN (shared_models_observationtype.export_name='carapace_state_1_4') THEN observation_value ELSE '' END) AS carapace_state_1_4,
    MAX(CASE WHEN (shared_models_observationtype.export_name='code_etat_carapace_1_5') THEN observation_value ELSE '' END) AS code_etat_carapace_1_5,
    MAX(CASE WHEN (shared_models_observationtype.export_name='STAT_FEM') THEN observation_value ELSE '' END) AS STAT_FEM,
    MAX(CASE WHEN (shared_models_observationtype.export_name='DEV_OEUF') THEN observation_value ELSE '' END) AS DEV_OEUF, 
    MAX(CASE WHEN (shared_models_observationtype.export_name='LARG_ABD') THEN observation_value ELSE '' END) AS LARG_ABD,   
    MAX(CASE WHEN (shared_models_observationtype.export_name='DEV_OEUF') THEN observation_value ELSE '' END) AS DEV_OEUF,  
    MAX(CASE WHEN (shared_models_observationtype.export_name='missing_legs') THEN observation_value ELSE '' END) AS missing_legs
FROM shared_models_observation
LEFT JOIN shared_models_observationtype ON shared_models_observationtype.id=shared_models_observation.observation_type_id
LEFT JOIN shared_models_specimen ON shared_models_specimen.id = shared_models_observation.specimen_id
LEFT JOIN shared_models_basket ON shared_models_basket.id = shared_models_specimen.basket_id
LEFT JOIN shared_models_sizeclass ON shared_models_sizeclass.id = shared_models_basket.size_class_object_id
LEFT JOIN shared_models_catch ON shared_models_catch.id = shared_models_basket.catch_id
LEFT JOIN shared_models_referencecatch ON shared_models_referencecatch.id = shared_models_catch.reference_catch_id
LEFT JOIN shared_models_sample ON shared_models_sample.id = shared_models_catch.sample_id
LEFT JOIN shared_models_mission ON shared_models_mission.id = shared_models_sample.mission_id
WHERE shared_models_mission.is_active = TRUE
GROUP BY 
    specimen_id
