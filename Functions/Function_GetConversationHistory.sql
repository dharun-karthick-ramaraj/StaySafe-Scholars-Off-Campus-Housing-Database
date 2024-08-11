CREATE FUNCTION dbo.GetConversationHistory(@senderID INT, @receiverID INT, @pageSize INT = 0, @pageNumber INT = 1)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        MessageID,
        SenderID,
        ReceiverID,
        MessageContent,
        Timestamp
    FROM 
        MessagingSystem
    WHERE 
        (SenderID = @senderID AND ReceiverID = @receiverID)
        OR
        (SenderID = @receiverID AND ReceiverID = @senderID)
    ORDER BY 
        Timestamp DESC
    OFFSET (@pageNumber - 1) * @pageSize ROWS
    FETCH NEXT @pageSize ROWS ONLY
);






