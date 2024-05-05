/*
DROP TABLE R
UPDATE R
SET name = 'hanh lỏ', class = 'đá đì'
WHERE lauched = 1921;

SELECT * FROM R

3. SELECT R.name, R.class
FROM R
WHERE R.LAUCHED >= 1940

4.SELECT R.class
FROM R
GROUP BY R.CLASS
HAVING COUNT(R.CLASS) >= 3

5.SELECT DISTINCT R.name
FROM R JOIN S ON R.class = S.class
WHERE S.lauched > 1920

6.SELECT R.name, S.displacement
FROM R JOIN S ON R.class = S.class
WHERE S.country = "USA" OR S.country = "Gt. Britain"

7. SELECT R.name, S.country
FROM R JOIN S ON R.class = S.class
WHERE S.sunGUNS > 8

8. 
SELECT S.country
FROM R JOIN S ON R.class = S.class
GROUP BY S.country
HAVING COUNT(R.class) = (SELECT MAX(t.numShip)
FROM (SELECT COUNT(R.class) as numShip
FROM R JOIN S ON R.class = S.class
GROUP BY S.COUNTRY) t)

C2:
SELECT S.country
FROM R JOIN S ON R.class = S.class
GROUP BY S.country
HAVING COUNT(R.class) >= ALL (SELECT COUNT(R.class) as numShip
FROM R JOIN S ON R.class = S.class
GROUP BY S.COUNTRY)

9.

*/
SELECT S.country
FROM R JOIN S ON R.class = S.class
GROUP BY S.country
HAVING COUNT(R.class) >= ALL (SELECT COUNT(R.class) as numShip
FROM R JOIN S ON R.class = S.class
GROUP BY S.COUNTRY)
