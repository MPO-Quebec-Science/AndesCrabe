require(RMySQL)

get_specimen_observations_BSM<- function(andes_db_connection, mission_id = 0) {
    query <- sprintf("
    SELECT
        specimen_id,
        shared_models_sample.sample_number as TRAIT,
        shared_models_sample.sample_number as NO_ECHAN,
        shared_models_sample.start_date as HEUR_DEB,
        shared_models_referencecatch.aphia_id,
        shared_models_referencecatch.scientific_name,
        shared_models_sizeclass.code as SEXE,
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
    WHERE shared_models_sample.mission_id=%d
    GROUP BY 
        specimen_id
    ", mission_id)
    result <-dbSendQuery(andes_db_connection, query)
    specimen_observations <- dbFetch(result, n=Inf)
    dbClearResult(result)
    # Format PATTES_MAN from missing legs
    specimen_observations <- format_legs(specimen_observations)

    # Format the dates in the sets dataframe
    specimen_observations <- format_dates(specimen_observations, reference_column = "HEUR_DEB")
    return(specimen_observations)
}

format_sex <- function(sex) {
    # convert 1 and 91 to 1
    # convert 2 and 92 to 2
    # NA for anything else
    # The reasoning is because ANDES sample class 91 and 92 reprents males and females taken from biodiversity sample
    if (sex %in% c(1, 91)) {
        return(1)
    } else if (sex %in% c(2, 92)) {
        return(2)
    } else {
        return (NA)

}

parse_missing_legs <- function( missing_legs_str) {
    # Convert the 'legs' column to numeric, replacing empty strings with NA
    num_missing_legs <- nchar(missing_legs_str)
    if((num_missing_legs %% 2) == 1) {
        stop("Found a weird missing leg result")
        return(NA)
    } else {
        return (num_missing_legs/2)
    }
}

format_legs <- function(df) {
    legs <- df[,which(names(df) == "missing_legs")]
    df["PATT_MAN"] <- unlist(lapply(df, parse_missing_legs))
    return (df)
}

rename_species <- function(str) {
    
}

format_name <-function(df)

specimens <- get_specimen_observations_BSM(andes_db_connection, mission_id = 67)
View(specimens)

