CREATE DATABASE Restaurant1
USE Restaurant1

CREATE TABLE Meals (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50) NOT NULL,
    Price MONEY NOT NULL
)

CREATE TABLE Tables (
    Number INT PRIMARY KEY NOT NULL
)


CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Meal_id INT NOT NULL,
    Table_number INT NOT NULL,
    Datetm DATETIME NOT NULL,
    FOREIGN KEY (Meal_id) REFERENCES Meals(id),
    FOREIGN KEY (Table_number) REFERENCES Tables(Number)
)

INSERT INTO Meals
VALUES
('Chicken Parmesan', 15),
('Grilled Salmon', 18.50),
('Vegetarian Pasta', 12.30),
('Pizza', 16),
('Slider Burger',22),
('Mushroom Risotto',19.70),
('Steak Grain Bowl',23)


INSERT INTO Tables 
VALUES
(1),
(2),
(3),
(4)


INSERT INTO Orders
VALUES
(1,2, '2024-03-01 12:30:00'),
(3,2, '2024-03-01 13:15:00'),
(4,3, '2024-03-01 14:26:00'),
(7,1, '2024-03-01 15:20:00'),
(6,3, '2024-03-01 15:55:00'),
(5,1, '2024-03-01 16:28:00'),
(2,1, '2024-03-01 17:21:00')

SELECT 
 Tables.Number AS TableNumber, (SELECT COUNT(Orders.Id) FROM Orders WHERE Tables.Number = Orders.Table_number) AS OrderCount FROM Tables


 SELECT 
    Meals.Id AS MealId,
    Meals.Name AS MealName,
    Meals.Price AS MealPrice,
    (SELECT COUNT(Orders.Id) FROM Orders WHERE Meals.Id = Orders.Meal_id) AS OrderCount
FROM Meals

SELECT 
    Orders.Id AS OrderId,
    Meals.Name AS MealName,
    Orders.Datetm AS OrderDatetime
FROM Orders
INNER JOIN Meals ON Orders.Meal_id = Meals.Id


SELECT 
    Orders.Id AS OrderId,
    Meals.Name AS MealName,
    Tables.Number AS TableNumber,
    Orders.Datetm AS OrderDatetime
FROM Orders
INNER JOIN Meals ON Orders.Meal_id = Meals.Id
INNER JOIN Tables ON Orders.Table_number = Tables.Number


SELECT 
    Tables.Number AS TableNumber,
    (
        SELECT SUM(Meals.Price)
        FROM Orders
        INNER JOIN Meals ON Orders.Meal_id = Meals.Id
        WHERE Orders.Table_number = Tables.Number
    ) AS TotalOrderAmount
FROM Tables


SELECT 
    DATEDIFF(HOUR, MIN(Orders.Datetm), MAX(Orders.Datetm)) AS HourDifference
FROM Orders
WHERE Orders.Table_number = 1



--taski yazanda hech sifarish olmayan masa yaratmag yadimdan chixib ancag kodunu yazdim 
SELECT Tables.Number AS TableNumber
FROM Tables
LEFT JOIN Orders ON Tables.Number = Orders.Table_number
WHERE Orders.Table_number IS NULL



SELECT * FROM Orders
WHERE DATEDIFF(MINUTE, Datetm, GETDATE()) <= 30


SELECT Tables.Number AS TableNumber
FROM Tables
LEFT JOIN Orders ON Tables.Number = Orders.Table_number  AND Orders.Datetm >= DATEADD(MINUTE, -60, GETDATE())
WHERE Orders.Id IS NULL


SELECT Tables.Number AS TableNumber
FROM Tables
LEFT JOIN Orders ON Tables.Number = Orders.Table_number AND Orders.Datetm >= DATEADD(MINUTE, -60, GETDATE())
WHERE Orders.Id IS NULL;
