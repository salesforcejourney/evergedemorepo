public with sharing class CustomerTriggerHelper {
  public static void afterInsert(List<Customer__c> newCustomerList) {
    List<Customer__share> customerSharingList = new List<Customer__share>();
    for (Customer__c customer : newCustomerList) {
      Customer__share custShare = new Customer__share();
      custShare.parentId = customer.Id;
      custShare.userOrGroupId = customer.HR_Partner__c;
      custShare.accessLevel = 'edit';
      //Manual Sharing -- sharing record will be automatically
      //deleted when the owner of parent record changes
      //custShare.RowCause = Schema.Customer__share.RowCause.Manual;

      //Salesforce Classic -- OBject setup -- Create Apex Sharing Rule : HR Partner 
      custShare.RowCause = Schema.Customer__share.RowCause.HR_Partner__c;
      customerSharingList.add(custShare);
    }
    if (customerSharingList.size() > 0) {
      try {
        insert customerSharingList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
  }
}
