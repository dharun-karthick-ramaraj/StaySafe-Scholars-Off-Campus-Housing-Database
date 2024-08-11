CREATE TRIGGER trgEnforceBudgetRange
ON Tenant
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE BudgetRange < 500 OR BudgetRange > 5000)
    BEGIN
        PRINT 'Budget range must be between $500 and $5000. Rolling back transaction.';
        ROLLBACK;
    END
END;
