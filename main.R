require(twitteR)
require(caret)
require(stringr)
require(dplyr)

apikey = "8DYohFObEbFw1BC36iUhulKJk"
apisec = "EtnqNrsb4ZIFJ5WyfVu6STuteirjdELtL8H7XEJOadna2z7bJb"
apitoken = "1307101446094102529-QEPqfbL7fSFuiGwdwlvNzetBxY7Hdz"
tsec = "F6nygvrhoVwnkk6pzB9HBLS1xAXt5QLeMNmrQLIpHn7uR"
setup_twitter_oauth(apikey, apisec, apitoken, tsec)

conacyt <- userTimeline("ConacytYa", n = 150)


df <- twListToDF(conacyt)
df$text <- str_replace_all(df$text, "[^[:alnum:]]", "")

diafe <- as.Date(trunc(df$created, "day"))

datos_conacyt <- data.frame(fecha=diafe, dias_hoy = as.numeric(Sys.Date()-diafe),
                            depo = factor(tolower(df$text)))


levels(datos_conacyt$depo) <- c(0,1)

pagosConacyt <-  datos_conacyt[datos_conacyt$depo==1,]

dif <- c(datos_conacyt$dias_hoy[1])

for (i in 1:length(pagosConacyt$depo)-1) {
  dif <- append(dif,(pagosConacyt$dias_hoy[i+1]-pagosConacyt$dias_hoy[i]))
}


pagosConacyt <- pagosConacyt %>% mutate(difdias = dif)


