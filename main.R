require(twitteR)
require(caret)
require(stringr)
require(dplyr)
source('~/UNAM 2020-24/DATSCI/r/ConacytPred/ConacytPred/api.R')



conacyt <- api()


df <- twListToDF(conacyt)
df$text <- str_replace_all(df$text, "[^[:alnum:]]", "")

diafe <- as.Date(trunc(df$created, "day"))

datos_conacyt <- data.frame(fecha=diafe, dias_hoy = as.numeric(Sys.Date()-diafe),
                            depo = factor(tolower(df$text)))


levels(datos_conacyt$depo) <- c(0,1)

pagosConacyt <-  datos_conacyt[datos_conacyt$depo==1,]

dif <- c(datos_conacyt$dias_hoy[1])

ldif = length(pagosConacyt$depo)-1

for (i in 1:ldif) {
  dif <- append(dif,(pagosConacyt$dias_hoy[i+1]-pagosConacyt$dias_hoy[i]))
}


pagosConacyt <- pagosConacyt %>% mutate(difdias = dif)


