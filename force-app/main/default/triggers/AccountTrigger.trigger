/**
 * During account creation if the annual revenue of an account is greater than 2M and industry is not blank, then
 *  do the automation to populate accout rating as Hot.
 *
 * DML : Insert : trigger.new
 * Type : Before
 *
 */

/**
  * During account updation if phone number is updated, 
   populate account description with old phone number , new phone number and user name 
    who have done that change
    
    DML : Update : trigger.new, trigger.old, trigger.newMap, trigger.oldMap
    Type : Before 
*/

/* If the rating of account is Hot and Annual Revenue <= 0,
then validate and show error message "Annual revenue for Hot Rating is Mandatory" 

DML : Update,Insert
Type : Before

*/

/**
 * If phone number of Account is updated , update the same phone number for related contacts
 *
 * DML : update : trigger.new, trigger.old, trigger.newMap, trigger.oldMap
 * Type : After
 */

/**
 * If Account is created with SLA as Platinum , create the case,
 * link the case with account and
 * assign the case to the owner of the record.
 *
 * DML :  Insert : trigger.new
 * Type :  After
 */

/**
  * If phone number is changed call the third party API "Numverify" and validate the phone number
   DML : Update 
   Type : After
  */

/**
  during account creation If user with standard profile logs in and set the annual revenue greater than 5M , 
  set rating as Hot , populate SLA__c as Platinum
  for other users populate SLA__as Gold

   DML : Insert
   Type : Before 
  */

trigger AccountTrigger on Account(
  before insert,
  before update,
  after update,
  after insert
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      AccountTriggerHelper.beforeInsert(Trigger.new);
      //AccountTriggerHelper.validateAccountRatingWithRevenue(Trigger.new);
    }

    if (Trigger.isUpdate) {
      AccountTriggerHelper.beforeUpdate(Trigger.new, Trigger.oldMap);
      //AccountTriggerHelper.validateAccountRatingWithRevenue(Trigger.new);
    }
  }
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      AccountTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isInsert) {
      AccountTriggerHelper.afterInsert(Trigger.new);
    }
  }

}
