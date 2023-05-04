@IsTest
public with sharing class DMLStatementDemoTest {
  @TestSetup
  static void prepareData() {
    TestDataFactory.createContactWithoutEmail();
    TestDataFactory.createContactWithCasesBasedOnEmail('test@test.com');
  }

  @IsTest
  static void createSingleRecordTest() {
    DMLStatementDemo.createSingleRecord();
    List<Account> accList = [
      SELECT id
      FROM Account
      WHERE name = 'Test Account demo 1'
    ];
    System.assert(accList.size() > 0, 'Error Message - Record Creation Failed');
  }

  @IsTest
  static void updateContactRecordsTest() {
    DMLStatementDemo.updateContactRecords();
    List<Contact> conList = [SELECT lastname, email FROM contact];
    System.assert(
      conList.get(0).Email == 'default@email.com',
      'Error Message - Record Update Failed'
    );
  }

  @IsTest
  static void deleteRecordsTest() {
    DMLStatementDemo.deleteRecords('test@test.com');

    List<Contact> conList = [
      SELECT id, (SELECT id FROM cases)
      FROM contact
      WHERE email = 'test@test.com'
    ];
    System.debug('conList size ' + conList);
    System.assert(
      conList.size() == 0,
      'Error Message - Record Deletion failed for contacts'
    );
    
  }
}
