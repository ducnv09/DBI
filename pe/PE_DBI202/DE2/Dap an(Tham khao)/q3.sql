select StockItemID, StockItemName, Color, StockItems.SupplierID, SupplierName from StockItems
join Suppliers on Suppliers.SupplierID = StockItems.SupplierID
where Color = 'Black' and UnitPrice > 30