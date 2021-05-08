require(twitteR)
require(caret)
require(stringr)
require(dplyr)

api <- function(id = "ConacytYa", n = 150){
  apikey = "8DYohFObEbFw1BC36iUhulKJk"
  apisec = "EtnqNrsb4ZIFJ5WyfVu6STuteirjdELtL8H7XEJOadna2z7bJb"
  apitoken = "1307101446094102529-QEPqfbL7fSFuiGwdwlvNzetBxY7Hdz"
  tsec = "F6nygvrhoVwnkk6pzB9HBLS1xAXt5QLeMNmrQLIpHn7uR"
  setup_twitter_oauth(apikey, apisec, apitoken, tsec)
  
  conacyt <- userTimeline(id, n)
  return(conacyt)
}

