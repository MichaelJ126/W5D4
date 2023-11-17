-- 2. Add a new column in the customer table for Platinum Member. This can be a boolean.
-- Platinum Members are any customers who have spent over $200. 
-- Create a procedure that updates the Platinum Member column to True for any customer who has spent over $200 and False for any customer who has spent less than $200.
-- Use the payment and customer table.

ALTER TABLE customer
ADD COLUMN Platinum_member BOOLEAN default False;
CREATE PROCEDURE update_platimum_member()
AS $$
BEGIN
UPDATE customer
SET Platinum_member = true
WHERE customer_id IN (
SELECT customer_id
FROM payment
GROUP BY payment.customer_id
HAVING SUM(payment.amount) > 200
);
COMMIT; 
END;
$$ LANGUAGE plpgsql 
CALL update_platimum_member() 

SELECT *
FROM customer
WHERE customer_id = 526 OR customer_id = 148;