SELECT 
    s.ProductKey,
    s.OrderDateKey,
    s.CustomerKey,
    s.SalesOrderNumber,
    s.OrderQuantity,
    s.UnitPrice,
    s.UnitPriceDiscountPct,
    s.ProductStandardCost,
    ROUND(s.UnitPrice * s.OrderQuantity * (1 - s.UnitPriceDiscountPct), 2) AS SalesAmount,
    ROUND(s.ProductStandardCost * s.OrderQuantity, 2) AS ProductionCost,
    ROUND((s.UnitPrice * s.OrderQuantity * (1 - s.UnitPriceDiscountPct)) 
        - (s.ProductStandardCost * s.OrderQuantity), 2) AS Profit,
    YEAR(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d')) AS Year,
    MONTH(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo,
    MONTHNAME(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d')) AS MonthName,
    CONCAT('Q', QUARTER(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d'))) AS Quarter,
    DATE_FORMAT(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d'), '%Y-%b') AS YearMonth,
    DAYNAME(STR_TO_DATE(CAST(s.OrderDateKey AS CHAR), '%Y%m%d')) AS WeekDayName,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerFullName,
    p.EnglishProductName AS ProductName,
    t.SalesTerritoryCountry AS Country,
    t.SalesTerritoryRegion AS Region,
    t.SalesTerritoryGroup AS TerritoryGroup
FROM sales_combined s
JOIN dimproduct p ON s.ProductKey = p.ProductKey
JOIN dimcustomer c ON s.CustomerKey = c.CustomerKey
JOIN dimsalesterritory t ON s.SalesTerritoryKey = t.SalesTerritoryKey;