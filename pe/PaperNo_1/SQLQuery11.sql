create trigger [dbo].[trg_not_duplicate] on [dbo].[film]
for insert 
as
begin
    if ( select count(f.title) from Film f where F.title in (select title from inserted)) > 1
	         rollback transaction
end

drop trigger [dbo].[trg_not_duplicate]