-- Tim kiem theo ten quan an, ten mon hoac ten the loai mon
-- SELECT id, restaurant_name, restaurant_address
-- FROM restaurant
-- WHERE restaurant_name LIKE ?
-- OR id IN(
--     SELECT restaurant_id FROM menu_item
--     WHERE item_name LIKE ?
--     OR category_name LIKE ?
-- )

-- Lay thong tin mon an cua 1 nha hang
-- SELECT id, item_name, price
-- FROM menu_item
-- WHERE restaurant_id = ?

-- Dang ky nguoi dung moi
-- Tao phuong thuc thanh toan mac dinh bang tien mat
-- INSERT INTO customer(customer_name, phone_number, email, password)
-- VALUES(?, ?, ?, ?)
-- INSERT INTO customer_payment(customer_id)
-- SELECT id FROM customer WHERE email = ?

-- Lay thong tin nguoi dung
-- SELECT id, customer_name, phone_number, email
-- FROM customer
-- WHERE id = ?

-- Lay thong tin thanh toan cua nguoi dung
-- SELECT payment_type FROM customer_payment
-- WHERE customer_id = ?
-- INSERT INTO customer_payment(customer_id, payment_type)
-- VALUES(?, ?)

-- Them mon an vao don hang
-- INSERT INTO placed_order(customer_id, restaurant_id, price, final_price, delivered)
-- VALUES(?, ?, 0, 0, 0)

-- 3 lenh duoi co the thuc hien nhieu lan de them cac mon an khac nhau
-- INSERT INTO order_status(placed_order_id, time_order, order_status, payment_status)
-- VALUES(?, GETDATE(), 'ADDED_TO_CART', 'NOT_CONFIRMED')
-- INSERT INTO in_order(placed_order_id, menu_item_id, quantity, offer_id, item_price, price)
-- VALUES(?, ?, ?, 1, ?, ?)

-- UPDATE placed_order
-- SET price = (
--     SELECT price FROM in_order
--     WHERE placed_order_id = ?
-- ),
-- final_price = price
-- WHERE id = ?