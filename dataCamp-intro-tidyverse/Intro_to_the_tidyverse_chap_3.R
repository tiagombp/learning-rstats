library(gapminder)

library(dplyr)


# Filter for 1957 then summarize the median life expectancy

gapminder %>%
  
  filter(year == 1957) %>%
  
  summarize(medianLifeExp = median(lifeExp))

# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita


gapminder %>%
  
  filter(year == 1957) %>%
  
  summarize(medianLifeExp = median(lifeExp),
                        maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each year


gapminder %>%
  
  group_by(year) %>%
  
  summarize(medianLifeExp = median(lifeExp),
            	    maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each continent in 1957


gapminder %>%
  
  filter(year == 1957) %>%
  
  group_by(continent) %>%
  
  summarize(medianLifeExp = median(lifeExp),
            	    maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each year/continent combination

gapminder %>%
  
  group_by(continent, year) %>%
  
  summarize(medianLifeExp = median(lifeExp),
            	    maxGdpPercap = max(gdpPercap))

## 
library(gapminder)
library(dplyr)
library(ggplot2)

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(y=medianLifeExp, x=year)) +
  geom_point() +
  expand_limits(y=0)

# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(y=medianGdpPercap, x=year, color=continent)) +
  geom_point() +
  expand_limits(y=0)