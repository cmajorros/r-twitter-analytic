#RESTART R session!


library(twitteR)

api_key <- "XBIZ2MzblojHzfqUkDLCAYnzq"

api_secret <- "1FBCBkSQYyWF09lNzQm7HyZ6hLFj5UBDB0bxN9S4Z6krIAhq1N"

access_token <- "https://api.twitter.com/oauth/authorize"

access_token_secret <- "https://api.twitter.com/oauth/access_token"

setup_twitter_oauth(api_key,api_secret)

#select Authencation Type
1

#Search data from Twitter
library("twitteR")
SearchData = searchTwitter("Bruno Mars", n=1000,lang = 'en')
SearchData

#Scrapping Data 
userTimeline("BrunoMars", n=100, maxID =NULL, excludeReplies = FALSE, includeRts = FALSE)

class(SearchData)
head(SearchData)

#Cleanning Data
library(NLP)
library(tm)



TweetList <- sapply(SearchData, function(x) x$getText()) 

TweetList <- (TweetList[!is.na(TweetList)])
TweetCorpus <- Corpus(VectorSource(TweetList))
TweetCorpus <-  iconv(TweetCorpus, to ="utf-8")

#change data to lower case

TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
TweetCorpus <- tm_map(TweetCorpus, removeNumbers)
TweetCorpus <- tm_map(TweetCorpus, tolower)



#Remove Stopword
TweetCorpus <- tm_map(TweetCorpus, function(x)removeWords(x,stopwords()))


#Transform text to Wordcloud Format
TweetCorpus <- tm_map(TweetCorpus,PlainTextDocument)


#Wordcloud
# you need to have wordcloud package first
library("wordcloud")
wordcloud(TweetCorpus, min.freq = 5,
          scale = c(5,1),random.color = F,
          max.words = 45, random.order = F )

#Changing to tdm
TweetTDM <- TermDocumentMatrix(TweetCorpus)
TweetTDM

