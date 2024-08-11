use StaySafeScholars

SELECT * FROM dbo.GetTenantBookings(11);

-- Retrieve the first page of conversation history (e.g., 10 messages)
SELECT * FROM dbo.GetConversationHistory(1, 11, 10, 1); -- Replace 1 and 2 with actual SenderID and ReceiverID

-- Retrieve the second page of conversation history (e.g., messages 11 to 20)
SELECT * FROM dbo.GetConversationHistory(10, 20, 10, 1); -- Replace 1 and 2 with actual SenderID and ReceiverID

SELECT * FROM dbo.GetAccommodationDetails(3);

