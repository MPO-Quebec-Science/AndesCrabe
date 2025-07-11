# ANDES crabe

Ce dépot contient des wrappers en `R` de commandes `SQL` pour extraire des données de crabe des neiges (équipe IML de la région du Québec) fait avec ANDES.

# Installation
``` R
devtools::install_github("MPO-Quebec-Science/AndesCrabe")
```
# connections BD

Il faut faire une copie du fichier gabarit `exemple.Renviron` et le nomer `.Renviron` au même emplacement. Par la suite il faut remplir le nom d'usagé et le mot de passe pour pouvoir faire une connexion a la BD. Il est possible de falloir redémarré `R` apres avoir modifier `.Renviron` car la lecture est uniquement fait au démarage de `R`.

# Developpement
checkout the repo and use
``` R
devtools::load_all()
devtools::document()
```
to load the library in memory without installing it.