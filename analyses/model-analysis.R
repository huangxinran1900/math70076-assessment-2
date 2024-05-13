# Lasso Regression
# predictor matrix
X <- as.matrix(subset(train_set, select = -happiness_score))
y <- train_set$happiness_score
lasso_model <- cv.glmnet(X, y, alpha=1, nfolds=10)
lambda_optimal <- lasso_model$lambda.min
print(lambda_optimal)
coef_lasso <- coef(lasso_model, lambda=lambda_optimal)
print(coef_lasso)

# test on test set
test_X <- as.matrix(subset(test_set, select = -happiness_score))
predictions <- predict(lasso_model, s=lambda_optimal, newx=test_X)


## Results
coefs_df <- data.frame(
  Variable = c("Intercept", "GDP per Capita", "Social Support", 
               "Healthy Life Expectancy", "Freedom to Make Life Choices", 
               "Generosity", "Perceptions of Corruption"),
  Coefficient = c(2.2116002, 0.2477033, 1.5198522, 0.7941452, 1.2378764, 0, 0.5727289)
)

# Using knitr to create a table
knitr::kable(coefs_df, format = "markdown", caption = "Lasso Model Coefficients")
lasso_mse <- mean((test_set$happiness_score - predictions)^2)
test_lasso <- test_set%>%
  mutate(predictions = predictions)
plot_lasso <- ggplot(test_lasso, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

importance_rf <- importance(random_forest)
var_importance <- data.frame(
  Variables = rownames(importance_rf), Importance = importance_rf[, '%IncMSE']
)
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

rf_predictions <- predict(random_forest, newdata=test_set)
rf_mse <- mean((test_set$happiness_score - rf_predictions)^2)
test_rf <- test_set%>%
  mutate(predictions = rf_predictions)
plot_rf <- ggplot(test_rf, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

# KNN
set.seed(20)
train_control <- trainControl(method = "cv", number = 10)
# Train the KNN model
knn_model <- train(happiness_score ~ ., data = train_set, method = "knn",
                   trControl = train_control, preProcess = "scale", tuneLength = 10)
train_score <- train_set$happiness_score
knn_result <- knn(train = train_set, test = test_set, cl = train_score, k = 9)

knn_predictions <- as.numeric(levels(knn_result)[knn_result])
knn_mse <- mean((test_set$happiness_score - knn_predictions)^2)
print(knn_mse)
test_knn <- test_set%>%
  mutate(predictions = knn_predictions)
plot_knn <- ggplot(test_knn, aes(x=happiness_score, y=predictions))+
  geom_point(alpha=0.5)+
  geom_abline(intercept=0, slope=1, linetype="dashed", color = "blue")+
  labs(x="True happiness score", y="Predicted happiness score")+
  theme_minimal()

combined_plot <- grid.arrange(plot_lasso, plot_rf, plot_knn, ncol = 3)
print(combined_plot)