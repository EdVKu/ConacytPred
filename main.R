require(twitteR)
require(caret)
require(stringr)

apikey = "8DYohFObEbFw1BC36iUhulKJk"
apisec = "EtnqNrsb4ZIFJ5WyfVu6STuteirjdELtL8H7XEJOadna2z7bJb"
apitoken = "1307101446094102529-QEPqfbL7fSFuiGwdwlvNzetBxY7Hdz"
tsec = "F6nygvrhoVwnkk6pzB9HBLS1xAXt5QLeMNmrQLIpHn7uR"
setup_twitter_oauth(apikey, apisec, apitoken, tsec)

conacyt <- userTimeline("ConacytYa", n = 150)


df <- twListToDF(conacyt)
df$text <- str_replace_all(df$text, "[^[:alnum:]]", "")

datos_conacyt <- data.frame(fecha=as.Date(trunc(df$created, "day")), texto = factor(tolower(df$text)))

levels(datos_conacyt$texto) <- c(0,1)

