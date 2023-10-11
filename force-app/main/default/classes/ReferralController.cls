public with sharing class ReferralController {
    @AuraEnabled
    public static List<Referral__C> getReferrals(){
        List<Referral__C> refList=new List<Referral__c>();
        try{          
        
        refList=[SELECT Id, FirstName__c, Last_Name__c, Email__c, Phone__c, Expressed_interest__c, Stage__c, Source__c  FROM Referral__c Limit 10];
        }
        catch(Exception ex){
            throw ex;
        }
        return refList;
    }

}