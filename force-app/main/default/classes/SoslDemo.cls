public with sharing class SoslDemo {
  public static void staticSosl() {
    List<List<sObject>> searchList = [
      FIND 'United OR Ankit'
      IN ALL FIELDS
      RETURNING
        Account(Id, Name, Industry),
        Contact(Id, Lastname, Email),
        Opportunity(Id, Name, StageName LIMIT 5)
    ];

    List<Account> accList = (List<Account>) searchList[0];
    List<Contact> conList = (List<Contact>) searchList[1];
    List<Opportunity> oppList = (List<Opportunity>) searchList[2];

    for (Account acc : accList) {
      System.debug('Account Name ' + acc.Name);
    }
    for (Contact con : conList) {
      System.debug('Contact Name ' + con.LastName);
    }
    for (Opportunity opp : oppList) {
      System.debug('Opportunity Name ' + opp.Name);
    }
  }

  public static void dynamicSosl(String searchString) {
    String query = 'FIND :searchString IN ALL FIELDS RETURNING Account(Id,Name) , Contact(Lastname,Email)';
    List<List<sObject>> searchList = search.query(query);
    List<Account> accList = (List<Account>) searchList[0];
    List<Contact> conList = (List<contact>) searchList[1];
    System.debug('accList ' + accList);
    System.debug('conList ' + conList);
  }
}
