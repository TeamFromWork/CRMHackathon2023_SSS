({
    doInit : function(component, event, helper) {
        
        var action = component.get("c.getReferrals");
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('response '+state);
            if (state === "SUCCESS") {
                component.set("v.ReferralRecords", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})