/*
    if the new contact is created and contact is linked the the account -- increase the contact count by 1
    if existing  contact is modified and contact and account id is changed  -- decrease the contact count by 1 , increase the contact count by 1 
                        existing Account : TATA  : -1
                        new Account      : RELIANCE : +1
    if contact is deleted then decrease the contact count by 1
    if contact is restored then increase the contact count by 1

    DML : Insert, Update, Delete, Undelete
    Type : After

    Insert : Trigger.new
    Undelte : Trigger.new
    Delete : Trigger.old
    Update : Trigger.new,Trigger.oldMap
*/
trigger ContactTrigger on Contact(
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      ContactTriggerHelper.afterInsert(Trigger.new);
    }
    if (Trigger.isUndelete) {
      ContactTriggerHelper.afterInsert(Trigger.new);
    }
    if (Trigger.isDelete) {
      ContactTriggerHelper.afterInsert(Trigger.old);
    }
    if (Trigger.isUpdate) {
      ContactTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
