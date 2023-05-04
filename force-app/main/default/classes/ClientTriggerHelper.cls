public with sharing class ClientTriggerHelper {
  public static void afterUpdate(
    List<Client__c> newClientList,
    Map<Id, Client__c> oldClientMap
  ) {
    Map<Id, Id> recIdowneridMap = new Map<Id, Id>();
    for (Client__c client : newClientList) {
      if (client.ownerId != oldClientMap.get(client.Id).ownerId) {
        recIdowneridMap.put(client.Id, client.ownerId);
      }
    }
    if(!recIdowneridMap.isEmpty()){
        System.enqueueJob(new UpdateCustomerOwnership(recIdowneridMap));
    }
  }
}
