# CRMHackathon2023_SSS
Lead Flow in the system ALGO

Lead is created from External Sources. Inputs channels for leads are and Inbound Lead Event Bus, and API
Lead is then normalised to a common format
The initial Stage of the lead is evaluated
The event is then published to the LeadEvent Event Bus
We have 3 subscribers to the channel from 4
The Customer Engine first checks for whether the LEad Event contains the Customer ID.
From 6 :: if Customer ID is not present, proceeds to identify the customer, returning Customer ID
From 7 :: The Customer then posts back an event to the LeadEvent Bus, with the Customer ID populated
The Agent Engine first checks for whether the Lead Event contains the Agent ID
From 9 :: If Current Agent Id is not present, proceeds to identify Agent, returning Agent ID
From 10 :: Agent Engine then populates the Agent ID, making sure it does not match with the Previous Agent ID value and posts back the event to eventbus
The Dispatcher checks for both Customer and Agent Ids, and then dispatches to the banker primary application (defined on banker profile)
For Re assigned leads :

the Current Banker ID is cleared and event published to the LeadEvent Bus
