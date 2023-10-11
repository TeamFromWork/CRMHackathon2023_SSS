public class recordAssignment {
    public static void assignRecords(List<Referral__c> refRecords){
        // Listing all expressed interests
        List<String> expInterestedList = new List<String>();
        for(Referral__c eachrec:refRecords){
            expInterestedList.add(eachRec.Expressed_interest__c);
        }
        
        //Preparing all bankers who are most available
        Map<string,List<bankerWrpper>> bankerMap = new Map<string,List<bankerWrpper>>();
        for(Banker__c bnk:[SELECT Id, Name, Deals_With__c, capacity__c, Branch_Code__c, Baker_Id__c,User__c,(select id from Referrals__r) FROM Banker__c where Deals_With__c IN: expInterestedList]){
            bankerWrpper bnkobj = new bankerWrpper(bnk.Baker_Id__c,bnk.User__c,Integer.valueOf(bnk.capacity__c - bnk.Referrals__r.size()),bnk.Id);
            if(!bankerMap.containsKey(bnk.Deals_With__c)){
                bankerMap.put(bnk.Deals_With__c,new List<bankerWrpper>());
            }
            bankerMap.get(bnk.Deals_With__c).add(bnkobj);
        }
        
        // Assigning records to banker object
        for(Referral__c eachrec:refRecords){
            List<bankerWrpper> bankerList = bankerMap.get(eachrec.Expressed_interest__c);
            if(! bankerList.isEmpty()){
                bankerList.sort();
                system.debug('bankerList : '+bankerList);
                eachrec.Banker__c = bankerList[0].recId;
                bankerList[0].remainingCapacity = bankerList[0].remainingCapacity - 1;
                if(String.isNotBlank(bankerList[0].User) && String.isNotEmpty(bankerList[0].User)){
                     eachrec.OwnerId = bankerList[0].User;
                }
                bankerMap.put(eachrec.Expressed_interest__c,bankerList);
            }
        }
        
    }
    
    public class bankerWrpper implements Comparable {
        Public string recId;
        Public string BankerId;
        Public string User;
        public integer remainingCapacity;
        public bankerWrpper(string BankerId,string User,integer remainingCapacity,string recId){
            this.BankerId = BankerId;
            this.User = User;
            this.remainingCapacity = remainingCapacity;
            this.recId = recId;
        }
        public Integer compareTo(Object compareTo) {
            recordAssignment.bankerWrpper otherWrapper = (recordAssignment.bankerWrpper)compareTo;
            Integer returnValue = 0;
            if (this.remainingCapacity < otherWrapper.remainingCapacity) {
                returnValue = 1;
            } else if (this.remainingCapacity > otherWrapper.remainingCapacity) {
                returnValue = -1;
            } 
            return returnValue;
        }
    }
}