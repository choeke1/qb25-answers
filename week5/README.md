Exericse 2.2: The slope of this line is 0.3776, this roughly resembles the graph obtained. However, there is a large spread so the exact trend is a little hard to interpret and looks almost like a slope of 1 to me, maybe slightly more shallow. It essentially means that for every year the a mother is older, they have about .38 more DNMs than the previous year. The pvalue is 2e-16, which means the probability that you would see these trends if the null hypothesis were true are very low.


The paternal regression model has a slope of 1.3538, meaning that for each additional year of paternal age, the number of paternal de novo mutations increases by approximately 1.35 mutations on average. The p-value is 2e-16, which is extremely small, suggesting that the likelihood of seeing such a strong relationship if the null hypothesis is true is nearly zero.



Exercise 2.4:

> #Exercise 2.4
> new_obs <- tibble(Father_age = 50.5)
> predict(paternal, newdata = new_obs)
       1 
78.69546 

The predicted number of DNMs for a father that is 50.5 years old would be roughly 79.


Exercise 2.6:

the output for my test (code in the R file) is:
	Paired t-test

data:  mergedtibble$Mother and mergedtibble$Father
t = -61.609, df = 395, p-value < 2.2e-16
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -40.48685 -37.98284
sample estimates:
mean difference 
      -39.23485 

This pvalue of less than 2.2e-16 is expected as the two histograms have very little overlap look like two sepearate distributions. This means we can reject the null hypothesis (which claims the two datasets would be part of the same distribution). Significance is described as the ability to reject the null hypothesis, and based on the results of our t-test and our low probability value that the data would appear if the null hypothesis is true, we can say that these data are significantly different.




THis is my output for the difference test:
Call:
lm(formula = I(Father - Mother) ~ 1, data = mergedtibble)

Residuals:
    Min      1Q  Median      3Q     Max 
-30.235  -9.235  -1.235   7.765  61.765 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  39.2348     0.6368   61.61   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 12.67 on 395 degrees of freedom

The intercept of 39.2348 shows that for each proband in the dataset there is a roughly 39 DNM difference between the maternal and paternal contribution. The maternal contributes less than the paternal. This is the same as our paired t-test where the mean difference is 39. Which also reflects the substantial shift in the paternal distribution on the histograms.




#Exercise 3:
I used the TidyTuesday week 5/6/2025 dataset: National Science Foundation Grant Terminations under the Trump Administration

Figure 3a:
This shows the top 20 cities with the most terminated grants under the trump administration. Interestingly the highest ranked city, Cambridge, had far more terminations than any other city with over 200 terminations. While the next city, Washington, had roughly 50. This data aligns with public new articles highlighting Trumps actions to revoke grants at Harvard, a univeristy located in Cambridge. Other cities with notable R1 insitutions that rely heavily on NSF funding were also among the top20- including New York, Chicaco, Ann Arbor, and Baltimore. 

No statistical analysis performed for this figure

Figure 3b:

This shows the estimated remaining funds for grants terminated/ in review under the Trump Administration. My hypothesis is that terminated grants have higher unspent funds than non-terminated grants.

After running an lm(estimated_remaining ~ is_terminated) function, the coefficient for termination status was negative (-26,810) with a p-value of 0.61, indicating no significant difference in estimated remaining funds between terminated and active grants. The model explained less than 0.1% of the variance (R² = 0.00013). Therefore the hypothesis that terminations are associated with higher unspent funds is not true. It highlights that the administration was not focused on remaining payouts when selecting grants for termination.

