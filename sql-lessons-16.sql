-- Створення таблиці
CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    balance INT
);

-- Вставка одного запису з автоматичним UUID і випадковим балансом
INSERT INTO accounts (balance) 
VALUES (FLOOR(RANDOM() * (100 - 1 + 1)) + 1);

-- Вставка кількох записів (100 записів) з автоматичним UUID та випадковими балансами
INSERT INTO accounts (id, balance)
SELECT
    uuid_generate_v1(),
    FLOOR(RANDOM() * 100) + 1  -- Генеруємо випадкове число від 1 до 100
FROM generate_series(1, 100) AS gs;

-- Перевірка результату
SELECT * FROM accounts;

select balance, count(*) from accounts group by balance having count(*) > 1; 

select *  from accounts where balance in (
	select balance from accounts group by balance having count(*) > 1
)


SELECT a.*, b.duplicate_count
FROM accounts a
JOIN (
    SELECT balance, COUNT(*) AS duplicate_count
    FROM accounts
    GROUP BY balance
    HAVING COUNT(*) > 1
) b ON a.balance = b.balance;



SELECT a.*, COUNT(*) OVER (PARTITION BY a.balance) AS duplicate_count
FROM accounts a
WHERE a.balance IN (
    SELECT balance
    FROM accounts
    GROUP BY balance
    HAVING COUNT(*) > 1
);

-- Видалення всіх записів
DELETE FROM accounts;

CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    amount INT DEFAULT FLOOR(RANDOM() * 100) + 1,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    account_id UUID REFERENCES accounts(id)
);

INSERT INTO transactions (amount, account_id)
SELECT 
    FLOOR(RANDOM() * 100) + 1,  -- Генерація випадкової суми
    (SELECT id FROM accounts ORDER BY RANDOM() LIMIT 1)  -- Вибір випадкового account_id
FROM generate_series(1, 100);  -- Кількість вставлених записів (100 записів)


select * from transactions;
