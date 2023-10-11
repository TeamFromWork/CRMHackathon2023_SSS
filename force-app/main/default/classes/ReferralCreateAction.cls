//action for splitting the payload
////payload format : CustomerFirstName|CustomerLastName|CustomerEmail|CustomerPhone|CustomerInterests
public class ReferralCreateAction {
    @InvocableMethod(label='Ref Eval Action' description= 'returns payload attributes' category='Custom')
    public static list<ReferralCreateAction.Params> setLeadParams(List<ReferralCreateAction.Request> lstPayloadParam){
        List<ReferralCreateAction.Params> results = new List<ReferralCreateAction.Params>();
        if(!lstPayloadParam.isEmpty()){
            ReferralCreateAction.Request rc = lstPayloadParam[0];
            string params = rc.Payload;
            list<string> lstLeadParams = params.split('|');
			ReferralCreateAction.Params rp = new ReferralCreateAction.Params();
            rp.FirstName = lstLeadParams[0];
            rp.LastName = lstLeadParams[1];
            rp.Email = lstLeadParams[2];
            rp.Phone = lstLeadParams[3];
            rp.CustomerInterests = lstLeadParams[4];
            results.add(rp);
        }
        return results;
    }
    
    public class Params {
        @InvocableVariable(label='FirstName')
        public string FirstName;
        
        @InvocableVariable(label='LastName')
        public string LastName;
        
        @InvocableVariable(label='Phone')
        public string Phone;
        
        @InvocableVariable(label='Email')
        public string Email;
        
        @InvocableVariable(label='CustomerInterests')
        public string CustomerInterests;
    }  
    
    public class Request {
        @InvocableVariable(label='Payload')
        public string Payload;
    }    
}