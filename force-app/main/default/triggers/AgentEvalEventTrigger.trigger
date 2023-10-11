//Platform event subscription for agent calculation
//payload format : CustomerFirstName|CustomerLastName|CustomerEmail|CustomerPhone|CustomerInterests
//CustomerInterests is in ; seperated format, and the first value is the priority interest.
trigger AgentEvalEventTrigger on LeadEvent__e (after insert) {
	//Subscription to evaluate Agent ID
    EvaluateForLead evalLead = new EvaluateForLead();
    list<LeadEvent__e> lstEventsToRePublish = new list<LeadEvent__e>();
    for(LeadEvent__e ev : Trigger.New){
        if(String.isBlank(ev.Current_Agent_ID__c) && !String.isBlank(ev.Message_Payload__c)){
            //No agent Id present, hence sent for processing
            list<String> lstPayloadAttributes = (ev.Message_Payload__c).split('|');
            //getting the interests of the customer
            if(!lstPayloadAttributes.isEmpty() && !String.isBlank(lstPayloadAttributes[lstPayloadAttributes.size()-1])){
            	list<String> lstCustomerInterests = (lstPayloadAttributes[lstPayloadAttributes.size()-1]).split(';');
                if(!lstCustomerInterests.isEmpty()){ 
                    AgentWrapper agentDetails = evalLead.evaluateAgent(lstCustomerInterests, ev.Previous_Agent_ID__c);
                    if(agentDetails != null){
                        lstEventsToRePublish.add(evalLead.createLeadEvent(ev.Customer_ID__c, agentDetails, ev));
                    }
                }                
            }

        }   
    }
    if(!lstEventsToRePublish.isEmpty()){
        EventBus.publish(lstEventsToRePublish);
    }
}