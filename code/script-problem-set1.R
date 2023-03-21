#######Nombres: Juan Jose Gutierrez Pelaez 201923547, Laura Victoria Gonzalez 202011064, Gabriela Ramirez 202123417
#######Versión de R: "R version 4.2.1 (2022-06-23)"
R.Version()$version.string

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
vector1_100 <- vector("numeric", length = 100) #creamos el vector del 1 al 100
vector1_100 <- 1:100 #se observa la longitud del vector creado
vector_impares <- seq(from = 1, to = 99, by = 2) #se crea vector que contiene numeros impares del 1 al 100
vector_pares <- vector1_100[vector1_100 %in% seq(2, 100, by = 2)] #se crea vector que contiene numeros pares del 1 al 100

## PUNTO 2. Importar / exportar bases de datos
# 2.1

Modulo_de_identificacion = read_dta("input/Módulo de identificación.dta")
Modulo_sitio_ubicacion = read_dta("input/Módulo de sitio o ubicación.dta")

# 2.2
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
nuevo_df <- full_join(Modulo_sitio_ubicacion, Modulo_de_identificacion, by = c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA")) #Se usa las variables DIRECTORIO, SECUENCIA_P y SECUENCIA_ENCUESTA para unir una única base de datos con los objetos del punto anterior.

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

ubicacioneid <- c(nuevo_df) #6.1
mean(nuevo_df$P3034) #de la muestra de estos datos, se evidencia que en promedio, los negociantes llevan 158 meses trabajando en su negocio.
mean(nuevo_df$p3032_1) #de la muestra de estos datos, en promedio, los negociantes no tienen trabajadores a los cuales les den un pago.
mean(nuevo_df$P3032_3) #en promedio, los negociantes no tienen trabajadores o familiares sin remuneracion en sus negocios.

ggplot(nuevo_df, aes(P35, P3034)) + geom_line(colour="red") + geom_point (size=1, shape=21, fill="white", colour="red") #se realiza un grafico de dispersion que refleja el comportamiento de dichas variables.
ggsave ("output/grafico de dispersion.png")
ggplot(nuevo_df, aes(x=P35)) + geom_bar(colour="blue")
ggsave ("output/grafico de barras.png")
ggplot(Modulo_de_identificacion, aes(x =COD_DEPTO)) + geom_bar(colour="green")
ggsave ("output/grafico de barras2.png")
ggplot(Modulo_de_identificacion, aes(x =P241)) + geom_bar(colour="black")
ggsave ("output/grafico de barras3.png")

