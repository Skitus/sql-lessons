DO $$ 
DECLARE
  balance_from NUMERIC;
  balance_to NUMERIC;
BEGIN
  -- Отримуємо баланси акаунтів
  SELECT balance INTO balance_from
  FROM accounts
  WHERE id = 'c8b37d7c-b790-11ef-9ea1-8290f4b65f02';

  -- Перевірка, чи знайдено balance_from
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Акаунт c8b37d7c-b790-11ef-9ea1-8290f4b65f02 не знайдений';
  END IF;

  SELECT balance INTO balance_to
  FROM accounts
  WHERE id = 'c8b37db8-b790-11ef-9ea1-8290f4b65f02';

  -- Перевірка, чи знайдено balance_to
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Акаунт c8b37db8-b790-11ef-9ea1-8290f4b65f02 не знайдений';
  END IF;

  -- Переведення коштів (додаємо до балансу отримувача)
  UPDATE accounts
  SET balance = balance + balance_from
  WHERE id = 'c8b37db8-b790-11ef-9ea1-8290f4b65f02';

  -- Списання коштів з акаунту відправника
  UPDATE accounts 
  SET balance = balance - balance_from
  WHERE id = 'c8b37d7c-b790-11ef-9ea1-8290f4b65f02';

  -- Запис транзакції в журнал
  INSERT INTO transactions (amount, account_id)
  VALUES
    (balance_from, 'c8b37d7c-b790-11ef-9ea1-8290f4b65f02'),
    (balance_to, 'c8b37db8-b790-11ef-9ea1-8290f4b65f02');

  COMMIT;  -- Завершення транзакції
EXCEPTION
  WHEN OTHERS THEN
    -- Якщо сталася помилка, відкатуємо всі зміни
    ROLLBACK;
    -- Повідомляємо про помилку
    RAISE;
END $$;
