library("xml2")
#library("xlsx")
library("rvest")
library("dplyr")
#library("httr")
library("stringr")

a = read.csv("C:/Users/qiuch/Desktop/input.csv",header = T, encoding="UTF-8")

setwd("C:/Users/qiuch/Desktop/file/pdf")


if(FALSE){
ISIN_all = c()
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

for(i in 1:790){
 

  url_id <- as.character(a[i,1]) 
  url <- paste("https://www.ifund.com.hk/en/fund/", url_id, sep="")
  web <- read_html(url)

  #title <- html_nodes(web,"._3U5DB") %>% html_text
  #check <- str_locate(title[1],'-')
  #if(!is.na(check[1])){next}

  if(FALSE){
  strtmp <- html_nodes(web,"._1NE4p") %>% html_text()
  ISIN = substr(strtmp, 1, 12)

  name_english <- html_nodes(web,"#root > div > div:nth-child(6) > div:nth-child(1) > div._2Zo7I > div > h1.K2hh5 ") %>% html_text
  name_chinese <- html_nodes(web,"#root > div > div:nth-child(6) > div:nth-child(1) > div._2Zo7I > div > h1._3-V-B") %>% html_text
  company_name <- html_nodes(web,"#root > div > div:nth-child(6) > div:nth-child(2) > div._2Zo7I > div._3lkcG._28MZZ > div > div > div:nth-child(1) > div:nth-child(2)") %>% html_text

  ID_ISIN<-data.frame(ISIN,name_english,name_chinese,company_name)
  ID_ISIN_ALL<-rbind(ID_ISIN_ALL,ID_ISIN)

  write.csv(ID_ISIN_ALL,file="C:/Users/qiuch/Desktop/file/ID_ISIN_ALL_2.csv",row.names = FALSE)
  }
  
  str <- as.character(html_nodes(web,".VO4Gf")[1])
  tmp1 <- substr(str,10,93)
  tmp2 <- as.character("&Type=FS&LanguageId=zh-HK")
  pdfadd <- paste(tmp1,tmp2,sep="")

  download.file(pdfadd, paste(url_id,".pdf",sep=""),mode="wb")
}
