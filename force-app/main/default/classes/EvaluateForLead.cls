//Class for executing the logic

public class EvaluateForLead {
    public EvaluateForLead(){}
    
    public string evaluateAgent(list<string> lstInterests, string PrevAgentID){
        string evaluatedAgentId = '';
        return evaluatedAgentId;
    }
    
    public string evaluateCustomer(list<string> lstMessagePayload){
        string cutomerId = '';
        return cutomerId;
    }
    
    public LeadEvent__e createLeadEvent(string custId, String agentId, LeadEvent__e IncomingEvent){
        LeadEvent__e returnEvent = new LeadEvent__e();
        returnEvent.Current_Agent_ID__c = !string.isBlank(agentId)?agentId:null;
        returnEvent.Current_App_ID__c = IncomingEvent.Current_App_ID__c;
        returnEvent.Customer_ID__c = !string.isBlank(custId)?custId:null;
        returnEvent.Message_Payload__c =  IncomingEvent.Message_Payload__c;
        returnEvent.Previous_Agent_ID__c = IncomingEvent.Previous_Agent_ID__c;
        returnEvent.Previous_App_ID__c = IncomingEvent.Previous_App_ID__c;
        returnEvent.SLA_In_Hours__c = IncomingEvent.SLA_In_Hours__c;
        returnEvent.Status__c =  IncomingEvent.Status__c;
        returnEvent.Sub_Status__c = IncomingEvent.Sub_Status__c;
        returnEvent.System_Trail__c = IncomingEvent.System_Trail__c;
        returnEvent.TimeStamp__c = IncomingEvent.TimeStamp__c;  
        return returnEvent;
    }
}