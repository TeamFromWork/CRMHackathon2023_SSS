public class RefAgentIdentification {
    public static AgentWrapper findAgentDetails(list<string> lstInterests, string PrevAgentID){
        List<AgentWrapper> agntWrapLst = new List<AgentWrapper>();
         for(Banker__c bnk:[SELECT Id, Name, Deals_With__c, capacity__c,Application_Type__c, Branch_Code__c, 
                            Baker_Id__c,User__c,(select id from Referrals__r) 
                            FROM Banker__c where Deals_With__c IN: lstInterests AND Baker_Id__c !=: PrevAgentID]){
            AgentWrapper bnkobj = new AgentWrapper(bnk.Baker_Id__c,bnk.User__c,Integer.valueOf(bnk.capacity__c - bnk.Referrals__r.size()),bnk.Id,bnk.Application_Type__c);
            agntWrapLst.add(bnkobj);
        }
        agntWrapLst.sort();
        return agntWrapLst[0];
    }
}