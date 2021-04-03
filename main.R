library(httr)

accessapi <- function(apikey, apisecret, apitoken, tsecret, url){
  app = oauth_app("twitter",
                  key = apikey, secret = apisecret)
  sig = sign_oauth1.0(app, 
                      token = apitoken, tokensecret = tsecret)
  hometl = GET(url, sig)
  
}
accessapi("Wucix0bguEiw8QdRSAdU1y7vW", "3Brwv1DTktA5FRzeEv0KuIhz1DNoEZwuVUatoCxpnZNBbeSO4S",
          "1307101446094102529-BTq4D8sM8PGd5oL95ghnCmDyHTZ2uN","YsoY66VgWUnV3Cxgjjm4x1eDuNoijxLwmoGQLY0mMDmY7",
          "https://api.twitter.com/2/users/ConacytYa/tweets")