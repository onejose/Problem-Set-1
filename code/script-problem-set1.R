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
vector1_100 <- vector("numeric", length = 100) #creamos el vector del 1 al 100
vector1_100 <- 1:100 #se observa la longitud del vector creado
vector_impares <- seq(from = 1, to = 99, by = 2) #se crea vector que contiene numeros impares del 1 al 100
vector_pares <- vector1_100[vector1_100 %in% seq(2, 100, by = 2)] #se crea vector que contiene numeros pares del 1 al 100

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
nuevo_df <- full_join(Modulo_sitio_ubicacion, Modulo_de_identificacion, by = c("DIRECTORIO","SECUENCIA_P","SECUENCIA_ENCUESTA")) #Se usa las variables DIRECTORIO, SECUENCIA_P y SECUENCIA_ENCUESTA para unir una única base de datos con los objetos del punto anterior.

##PUNTO 6
summary(Modulo_de_identificacion$P241)  #se obtuvo las estadísticas descriptivas de la variable relacionada a la edad
Ocupados_Enero = subset(x = Modulo_de_identificacion,MES_REF =="ENERO" ) #se filtraron los datos para obtener la información de los ocupados del mes de Enero
Ocupados_Febrero = subset(x = Modulo_de_identificacion,MES_REF =="FEBRERO" ) #se filtraron los datos para obtener la información de los ocupados del mes de Febrero
summary(Ocupados_Enero$P241) #se obtuvo las estadísticas descriptivas para la información relacionada a la edad solamente para el mes de Enero
summary(Ocupados_Febrero$P241) #se obtuvo las estadísticas descriptivas para la información relacionada a la edad solamente para el mes de Febrero
#Con estas tablas, se comparó la información de los ocupados de Enero y Febrero. La media de la edad del propietario es levemente menor en los del mes de Enero que en Febrero, pues en Enero es aproximadamente 49 y en Febrero 50.

summary(Ocupados_Enero$P35) #se encontraron las estadísticas desctriptivas en una tabla sobre la información del seño para las personas del mes de Enero
summary(Ocupados_Febrero$P35) #se encontraron las estadísticas desctriptivas en una tabla sobre la información del seño para las personas del mes de Febrero
#Con base en la media presentada en las tablas, se puede concluir que en Enero hay más mujeres que en Febrero

ubicacioneid <- c(nuevo_df) #6.1
mean(nuevo_df$P3034) #de la muestra de estos datos, se evidencia que en promedio, los negociantes llevan 158 meses trabajando en su negocio.
mean(nuevo_df$p3032_1) #de la muestra de estos datos, en promedio, los negociantes no tienen trabajadores a los cuales les den un pago.
mean(nuevo_df$P3032_3) #en promedio, los negociantes no tienen trabajadores o familiares sin remuneracion en sus negocios.

ggplot(nuevo_df, aes(P35, P3034)) + geom_line(colour="red") + geom_point (size=1, shape=21, fill="white", colour="red")
ggsave ("output/grafico de dispersion.png")
ggplot(nuevo_df, aes(x=P35)) + geom_bar(colour="blue") #se creo un grafico de barras para entender la distribución del sexo de los datos, llegando a que hay más hombres (1) que mujeres (2)
ggsave ("output/grafico de barras.png")  #se guardó la gráfica en formato png output
ggplot(Modulo_de_identificacion, aes(x =COD_DEPTO)) + geom_bar(colour="green") #Se creo una gráfica de barras con respecto al código del departamento 
ggsave ("output/grafico de barras2.png")  #se guardó la gráfica en formato png output
ggplot(Modulo_de_identificacion, aes(x =P241)) + geom_bar(colour="black") #Se creó un gráfico de barras que muestra la cantidad de personas con las edades, mostrando la distribución
ggsave ("output/grafico de barras3.png") #se guardó la gráfica en formato png output

