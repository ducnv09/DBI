with t as(
select MONTH(TransactionDate) as [Month], YEAR(TransactionDate) as [Year], count(SupplierTransactionID) as NumberOfSupplierTransactions from SupplierTransactions
group by YEAR(TransactionDate), MONTH(TransactionDate)
)
select * from t
where NumberOfSupplierTransactions = (select min(NumberOfSupplierTransactions) from t)