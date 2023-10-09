//Platform event subscription for Customer calculation
//payload format : CustomerFirstName|CustomerLastName|CustomerEmail|CustomerPhone|CustomerInterests
//CustomerInterests is in ; seperated format, and the first value is the priority interest.
trigger CustEvalEventTrigger on LeadEvent__e (after insert) {
    //Subscription to evaluate Customer ID
    EvaluateForLead evalLead = new EvaluateForLead();
    list<LeadEvent__e> lstEventsToRePublish = new list<LeadEvent__e>();
    for(LeadEvent__e ev : Trigger.New){
        String customerId = '';
        if(!String.isBlank(ev.Message_Payload__c)){
            list<String> lstPayloadAttributes = (ev.Message_Payload__c).split('|');
            //getting the parameters of the customer
            if(String.isBlank(ev.Customer_ID__c) && !lstPayloadAttributes.isEmpty()){
                customerId = evalLead.evaluateCustomer(lstPayloadAttributes);
                if(!String.isBlank(customerId)){
                    lstEventsToRePublish.add(evalLead.createLeadEvent(customerId, ev.Current_Agent_ID__c, ev));
                }
            }
        }
    }
    if(!lstEventsToRePublish.isEmpty()){
        EventBus.publish(lstEventsToRePublish);
    }
}