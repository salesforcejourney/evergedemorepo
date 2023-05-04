public with sharing class UpdateCustomerOwnership implements Queueable {
  Map<Id, Id> recidOwnership = new Map<Id, Id>();

  public UpdateCustomerOwnership(Map<Id, Id> recidOwnership) {
    this.recidOwnership = recidOwnership;
  }
  public void execute(QueuableContext context) {
    //update the ownership of customers
    //client__c : parent
    //customer__c : child
    //Parent --> child
    //subquery with childrelationship name
    List<customer__c> masterCustomerList = new List<customer__c>();
    System.debug('recidOwnership ' + recidOwnership);
    List<Client> clientList = [
      SELECT id, name, (SELECT id, name, ownerid FROM Customers__r)
      FROM client__c
      WHERE id IN :recidOwnership.keySet()
    ];

    for (Client__c client : clientList) {
      List<Customer__c> customerList = client.Customers__r;
      for (Customer__c customer : customerList) {
        customer.ownerId = recidOwnership.get(client.Id);
        masterCustomerList.add(customer);
      }
    }

    if (!masterCustomerList.isEmpty()) {
      try {
        update masterCustomerList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
  }
}
