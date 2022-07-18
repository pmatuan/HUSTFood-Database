BULK INSERT customer
FROM '/home/pmat/Desktop/THCSDL/ProjectDB/customer.csv'
WITH
(
    FIRSTROW = 2, -- as 1st one is header
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
INSERT INTO customer
VALUES (101,'Linh', '0912000602', 'linh@gmail.com', '12345')