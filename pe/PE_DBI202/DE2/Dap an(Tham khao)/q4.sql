select st.SupplierTransactionID, s.SupplierID, s.SupplierName, po.PurchaseOrderID, po.OrderDate, st.TransactionAmount from Suppliers s join PurchaseOrders po
on s.SupplierID = po.SupplierID
join SupplierTransactions st
on po.PurchaseOrderID = st.PurchaseOrderID
where OrderDate between '2015-2-20' and '2015-3-5' and s.SupplierID = st.SupplierID
order by MONTH(OrderDate) asc, TransactionAmount desc