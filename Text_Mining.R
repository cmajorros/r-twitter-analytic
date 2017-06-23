#RESTART R session!

library(SnowballC)
library(twitteR)
library(RColorBrewer)

api_key <- "xxxxxxxxxxxxxx"

api_secret <- "yyyyyyyyyyyyyyyyyyyyyyyy"

access_token <- "https://api.twitter.com/oauth/authorize"

access_token_secret <- "https://api.twitter.com/oauth/access_token"

setup_twitter_oauth(api_key,api_secret)

#select Authencation Type
1

#Search data from Twitter
library("twitteR")
SearchData = searchTwitter("starbuck", n=1000,lang = 'en')
SearchData

#ConvertData to Data frame
df <- do.call("rbind", lapply(SearchData, as.data.frame))
df <- tweets1.df[duplicated(df ) == FALSE,] #remove duplicate tweets

#write to csv file (or your RODBC code)
write.csv(df,file="twitterList.csv")
tweet <- read.csv("twitterList.csv", stringsAsFactors = FALSE)
str(tweet)


#Convert to Data frame
library(tm)
library(NLP)
V_twitt <- VectorSource(tweet[,2])
Corpus_Twitt <- VCorpus(V_twitt)

#clean data

Clean_twitt <- iconv(Corpus_Twitt, to = 'utf-8')  
Clean_twitt <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", Clean_twitt)

Clean_twitt <- tm_map(Corpus_Twitt, removePunctuation)
Clean_twitt <- tm_map(Clean_twitt, content_transformer(tolower))
Clean_twitt <- tm_map(Clean_twitt, removeNumbers)
Clean_twitt <- tm_map(Clean_twitt, removeWords,(c(stopwords("en"),"the", "and","just", "got", "you", "there","all","will", "would", "but","there","all", "could","starbuck", "starbucks","and","out", "but","only")))
Clean_twitt <- sub(c(stopwords("en"),"the", "and","just", "got", "you", "there","all","will", "would", "but","there","all", "could","starbuck", "starbucks","and","out", "but","only","that"),"")
#Stemming word
Stem_set <- c("starbuck", "starbuck's", "starbucks")
Clean_twitt <- stemCompletion(Stem_set,Clean_twitt, type = "first")
Clean_twitt <- tm_map(Corpus_Twitt, PlainTextDocument)
Clean_twitt <- tm_map(Clean_twitt, stripWhitespace)

# Convert Data to TermDocumentMatrix

Twitt_tdm <- DocumentTermMatrix(Clean_twitt)
dim(Twitt_tdm)

Twitt_m <- as.matrix(Twitt_tdm)
Twitt_m[1:15][15]

term_freq <- colSums(Twitt_m)
term_freq< sort(term_freq, decreasing = TRUE)
barplot(term_freq[1:10])

term_freq
#Making Wordcloud
Word_freq <- data.frame(term = names(term_freq), num = term_freq)
library(wordcloud)
wordcloud(Word_freq$term, Word_freq$num, max.words =100 , colors= "red")


#Making word network
library(qdap)
word_associate(Word_freq$term, match.string =  c("starbuck"),stopwords =  c(Top100Words,"coffee", "cacpucino","latte"),network.plot =  TRUE,nw.label.proportional = FALSE,  cloud.colors =  c("gray85","darkred") )
title(main = "Starbuck Word Association")


#Investigate the association of text
associations <- findAssocs(Twitt_tdm, "starbuck",0.2)
asso_df <- list_vect2df(associations)[,2:3]
asso_df

