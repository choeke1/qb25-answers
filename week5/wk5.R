library(tidyverse)
library(broom)
#when you do read.csv it gives you it in the form of a tibble
tibble1 <- read.csv("~/qb25-answers/week5/aau1043_dnm.csv")
tibble2 <- read.csv("~/qb25-answers/week5/aau1043_parental_age.csv")


count_tibble <- tibble1 %>%
  filter(Phase_combined == "father" | Phase_combined == "mother") %>%
  #groupby, then summarize
  group_by(Proband_id)%>%
  summarize("Father" = sum(Phase_combined == "father"), "Mother" = sum(Phase_combined == "mother") )

              
mergedtibble <- left_join(count_tibble, tibble2, "Proband_id")


ggplot(mergedtibble, aes(x = Mother_age, y = Mother))  +
  geom_point(color = "darkred") +
  labs(
    title = "Maternal DNM count vs. Maternal Age",
    x = "Maternal Age",
    y = "Count of Maternal DNMs"
  ) +
  theme_classic()

ggplot(mergedtibble, aes(x = Father_age, y = Father)) +
  geom_point(color = "steelblue") +
  labs(
    title = "Paternal DNM count vs. Paternal Age",
    x = "Paternal Age",
    y = "Count of Paternal DNMs"
  ) +
  theme_classic()  

#Exercise 2.2
maternal <- lm(mergedtibble, formula = Mother ~ 1 + Mother_age)
summary(maternal)

#Exercise 2.3
paternal <- lm(mergedtibble, formula = Father ~  + Father_age)
summary(paternal)


#Exercise 2.4
new_obs <- tibble(Father_age = 50.5)
predict(paternal, newdata = new_obs)

#Exercise 2.5

ggplot() +
  geom_histogram(data = mergedtibble, aes(x = Mother), 
                   fill = "darkred",alpha = 0.5, bins = 100) +
  geom_histogram(data = mergedtibble, aes(x = Father),
                   fill = "steelblue", alpha = 0.5, bins = 100) +
  labs(
      title = "Distribution of Maternal vs. Paternal DNMs",
      x = "Number of de novo mutations (DNMs)",
      y = "Frequency"
  ) +
  theme_classic()

#Exercise 2.6
t_test_result <- t.test(mergedtibble$Mother, mergedtibble$Father, paired = TRUE)
t_test_result

diff_model <- lm(I(Father - Mother) ~ 1, data = mergedtibble)
summary(diff_model)





#Exercise 3

# Fetch data from the CSV download link at https://grant-watch.us/nsf-data.html
raw_nsf_terminations <- readr::read_csv("https://drive.usercontent.google.com/download?id=1TFoyowiiMFZm73iU4YORniydEeHhrsVz&export=download")

nsf_terminations <- raw_nsf_terminations |> 
  janitor::clean_names() |> 
  mutate(
    usaspending_obligated = stringi::stri_replace_first_fixed(usaspending_obligated, "$", "") |> 
      readr::parse_number(),
    grant_number = as.character(grant_id)
  )


ggplot(nsf_terminations, aes(x = grant_id, y = status)) +
  geom_point()

#exploratory figure number one showing the top 20 cities with the highest number of terminated grants
nsf_terminations %>%
  filter(status == "❌ Terminated") %>% #copy pasted the status column inputs to get the terminated with the emoji
  count(org_city, sort = TRUE) %>% #counted the number of times each city was mentioned (proxy for the number of terminated grants)
  slice_max(n, n = 20) %>% #creating the top 50 cities (had to look this command up)
  ggplot(aes(y = org_city, x = n)) +
  geom_col(fill = "steelblue") +
  
  #exploratory question/figure number two: Does remaining funds correlate to termination status?
terminated <- nsf_terminations %>%
  filter(status == "❌ Terminated")

active <- nsf_terminations %>%
  filter(status != "❌ Terminated")
ggplot(nsf_terminations %>%
         filter(!is.na(estimated_remaining)),
       aes(x = status, y = estimated_remaining)) +
  geom_boxplot(fill = "steelblue") +
  scale_y_continuous() +
  labs(
    title = "Remaining Funds by Termination Status",
    x = "Status",
    y = "Estimated Remaining ($)"
  ) +
  theme_minimal()

#Statistical Analysis
nsf_terminations_model <- nsf_terminations %>%
  filter(!is.na(estimated_remaining)) %>% 
  mutate(
    is_terminated = if_else(status == "❌ Terminated", 1, 0)
  )
model_remaining <- lm(estimated_remaining ~ is_terminated, data = nsf_terminations_model)
summary(model_remaining)
