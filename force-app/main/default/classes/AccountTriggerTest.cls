@IsTest
public with sharing class AccountTriggerTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createAccountForAnnualRevenue();
    TestDataFactory.badAccountDataForValidationTesting();
    TestDataFactory.createUser();
  }
  @IsTest
  static void beforeInsertTest() {
    List<Account> accList = [
      SELECT id, rating
      FROM Account
      WHERE AnnualRevenue > 2000000 AND Industry != NULL
    ];
    System.assert(
      accList.get(0).Rating == 'Hot',
      'Error - Account Rating not updated'
    );
  }
  @IsTest
  static void beforeUpdateTest() {
    List<Account> accList = [SELECT id, phone FROM Account];
    for (Account acc : accList) {
      acc.phone = '213123123123123';
    }

    Test.setMock(HttpCalloutMock.class, new phoneValidatorMockResponse());

    Test.startTest();
    update accList;
    Test.stopTest();

    List<Account> updatedList = [SELECT id, phone, description FROM Account];
    System.assert(
      String.isNotBlank(updatedList.get(0).Description),
      'Error Message - Description update failed'
    );
    System.assert(
      updatedList.get(0).Phone == '213123123123123',
      'Error Message - Description update failed'
    );
  }

  @isTest
  static void beforeInsertProfileTest() {
    List<Account> accList = [
      SELECT id, SLA__c
      FROM Account
      WHERE AnnualRevenue > 5000000 AND rating = 'Hot'
    ];
    System.assert(
      accList.get(0).SLA__c == 'Platinum',
      'Error Message - SLA_c update failed'
    );

    Account acc = [
      SELECT id, SLA__c
      FROM account
      WHERE name = 'Other than standard user test'
    ];
    System.assert(
      acc.SLA__c == 'Gold',
      'Error Message - SLA_c Gold update failed'
    );
  }
}
