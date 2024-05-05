SELECT (c.First_Name+' '+c.Last_Name) AS Namec,COUNT(r.Customer_ID) AS Total,SUM(r.Amount) FROM Customers c
LEFT JOIN Rentals r
ON c.ID=r.Customer_ID
GROUP BY c.First_Name,C.Last_Name

