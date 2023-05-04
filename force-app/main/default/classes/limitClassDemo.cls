public with sharing class limitClassDemo {
  public static void limitClassMethodsDemo() {
    List<Account> accList = [SELECT id FROM Account];
    System.debug('accList size ' + accList.size());
    List<Contact> conList = [
      SELECT id
      FROM Contact
      LIMIT :(Limits.getLimitQueryRows() - Limits.getQueryRows())
    ];
    System.debug('conList size ' + conList.size());

    System.debug('getQueries() ' + Limits.getQueries());
    System.debug('getLimitQueries() ' + Limits.getLimitQueries());
    System.debug('getQueryRows()() ' + Limits.getQueryRows());
    System.debug('getLimitQueryRows() ' + Limits.getLimitQueryRows());
    System.debug(
      'Total no of records can be retrieved ' +
        Limits.getLimitQueryRows() -
        Limits.getQueryRows()
    );
  }
}
