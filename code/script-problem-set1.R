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

# PUNTO 3
Modulo_de_identificacion = mutate(Modulo_de_identificacion, bussiness_type = case_when(GRUPOS4 == "01"~"Agricultura",
                                                                                       GRUPOS4 == "02"~"Industria manufacturera",
                                                                                       GRUPOS4 == "03"~"Comercio",
                                                                                       GRUPOS4 == "04"~"Servicios"))
Modulo_sitio_ubicacion = mutate (Modulo_sitio_ubicacion, local =ifelse(P3053==6, yes=1, no=0))

# PUNTO 4

varsub=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA", "P3054", "P469", "COD_DEPTO", "F_EXP")
select(.data=Modulo_sitio_ubicacion, all_of(varsub))
varsid=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3","P3033","P3034")
select(.data=Modulo_de_identificacion, all_of(varsid))