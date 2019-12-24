library("xml2")
#library("xlsx")
library("rvest")
library("dplyr")
#library("httr")
library("stringr")

#a = read.csv("C:/Users/qiuch/Desktop/1220.csv",header = T,encoding="UTF-8")

#dir.create("C:/Users/qiuch/Desktop/file")
setwd("C:/Users/qiuch/Desktop/file")

if(FALSE){
ID_ISIN_ALL<-data.frame()
web<-read_html("https://www.ifund.com.hk/zh-cn/companies")
pic<-html_nodes(web,"._1hV9w")
print("aha")
print(web)
print("aha2")
pic<-html_nodes(web,"._1hV9w")
print(pic)
print("aha3")
}

for(i in 970000:970060){
 

  url_id <- as.character(i) 
  url <- paste("https://www.ifund.com.hk/zh-cn/fund/", url_id, sep="")
  web <- read_html(url)
  title <- html_nodes(web,"._3U5DB") %>% html_text
  check <- str_locate(title[1],'-')
  if(!is.na(check[1])){next}

  #string <- html_nodes(web,"._1NE4p") %>% html_text
  #ISIN = substr(string, 1, 12)

  #ID_ISIN <- data.frame(i,ISIN)
  #ID_ISIN_ALL <- rbind(ID_ISIN_ALL,ID_ISIN)

  #write.csv(ID_ISIN_ALL,file="C:/Users/qiuch/Desktop/12_20/ID_ISIN_ALL.csv")
  
  str <- as.character(html_nodes(web,".VO4Gf")[1])
  tmp1 <- substr(str,10,93)
  tmp2 <- as.character("&Type=FS&LanguageId=zh-HK")
  pdfadd <- paste(tmp1,tmp2,sep="")

  download.file(pdfadd, paste(i,".pdf",sep=""),mode="wb")
}
