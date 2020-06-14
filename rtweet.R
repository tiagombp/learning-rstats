library(tidyverse)
library(rtweet)
library(ggdark)
library(rcartocolor)
library(hrbrthemes); import_roboto_condensed()
library(showtext)
showtext_auto()
import_plex_sans()

library(extrafont)
fonte_pri <- "Lora"
fonte_sec <- "Varela Round"

tema <- function(){
  theme_minimal() +
    theme(
      text = element_text(family = fonte_sec, colour = "grey20"),
      title = element_text(family = fonte_pri, face = "bold", size = 12, color = "#832561"), 
      plot.subtitle = element_text(color = "grey20", face = "plain", size = 10),
      axis.text = element_text(colour = "grey20", size = 11),
      plot.caption = element_text(family = fonte_pri, face = "italic"),
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(),
      legend.text = element_text(size = 8),
      legend.title = element_text(size = 8),
      axis.ticks.y = element_blank(),
      axis.ticks.x = element_line(size = 0.5),
      axis.ticks.length.x = unit(.25, "cm"),
      axis.title = element_text(size = 11, colour = "grey20"),
      legend.position = 'none')
}


df_likes <- rtweet::get_favorites("tiagombp", n = 3000)

users_favorite<-
  df_likes %>% 
  group_by(screen_name, user_id) %>%
  summarise(
    quant_fav= n()
  )

users_favorite %>%
  ungroup() %>%
  top_n(15,quant_fav) %>%
  mutate(screen_name = reorder(screen_name,quant_fav)) %>%
  ggplot(aes(y = screen_name, x = quant_fav, fill = quant_fav)) + 
  geom_col() +
  dark_theme_minimal(base_family = font_rc, base_size = 16) +
  scale_fill_carto_c(palette = "Mint", direction = -1, guide = NULL)+
  labs(
    title = "Top 15 contas do twitter",
    y = "@ user names",
    x= "número de tweets que curti" 
  )


users_favorite %>%
  ungroup() %>%
  top_n(25,quant_fav) %>%
  mutate(screen_name = reorder(screen_name,quant_fav)) %>%
  ggplot(aes(y = screen_name, x = quant_fav)) + 
  geom_col(fill = "#832561", width = .7) +
  scale_x_continuous(expand = c(0.02,0.05)) +
  tema() +
  labs(
    title = "My most liked twitter accounts",
    subtitle = "In my last 3,000 likes",
    y = NULL,
    x= "# of likes" 
  )

ggsave("twitter.png", plot = last_plot(), type = "cairo-png", units = "in", width = 6, height = 4, dpi = 400)
