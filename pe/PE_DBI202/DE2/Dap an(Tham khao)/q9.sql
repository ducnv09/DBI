create trigger tr1 
on PurchaseOrders
after insert
as
	begin
		select PurchaseOrderID, SupplierID, OrderDate,
		ExpectedDeliveryDate, IsOrderFinalized, DeliveryMethod
		from inserted
	end


