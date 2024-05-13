# variable importance plot
var_importance %>%
  ggplot(aes(x=reorder(Variables, Importance), y = Importance))+
  geom_col(fill = "#006BA2", width = 0.6) +
  coord_flip() +
  labs(title="Feature Importance for Random Forest",
       x="Features",
       y="Increase in MSE")+
  theme_minimal()+
  theme(
    axis.title.y = element_blank(),  # Removes the y-axis title
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.line.y.left = element_line(color = "black")
  )+
  scale_y_continuous(expand = c(0, 0))
