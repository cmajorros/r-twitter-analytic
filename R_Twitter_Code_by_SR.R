install.packages(c("devtools", "rjson", "bit64", "httr"))

#RESTART R session!

library(devtools)

library(twitteR)

api_key <- "XBIZ2MzblojHzfqUkDLCAYnzq"

api_secret <- "1FBCBkSQYyWF09lNzQm7HyZ6hLFj5UBDB0bxN9S4Z6krIAhq1N"

access_token <- "https://api.twitter.com/oauth/authorize"

access_token_secret <- "https://api.twitter.com/oauth/access_token"

setup_twitter_oauth(api_key,api_secret)

#select Authencation Type
1
searchTwitter("Room39")
