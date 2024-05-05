CREATE TRIGGER InsertSubCategory
ON SubCateGory
AFTER INSERT
AS
BEGIN
	SELECT I.SubCategoryName, C.CategoryName
	FROM inserted AS I
		 JOIN Category AS C ON I.CategoryID = C.ID
END