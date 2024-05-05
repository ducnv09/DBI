
create proc Proc2(@sName nvarchar(50), @year int, @TotalAmountExcludingTax decimal(18,2) output)
as
	begin
		select @TotalAmountExcludingTax =  sum(st.AmountExcludingTax)  from Suppliers s 
		join SupplierTransactions st
		on s.SupplierID = st.SupplierID
		where s.SupplierName = @sName
		and year(st.TransactionDate) = @year
	end
