-- SQL CHALLENGE ANSWERS

-- 1. Write a query to get the sum of impressions by day.
SELECT DAYNAME(date) as day, SUM(impressions) as total_impressions_per_day
FROM marketing_data
GROUP BY day;

-- 2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT state, SUM(revenue) as total_revenue_per_state
FROM website_revenue
GROUP BY state
ORDER BY total_revenue_per_state desc
LIMIT 3;
-- The third best state (OH) generated 37577 as revenue.

-- 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.

SELECT name, SUM(cost) AS total_cost, SUM(impressions) AS total_impressions,
SUM(clicks) AS total_clicks, SUM(revenue) AS total_revenue
FROM marketing_data
INNER JOIN campaign_info
ON marketing_data.campaign_id = campaign_info.id
INNER JOIN website_revenue
ON marketing_data.campaign_id = website_revenue.campaign_id
GROUP BY name;

-- 4. Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
SELECT SUM(conversions) AS total_conversions, state
FROM marketing_data
INNER JOIN campaign_info
ON marketing_data.campaign_id = campaign_info.id
INNER JOIN website_revenue
ON marketing_data.campaign_id = website_revenue.campaign_id
WHERE name='Campaign5'
GROUP BY state;
-- GA generated the most conversions for this campaign.


-- 5. In your opinion, which campaign was the most efficient, and why?

-- To determine which campaign was the most efficient, I decided to look at the total revenue per conversion rate for each campaign.
-- This metric shows the performance of each campaign by dividing the total amount of revenue by the total number of conversions.
-- The highest rate based on this calculation was for Campaign4, with a value of 17.558.
-- This indicates that Campaign4 achieved the highest level of efficiency in generating revenue from every conversion acquired.

SELECT name, SUM(revenue)/SUM(conversions) as total_rev_conv_rate
FROM website_revenue
INNER JOIN campaign_info on website_revenue.campaign_id=campaign_info.id
INNER JOIN marketing_data on website_revenue.campaign_id = marketing_data.campaign_id
GROUP BY name;

-- 6. (Bonus) Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.

SELECT
    DAYNAME(marketing_data.date) AS day_of_week,
    SUM(revenue) AS total_revenue
FROM
    marketing_data
INNER JOIN website_revenue on marketing_data.campaign_id=website_revenue.campaign_id
GROUP BY
    day_of_week
ORDER BY
    total_revenue DESC
LIMIT 1;
--measuring best day of week based on amount of total revenue.
