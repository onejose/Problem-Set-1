#######Nombres: Juan Jose Gutierrez Pelaez 201923547, Laura Victoria Gonzalez 202011064, Gabriela Ramirez
#######Versión de R: "R version 4.2.1 (2022-06-23)"
R.Version()$version.string

## clean environment
rm(list=ls())
#### **☑ Librerías**

## instalar/llamar pacman
install.packages("pacman")
require(pacman)

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

## 2. Importar / exportar bases de datos
setwd("/Users/lauragonzalez/Desktop/UNIANDES VICKY/QUINTO SEMESTRE/PROGRAMA R/PROBLEM-SET1/problem-sets-main/problem-set-1")
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
Modulo_de_identificacion = mutate(Modulo_de_identificacion, bussiness_type = case_when(GRUPOS4 == 01~"Agricultura",
                                                                                       GRUPOS4 == 02~"Industria manufacturera",
                                                                                       GRUPOS4 == 03~"Comercio",
                                                                                       GRUPOS4 == 04~"Servicios"))

Modulo_sitio_ubicacion = mutate (Modulo_sitio_ubicacion, local =ifelse(P3053==6, yes=1, no=0))

# PUNTO 4


varsub=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA", "P3054", "P469", "COD_DEPTO", "F_EXP")
select(.data=Modulo_sitio_ubicacion, all_of(varsub))
varsid=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3","P3033","P3034")
select(.data=Modulo_de_identificacion, all_of(varsid))


## PUNTO 5 
