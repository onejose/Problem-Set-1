#######Nombres: Juan Jose Gutierrez Pelaez 201923547, Laura Victoria Gonzalez 202011064, Gabriela Ramirez 202123417
#######Versión de R: "R version 4.2.1 (2022-06-23)"
R.Version()$version.string

#### **☑ Librerías**
install.packages("tidyverse") #se instala tidyverse
library(tidyverse) # se carga tidyverse
install.packages("rio") #se instala rio
library(rio) #se carga rio
install.packages("pacman") # se instala pacman
library(pacman) # se carga pacman
install.packages("haven") # se instala haven
library(haven)    # se carga haven
install.packages("ggplot2")  # se instala ggplot
library(ggplot2) # se carga ggplot
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

Modulo_de_identificacion = read_dta("input/Módulo de identificación.dta") #funcion read_dta usada para llamar como objeto la base de datos indicada
Modulo_sitio_ubicacion = read_dta("input/Módulo de sitio o ubicación.dta") #funcion read_dta usada para llamar como objeto la base de datos indicada

# 2.2
export(Modulo_sitio_ubicacion, file= "output/Modulo_ubicacion.rds") #funcion export de rio usada para exportar el objeto indicado como un archivo rds
export(Modulo_de_identificacion, file= "output/Modulo_identificacion.rds") #funcion export de rio usada para exportar el objeto indicado como un archivo rds

# PUNTO 3
Modulo_de_identificacion = mutate(Modulo_de_identificacion, bussiness_type = case_when(GRUPOS4 == "01"~"Agricultura",
                                                                                       GRUPOS4 == "02"~"Industria manufacturera",
                                                                                       GRUPOS4 == "03"~"Comercio",
                                                                                       GRUPOS4 == "04"~"Servicios")) #funcion mutate de dplyr usada para crear una nueva variable "bussiness_type" que tome los valores indicados basandose en la variable "GRUPOS4"

Modulo_sitio_ubicacion = mutate (Modulo_sitio_ubicacion, local =case_when(P3053==6~1,
                                                                          P3053==7~1))  #funcion mutate de dplyr usada para crear una nueva variable "local" que tome los valores indicados basandose en la variable "P3053"

# PUNTO 4

Modulo_de_identificacion = subset(x = Modulo_de_identificacion,bussiness_type == "Industria manufacturera" ) #funcion subset de R usada para editar el objeto Modulo_de_Identificacion para que solo contenga las observaciones en las cuales bussiness_type toma los valores de industria manufacturera
varsub=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA", "P3054", "P469", "COD_DEPTO", "F_EXP") # se crea un vector con los elementos siendo los nombres de las variables de interes
select(.data=Modulo_sitio_ubicacion, all_of(varsub)) #se seleccionan las variables del vector creado en la base de datos indicada 
varsid=c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA","P35","P241","P3032_1","P3032_2","P3032_3","P3033","P3034")  # se crea un vector con los elementos siendo los nombres de las variables de interes
select(.data=Modulo_de_identificacion, all_of(varsid)) #se seleccionan las variables del vector creado en la base de datos indicada

## PUNTO 5 
nuevo_df <- full_join(Modulo_sitio_ubicacion, Modulo_de_identificacion, by = c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA"))

##PUNTO 6
summary(Modulo_de_identificacion$P241)
Ocupados_Enero = subset(x = Modulo_de_identificacion,MES_REF =="ENERO" )
Ocupados_Febrero = subset(x = Modulo_de_identificacion,MES_REF =="FEBRERO" )
summary(Ocupados_Enero$P241)
summary(Ocupados_Febrero$P241)
#La media de la edad del propietario es levemente menor en los del mes de Enero que en Febrero, pues en Enero es aproximadamente 49 y en Febrero 50.

summary(Ocupados_Enero$P35)
summary(Ocupados_Febrero$P35)
#Con base en la media, se puede concluir que en Enero hay más mujeres que en Febrero

ubicacioneid <- c(nuevo_df)
mean(nuevo_df$P3034)
mean(nuevo_df$p3032_1)
mean(nuevo_df$P3032_3)

ggplot(nuevo_df, aes(P35, P3034)) + geom_line(colour="red") + geom_point (size=1, shape=21, fill="white", colour="red")
ggsave ("output/grafico de dispersion.png")
ggplot(nuevo_df, aes(x=P35)) + geom_bar(colour="blue")
ggsave ("output/grafico de barras.png")
ggplot(Modulo_de_identificacion, aes(x =COD_DEPTO)) + geom_bar(colour="green")
ggsave ("output/grafico de barras2.png")
ggplot(Modulo_de_identificacion, aes(x =P241)) + geom_bar(colour="black")
ggsave ("output/grafico de barras3.png")

