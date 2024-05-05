delete Suppliers
where SupplierID not in(select s.SupplierID from Suppliers s join StockItems st
on s.SupplierID = st.SupplierID
union 
select s.SupplierID from Suppliers s 
join SupplierTransactions stra
on s.SupplierID = stra.SupplierID
union 
select s.SupplierID from Suppliers s 
join PurchaseOrders p
on s.SupplierID = p.SupplierID)
