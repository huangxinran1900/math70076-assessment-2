# Predictions fit
# Lasso
plot_lasso <- ggplot(test_lasso, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

# Random Forest
plot_rf <- ggplot(test_rf, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

# KNN
plot_knn <- ggplot(test_knn, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

combined_plot <- grid.arrange(plot_lasso, plot_rf, plot_knn, ncol = 3)
print(combined_plot)