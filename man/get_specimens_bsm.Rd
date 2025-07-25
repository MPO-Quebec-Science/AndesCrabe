% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bsm.R
\name{get_specimens_bsm}
\alias{get_specimens_bsm}
\title{Gets specimen data}
\usage{
get_specimens_bsm(andes_db_connection)
}
\arguments{
\item{andes_db_connection}{a connection object to the ANDES database.}
}
\value{
A dataframe containing fishing set data.
}
\description{
This function executes a SQL query to retrieve specimen data from the ANDES database.
The current ANDES active mission will determine for which mission the specimens are returned.
}
\seealso{
[get_specimen_bsm_db()] for the raw database results
}
