library(tidyverse)
library(tidytext)
library(ggplot2)

setwd("~/GitHub/Data Class I/data-2-final-project")

# Code source: my submission for Question 1 of Homework 3

enroll <- read_file("enrollment.txt") # Source: https://chicago.chalkbeat.org/2022/9/28/23377565/chicago-school-enrollment-miami-dade-third-largest
enroll_df <- tibble(text = enroll)
word_tokens_enroll <- unnest_tokens(enroll_df, word_tokens, text, token = "words")
enroll_no_stop <- word_tokens_enroll %>% 
  anti_join(stop_words, by = c("word_tokens" = "word"))
enroll_no_stop_count <- count(enroll_no_stop, word_tokens, sort = T)

paste("The most common word is", enroll_no_stop_count[1,1])
paste("The median number of mentions of a word is", median(enroll_no_stop_count$n))
paste("The mean number of mentions of a word is", mean(enroll_no_stop_count$n))

enroll_short <- enroll_no_stop_count %>% head(20)
enroll_freq <- ggplot(data = enroll_short) +
  geom_col(aes(x = word_tokens, y = n), fill = "blue") +
  labs(
    title = "Word Frequency - Enrollment",
    x = "Words",
    y = "Frequency"
  )

police <- read_file("police.txt") # Source: https://chicago.chalkbeat.org/2022/8/16/23308391/chicago-public-schools-police-school-resource-officers-restorative-justice-whole-school-safety-plan
police_df <- tibble(text = police)
word_tokens_police <- unnest_tokens(police_df, word_tokens, text, token = "words")
police_no_stop <- word_tokens_police %>% 
  anti_join(stop_words, by = c("word_tokens" = "word"))
police_no_stop_count <- count(police_no_stop, word_tokens, sort = T)

paste("The most common word is", police_no_stop_count[1,1])
paste("The median number of mentions of a word is", median(police_no_stop_count$n))
paste("The mean number of mentions of a word is", mean(police_no_stop_count$n))

police_short <- police_no_stop_count %>% head(20)
police_freq <- ggplot(data = police_short) +
  geom_col(aes(x = word_tokens, y = n), fill = "blue") +
  labs(
    title = "Word Frequency - Policing",
    x = "Words",
    y = "Frequency"
  )

setwd("~/GitHub/Data Class I/data-2-final-project/images")

ggsave("enrollment_words.png", plot = enroll_freq, device = "png")
ggsave("policing_words.jpg", plot = police_freq, device = "png")