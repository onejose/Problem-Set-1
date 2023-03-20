## Juan Jose Gutierrez Pelaez 201923547, Laura Victoria Gonzalez, Gabriela Ramirez
## R version 4.2.2 (2022-10-31 ucrt)
setwd("C:/Users/juanj/OneDrive - Universidad de los Andes/Andes/#4 - Semester/Taller R/Problem Set 1")

install.packages("tidyverse") 
library(tidyverse)
#install.packages("devtools")
#devtools::install_github("r-lib/conflicted")
install.packages("rio")
library("rio")
install.packages("pacman")
library("pacman")

# PUNTO 2.1
library(haven)
Modulo_de_identificacion = read_dta("input/Módulo de identificación.dta")
Modulo_sitio_ubicacion = read_dta("input/Módulo de sitio o ubicación.dta")

# PUNTO 2.2
#C:/Usersjuanj/OneDrive - Universidad de los Andes/Andes/#4 - Semester/Taller R/Problem Set 1/output/
export(Modulo_sitio_ubicacion, file= "output/Modulo_ubicacion.rds")
export(Modulo_de_identificacion, file= "output/Modulo_identificacion.rds")

