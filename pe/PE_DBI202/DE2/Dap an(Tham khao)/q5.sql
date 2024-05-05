select s.SupplierID, s.SupplierName, count(st.StockItemID) as NumberOfStockItem from Suppliers s
left join StockItems st
on s.SupplierID = st.SupplierID
group by s.SupplierID, s.SupplierName
order by NumberOfStockItem desc, SupplierName asc