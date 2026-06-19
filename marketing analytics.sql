SELECT *
FROM CampaignPerformance
WHERE impressions IS NULL
OR clicks IS NULL
OR revenue IS NULL;

SELECT id, COUNT(*)
FROM CampaignPerformance
GROUP BY id
HAVING COUNT(*) > 1;

UPDATE CampaignPerformance
SET campaign_name = LOWER(campaign_name);

SELECT
SUM(revenue) AS TotalRevenue
FROM CampaignPerformance;

SELECT
SUM(mark_spent) AS TotalSpend
FROM CampaignPerformance;

SELECT
SUM(leads) AS TotalLeads
FROM CampaignPerformance;

SELECT
ROUND(
((SUM(revenue)-SUM(mark_spent))
/SUM(mark_spent))*100,2
) AS ROI_Percentage
FROM CampaignPerformance;

SELECT
campaign_name,
SUM(revenue) Revenue
FROM CampaignPerformance
GROUP BY campaign_name
ORDER BY Revenue DESC;

SELECT
campaign_name,
SUM(mark_spent) Spend
FROM CampaignPerformance
GROUP BY campaign_name
ORDER BY Spend DESC;

SELECT
campaign_name,
SUM(orders) Orders
FROM CampaignPerformance
GROUP BY campaign_name
ORDER BY Orders DESC;

SELECT
category,
SUM(revenue) Revenue,
SUM(mark_spent) Spend,
SUM(orders) Orders
FROM CampaignPerformance
GROUP BY category;

SELECT
campaign_name,
ROUND(
SUM(clicks)*100.0/
SUM(impressions),2
) AS CTR
FROM CampaignPerformance
GROUP BY campaign_name
ORDER BY CTR DESC;

SELECT
campaign_name,
ROUND(
SUM(mark_spent)/
SUM(leads),2
) AS CPL
FROM CampaignPerformance
GROUP BY campaign_name;

SELECT
campaign_name,
ROUND(
SUM(mark_spent)/
SUM(orders),2
) AS CPA
FROM CampaignPerformance
GROUP BY campaign_name;

SELECT
c_date,
SUM(revenue) Revenue,
SUM(mark_spent) Spend,
SUM(orders) Orders
FROM CampaignPerformance
GROUP BY c_date
ORDER BY c_date;

go
CREATE OR ALTER VIEW vw_CampaignSummary
AS
SELECT
campaign_name,
category,
SUM(impressions) AS Impressions,
SUM(clicks) AS Clicks,
SUM(leads) AS Leads,
SUM(orders) AS Orders,
SUM(mark_spent) AS Spend,
SUM(revenue) AS Revenue
FROM CampaignPerformance
GROUP BY campaign_name, category;
go

go
CREATE OR ALTER VIEW vw_DailyPerformance
AS
SELECT
c_date,
SUM(revenue) Revenue,
SUM(mark_spent) Spend,
SUM(orders) Orders
FROM CampaignPerformance
GROUP BY c_date;
go
