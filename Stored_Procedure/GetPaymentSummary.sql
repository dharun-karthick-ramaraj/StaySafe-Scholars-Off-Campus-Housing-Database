-- Stored Procedure to Get Payment Summary
CREATE PROCEDURE GetPaymentSummary
    @TotalPending INT OUTPUT,
    @TotalCompleted INT OUTPUT,
    @TotalAmount DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SELECT
        @TotalPending = COUNT(CASE WHEN PaymentStatus = 'Pending' THEN 1 END),
        @TotalCompleted = COUNT(CASE WHEN PaymentStatus = 'Completed' THEN 1 END),
        @TotalAmount = SUM(PaymentAmount)
    FROM
        BillingSystem;
END;