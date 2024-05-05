SELECT CR.ID AS CarID,
	   CG.Description AS CarDescription,
	   CR.Model,
	   CR.Brand,
	   CR.Category_ID,
	   CG.Label AS CategoryLabel
FROM Cars AS CR
	 JOIN Category AS CG ON CR.Category_ID = CG.ID
WHERE CG.Label = 'luxury' OR CG.Label = 'convertible'