library(ggplot2)

# FIXME HD 2026-08
# A very brief and simple script based on Data Carpentries
# It contains inappropriate code duplication, hardcoded paths,
# and relies on a single data file.
# I have in mind adapting it to clean it up and deal with data split by
# continent


fpath <- "~/Desktop/gapminder_data.csv"

gapminder <- read.csv(fpath)

summary(gapminder)

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, group=country, color=continent)) +
  geom_line()

americas <- gapminder[gapminder$continent == "Americas",]
ggplot(data = americas, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

africa <- gapminder[gapminder$continent == "Africa",]
ggplot(data = africa, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
