//Whenever new customer record is created, share the record with HR Partner with edit access.
trigger CustomerTrigger on Customer__c(after insert) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
        CustomerTriggerHelper.afterInsert(Trigger.new);
    }
  }
}
