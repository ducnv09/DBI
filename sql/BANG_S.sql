CREATE TABLE S(
	class nvarchar(50),
	[type] nvarchar (50), 
	country nvarchar(50),
	numGuns int, 
	bore int, 
	displacement int
	);
INSERT INTO S 
	VALUES('Bismarck','bb','Germany',8,15,42000),
	('Iowa', 'bb','USA',9,16,46000),
	('Kongo', 'bc', 'Japan',8,14,32000),
	('North Carolina', 'bb','USA', 9,16,37000),
	('Renown', 'bc','Gt. Britain', 6,15,32000),
	('Revenge', 'bb','Gt. Britain', 8,15,29000),
	('Tennessee','bb','USA', 12,14,32000),
	('Yamato','bb','Japan',9,18,65000)
;