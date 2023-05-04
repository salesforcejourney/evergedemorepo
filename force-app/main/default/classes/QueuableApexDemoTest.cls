@isTest
public with sharing class QueuableApexDemoTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createAccountWithOpportunities();
  }

  @IsTest
  static void testMethodName() {
    Test.startTest();
    System.enqueueJob(new QueuableApexDemo());
    Test.stopTest();
    List<Account> accList = [
      SELECT
        id,
        name,
        (
          SELECT id, stagename
          FROM Opportunities
        )
      FROM Account
      WHERE rating = 'Hot'
    ];
    System.debug('accList ' + accList);

    List<Opportunity> oppList = accList.get(0).Opportunities;

    System.debug('oppList ' + oppList);
    System.assert(
      oppList.get(0).StageName == 'Closed Won',
      'Error Message - Failure in Queuable job'
    );
  }
}
