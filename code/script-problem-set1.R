#######Nombres: Juan Jose Gutierrez Pelaez 201923547, Laura Victoria Gonzalez 202011064, Gabriela Ramirez 202123417
#######Versión de R: "R version 4.2.1 (2022-06-23)"
R.Version()$version.string
setwd("/Users/lauragonzalez/Desktop/UNIANDES VICKY/QUINTO SEMESTRE/PROGRAMA R/PROBLEM-SET1/problem-sets-main/problem-set-1")
setwd("C:/Users/juanj/OneDrive - Universidad de los Andes/Andes/#4 - Semester/Taller R/Problem Set 1")

#### **☑ Librerías**
install.packages("tidyverse") 
library(tidyverse)
install.packages("rio")
library(rio)
install.packages("pacman")
library(pacman)
install.packages("haven")
library(haven)
install.packages("ggplog2")
library(ggplog2)
## usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(dplyr,
       rio,
       skimr,
       janitor,
       tidyr,
       tibble,
       data.table)

## 1. Vectores
vector1_100 <- vector("numeric", length = 100)
vector1_100 <- 1:100
vector_impares <- seq(from = 1, to = 99, by = 2)
vector_pares <- vector1_100[vector1_100 %in% seq(2, 100, by = 2)]

## PUNTO 2. Importar / exportar bases de datos
# 2.1

Modulo_de_identificacion = read_dta("input/Módulo de identificación.dta")
Modulo_sitio_ubicacion = read_dta("input/Módulo de sitio o ubicación.dta")

# 2.2
#C:/Usersjuanj/OneDrive - Universidad de los Andes/Andes/#4 - Semester/Taller R/Problem Set 1/output/
export(Modulo_sitio_ubicacion, file= "output/Modulo_ubicacion.rds")
export(Modulo_de_identificacion, file= "output/Modulo_identificacion.rds")

# PUNTO 3
Modulo_de_identificacion = mutate(Modulo_de_identificacion, bussiness_type = case_when(GRUPOS4 == "01"~"Agricultura",
                                                                                       GRUPOS4 == "02"~"Industria manufacturera",
                                                                                       GRUPOS4 == "03"~"Comercio",
                                                                                       GRUPOS4 == "04"~"Servicios"))

Modulo_sitio_ubicacion = mutate (Modulo_sitio_ubicacion, local =case_when(P3053==6~1,
                                                                          P3053==7~1))

# PUNTO 4

Modulo_de_identificacion = subset(x = Modulo_de_identificacion,bussiness_type == "Industria manufacturera" )
varsub=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA", "P3054", "P469", "COD_DEPTO", "F_EXP")
select(.data=Modulo_sitio_ubicacion, all_of(varsub))
varsid=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3","P3033","P3034")
select(.data=Modulo_de_identificacion, all_of(varsid))

## PUNTO 5 

varsub=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA", "P3054", "P469", "COD_DEPTO", "F_EXP")
select(.data=Modulo_sitio_ubicacion, all_of(varsub))
varsid=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3","P3033","P3034")
select(.data=Modulo_de_identificacion, all_of(varsid))

