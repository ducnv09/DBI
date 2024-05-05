with t as (
select st.SupplierID, st.SupplierTransactionID, st.TransactionAmount from SupplierTransactions st
left join PurchaseOrders p
on st.PurchaseOrderID = p.PurchaseOrderID
where TransactionType = 'Supplier Invoice'
and YEAR(OrderDate) = 2013
)
select s.SupplierID, s.SupplierName, count(t.SupplierTransactionID) as NumberOfSupplierTransactions, sum(t.TransactionAmount) as TotalTransactionAmount from Suppliers s
left join t
on s.SupplierID = t.SupplierID
group by s.SupplierID, s.SupplierName
order by TotalTransactionAmount desc


