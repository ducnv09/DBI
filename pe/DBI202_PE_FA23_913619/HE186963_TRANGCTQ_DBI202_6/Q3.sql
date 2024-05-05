select c.ID as CarID, c.Description as CarDescription, c.Model, c.Brand, c.Category_ID, ca.Label as CategoryLabel
from Cars c
join Category ca on ca.ID = c.Category_ID
where ca.Label = 'luxury' or ca.Label = 'convertible'