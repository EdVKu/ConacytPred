require(twitteR)
require(caret)
require(stringr)
require(dplyr)
source('~/UNAM 2020-24/DATSCI/r/ConacytPred/API/api.R')


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

y = pagosConacyt$difdias[-1]
x = seq(ldif,1,-1)
md = mean(y)
sdd = sd(y)
lmod <- lm(y~x)

proxpago <- as.numeric(lmod$coefficients[1] + (lmod$coefficients[2]*(ldif+2))-pagosConacyt$difdias[1])

intcon <- md + c(1,-1)*qt(0.975,ldif)*sdd/sqrt(ldif)

print(paste(("The next payment will be on/El proximo pago sera el:"), 
            as.character(Sys.Date() + proxpago),
            ("the minimum and maximum dates, given a 95% confidence interval will be/las fechas minima y máxima dado un intervalo del 95% de confianza son:"),
            as.character(Sys.Date() + intcon[2]),"y" , as.character(Sys.Date() + intcon[1]), sep = " "))
