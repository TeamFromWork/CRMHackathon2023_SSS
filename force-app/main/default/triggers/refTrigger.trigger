trigger refTrigger on Referral__c (before insert) {
	recordAssignment.assignRecords(trigger.new);
}