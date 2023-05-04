public with sharing class ContactTriggerHelper {
  public static void afterInsert(List<Contact> newConList) {
    Set<Id> accountIdSet = new Set<Id>();

    for (Contact con : newConList) {
      if (String.isNotBlank(con.AccountId)) {
        accountIdSet.add(con.AccountId);
      }
    }

    //Contact_Count__c
    //Account - Parent
    //Contact - Child
    //Parent --> Child traversing
    if (!accountIdSet.isEmpty()){
      updateContactCount(accountIdSet);
    }
  }

  public static void afterUpdate(
    List<Contact> newConList,
    Map<Id, Contact> oldContactMap
  ) {
    Set<Id> accountIdSet = new Set<Id>();
    for (Contact con : newConList) {
      if (con.AccountId != oldContactMap.get(con.Id).AccountId) {
        accountIdSet.add(con.AccountId);
        accountIdSet.add(oldContactMap.get(con.Id).AccountId);
      }
    }
    updateContactCount(accountIdSet);
  }

  public static void updateContactCount(Set<Id> accountIdSet) {
    List<Account> accList = [
      SELECT id, Contact_Count__c, Name, (SELECT id FROM contacts)
      FROM Account
      WHERE Id IN :accountIdSet
    ];
    for (Account acc : accList) {
      List<Contact> conList = acc.Contacts;
      acc.Contact_Count__c = conList.size();
    }
    if (!accList.isEmpty()) {
      try {
        update accList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
  }
}
