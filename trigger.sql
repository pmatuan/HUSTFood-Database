DROP TRIGGER AddUser
CREATE TRIGGER AddUser
ON customer
FOR INSERT
AS
PRINT 'Đã thêm 1 người dùng'
GO