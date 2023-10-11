//Class for executing the logic

public class EvaluateForLead {
    public EvaluateForLead(){}
    
    public AgentWrapper evaluateAgent(list<string> lstInterests, string PrevAgentID){
        return RefAgentIdentification.findAgentDetails(lstInterests,PrevAgentID);
    }
    
    public string evaluateCustomer(list<string> lstMessagePayload){
        string cutomerId = '';
        //get customer details from message attributes :
        //payload format : CustomerFirstName|CustomerLastName|CustomerEmail|CustomerPhone|CustomerInterests
        if(!lstMessagePayload.isEmpty()){
            string custFirstName = lstMessagePayload[0];
            string custLastName = lstMessagePayload[1];
            string custEmail = lstMessagePayload[2];
            string custPhone = lstMessagePayload[3];
            //find customer
            Customer__c cust = [SELECT Id, Customer_Id__c FROM Customer__c WHERE First_Name__c = :custFirstName AND Last_Name__c = :custLastName AND Email__c = :custEmail LIMIT 1];
            if(cust != null){
                cutomerId = cust.Customer_Id__c;
            }else{
                //create Customer
                Customer__c newC = new Customer__c();
                newC.First_Name__c = custFirstName;
                newC.Last_Name__c = custLastName;
                newC.Email__c = custEmail;
                newC.Phone__c = custPhone;
                newC.Customer_Id__c = String.ValueOf(Math.Random() * 10000);
                newC.Customer_Name__c = newC.First_Name__c + ' ' + newC.First_Name__c;
                insert newC;
                cutomerId = newC.Customer_Id__c;
            }
        }
        return cutomerId;
    }
    
    public LeadEvent__e createLeadEvent(string custId, AgentWrapper agentDetails, LeadEvent__e IncomingEvent){
        LeadEvent__e returnEvent = new LeadEvent__e();
        returnEvent.Current_Agent_ID__c = agentDetails!=null?agentDetails.agentId:null;
        returnEvent.Current_Owner_Id__c = agentDetails!=null && agentDetails.User != null?agentDetails.User:null;
        returnEvent.Current_App_ID__c = agentDetails!=null?agentDetails.applicationType:null;
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