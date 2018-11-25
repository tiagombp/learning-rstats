# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr)

# Look at the gapminder dataset
gapminder

# Filter
gapminder %>%
  filter(year == 2007)

# Filter the gapminder dataset for the year 1957
gapminder %>%
  filter(year == 1957)

# Filter for China in 2002
gapminder %>%
  filter(year==2002,country=="China")

# Arrange
gapminder %>%
  arrange(desc(gdpPercap))

# Combining
gapminder %>%
  arrange(desc(gdpPercap)) %>%
  filter(year == 2007)

# Sort in ascending order of lifeExp
gapminder %>%
  arrange(lifeExp)

# Sort in descending order of lifeExp
gapminder %>%
  arrange(desc(lifeExp))

# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
  filter(year == 1957) %>%
  arrange(desc(pop))

# Use mutate to change lifeExp to be in months
gapminder %>%
  mutate(lifeExp = lifeExp*12)

# or

# Use mutate to create a new column called lifeExpMonths
gapminder %>%
  mutate(lifeExpMonths = lifeExp*12)

# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year == 2007) %>%
  mutate(lifeExpMonths = lifeExp*12) %>%
  arrange(desc(lifeExpMonths))

# Chapter 2

# subseting

gapminder_2007 <- gapminder %>%
  filter(year == 2007)

gapminder_2007

# load ggplot2

library(ggplot2)

ggplot(gapminder_2007, aes(x = gdpPerCap, y = lifeExp)) +
  geom_point()

# Load the ggplot2 package as well
library(gapminder)
library(dplyr)
library(ggplot2)

# Create gapminder_1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()

# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x=pop, y=lifeExp)) +
  geom_point()

# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() # <---- here

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

# the color aesthetic

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

# the size aesthetic

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10()

# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x=pop, y=lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size=gdpPercap)) +
  geom_point() +
  scale_x_log10()

# Faceting
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size=gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~continent)

# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent, size=pop))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)

## capitulo 3

# ...

# last segment, last exercise

library(gapminder)
library(dplyr)
library(ggplot2)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year==2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            medianGdpPercap = median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x=medianGdpPercap,y=medianLifeExp, color = continent))+
  geom_point()

## chapter 4

library(gapminder)
library(dplyr)
library(ggplot2)

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>% 
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x=year,y=medianGdpPercap)) +
  geom_line()+
  expand_limits(y=0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>% 
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x=year, y=medianGdpPercap, color=continent))+
  geom_line()+
  expand_limits(y=0)

library(gapminder)
library(dplyr)
library(ggplot2)

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x=continent,y=medianGdpPercap))+
  geom_col()

# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>%
  filter(continent=="Oceania", year ==1952)

# Create a bar plot of gdpPerCap by country
ggplot(oceania_1952, aes(x=country, y=gdpPercap))+
  geom_col()

# histograms
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x=pop))+
  geom_histogram()

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x=pop))+
  geom_histogram()+
  scale_x_log10() ## easier to tell the median!

## boxplots

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x=continent,y=gdpPercap)) +
  geom_boxplot()+
  scale_y_log10()

## adding other stuff

library(gapminder)
library(dplyr)
library(ggplot2)

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(title="Comparing GDP per capita across continents")

ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("Comparing GDP per capita across continents")
