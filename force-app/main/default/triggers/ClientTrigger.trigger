//if client owner is changed , change the owner of all related customers.
//DML -- update : trigger.new and trigger.old
//Type -- after
trigger ClientTrigger on Client__c(after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      ClientTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
