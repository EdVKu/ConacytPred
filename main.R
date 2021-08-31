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

y0 = pagosConacyt$difdias[-1]
y = y0[-9]
x0 = seq(ldif,1,-1)
x = x0[-9]
md = mean(y[-1])
sdd = sd(y)
lmod <- lm(y~x)

proxpago <- as.numeric(lmod$coefficients[1] + (lmod$coefficients[2]*(ldif+2))-pagosConacyt$difdias[1])

intcon <- proxpago + c(-1,1)*qt(0.975,ldif)*sdd/sqrt(ldif)

fechapago = Sys.Date() + proxpago
limspago = Sys.Date() + intcon

msjpago = paste(("The next payment will be (approximately) on/El proximo pago sera (aproximadamente) el:"), 
                as.character(Sys.Date() + proxpago),
                ("the minimum and maximum dates, given a 95% confidence interval will be/las fechas minima y maxima dado un intervalo del 95% de confianza son:"),
                as.character(limspago[1]),"y" , as.character(limspago[2]), sep = " ")



predpagos <- function(pp, lp){
  
  return(paste(("The next payment will be on/El proximo pago sera el:"), 
               as.character(Sys.Date() + pp),
               ("the minimum and maximum dates, given a 95% confidence interval will be/las fechas minima y maxima dado un intervalo del 95% de confianza son:"),
               as.character(limspago[1]),"y" , as.character(lp[2]), sep = " "))
  
}

print(predpagos(proxpago, limspago))


