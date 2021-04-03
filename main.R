library(twitteR)

apikey = "Wucix0bguEiw8QdRSAdU1y7vW"
apisec = "3Brwv1DTktA5FRzeEv0KuIhz1DNoEZwuVUatoCxpnZNBbeSO4S"
apitoken = "1307101446094102529-BTq4D8sM8PGd5oL95ghnCmDyHTZ2uN"
tsec = "YsoY66VgWUnV3Cxgjjm4x1eDuNoijxLwmoGQLY0mMDmY7"
setup_twitter_oauth(apikey, apisec, apitoken, tsec)

tw = searchTwitter('@ConacytYa', n = 25)
strip_retweets(tw)
d = twListToDF(tw)