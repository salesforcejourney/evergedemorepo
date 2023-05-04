//update the customer email address as 'default@customer.com'
public with sharing class BatchApexDemo implements Database.Batchable<SObject>, Database.Stateful {
  integer numberOfRecordsProcessed = 0;
  public database.QueryLocator start(Database.BatchableContext context) {
    //fetch the records for processing
    String query = 'select id,Contact_Email__c from customer__c';
    return Database.getQueryLocator(query);
  }
  public void execute(
    Database.BatchableContext context,
    List<customer__c> customerList
  ) {
    //exeucte the records fetched by start methods
    for (Customer__c customer : customerList) {
      customer.Contact_Email__c = 'default@customer.com';
      numberOfRecordsProcessed = numberOfRecordsProcessed + 1;
    }
    if (!customerList.isEmpty()) {
      try {
        update customerList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
    System.debug('numberOfRecordsProcessed ' + numberOfRecordsProcessed);
  }
  public void finish(Database.BatchableContext context) {
    //post processing after batch completed.
    System.debug('numberOfRecordsProcessed ' + numberOfRecordsProcessed);
    AsyncApexJob asyncJob = [
      SELECT
        Id,
        NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems,
        Status,
        CreatedBy.Email
      FROM AsyncApexJob
      WHERE id = :context.getJobId()
    ];
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    List<String> emailList = new List<String>{ asyncJob.CreatedBy.Email };
    mail.setToAddresses(emailList);
    mail.setSubject('Processing of Apex Batch job is completed');
    mail.setPlainTextBody(
      'Processing Completed. Total number of items processed ' +
        asyncJob.TotalJobItems +
        ' Total Errors in processing ' +
        asyncJob.NumberOfErrors
    );
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>{
      mail
    };
    Messaging.sendEmail(mailList);
  }
}
/**
 * Database.executeBatch(new BatchApexDemo(), 100);
 */
/** Schedule the batch to run after 30 mins
 * System.scheduleBatch(new BatchApexDemo(), 'Execute this job after 30 mins', 30, 100)
 */
