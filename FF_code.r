

ggplot(data=wage_gap, aes(x=Date, y=Wage_Gap, group=Occupation)) +
  geom_line(aes(color=Occupation, alpha=1)) +
  geom_point(aes(color=Occupation, alpha=1)) +
  geom_text(data=wage_gap %>% filter(Date==2010),
            aes(label=paste0(Occupation, " - ", Wage_Gap, "%")),
            hjust=1.35,
            fontface="bold",
            size=2,
            nudge_x= .45) +
geom_text(data=wage_gap %>% filter(Date==2019),
            aes(label=paste0(Occupation, " - ", Wage_Gap, "%")),
            hjust= -.35,
            fontface="bold",
            size=2,
            nudge_x= -.45) + 
  scale_x_discrete(position = "top") +
  theme(legend.position = "none") +
  theme(panel.border = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(panel.grid.major.x = element_blank()) +
  theme(axis.text.x.top = element_text(size=8)) +
  theme(axis.ticks = element_blank()) +
  theme(plot.title = element_text(size=8, face = "bold", hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5)) + 
  theme(plot.caption = element_text(size=6)) + 
  labs(
    title="Women's Earnings as a Percent of Men's",
    caption="Source: Institute for Women's Policy Research"
  )
