public with sharing class TestDataFactory {
  public static void createContactWithoutEmail() {
    //prepare data for testing
    List<Contact> conList = new List<Contact>();
    for (Integer i = 0; i < 50; i++) {
      Contact con = new Contact(lastname = 'lastname ' + i);
      conList.add(con);
    }
    insert conList;
  }
  public static void createContactWithCasesBasedOnEmail(String conemail) {
    Contact con = new Contact(lastname = 'Contact By Email', email = conemail);
    insert con;
    System.debug(con);

    List<Case> caseList = new List<Case>();
    for (Integer i = 0; i < 50; i++) {
      Case caserec = new Case();
      caserec.Priority = 'High';
      caserec.Status = 'Closed';
      caserec.Subject = 'Test Subject';
      caserec.ContactId = con.Id;
      caserec.Origin = 'Email';
      caseList.add(caserec);
    }

    insert caseList;

    System.debug(caseList);
  }
  /* During account creation if the annual revenue of an account is greater than 2M and industry is not blank, then
   *  do the automation to populate accout rating as Hot.*/
  public static void createAccountForAnnualRevenue() {
    List<Account> accList = new List<Account>();
    for (integer i = 0; i < 50; i++) {
      Account acc = new Account(
        name = 'Test Account ' + i,
        AnnualRevenue = 3000000,
        Industry = 'Energy',
        phone = '13123123123123'
      );
      accList.add(acc);
    }
    insert accList;
  }

  public static void createAccountWithOpportunities() {
    Account acc = new Account(Name = 'Account with Hot Rating', Rating = 'Hot');
    insert acc;

    List<Opportunity> oppList = new List<Opportunity>();
    for (Integer i = 0; i < 50; i++) {
      Opportunity opp = new Opportunity();
      opp.Name = 'Test Opportunity ' + i;
      opp.AccountId = acc.Id;
      opp.CloseDate = Date.today();
      opp.Amount = 5000;
      opp.StageName = 'Prospecting';
      oppList.add(opp);
    }
    insert oppList;
  }

  public static void badAccountDataForValidationTesting() {
    List<Account> accList = new List<Account>();
    for (Integer i = 0; i < 50; i++) {
      Account acc = new Account();
      acc.Name = 'Bad Account ' + i;
      acc.Rating = 'Hot';
      acc.AnnualRevenue = 0;
      accList.add(acc);
    }

    try {
      insert accList;
    } catch (Exception ex) {
      System.debug('Exception ' + ex.getMessage());
      System.assert(
        ex.getMessage().contains('Annual revenue for Hot Rating is Mandatory'),
        'Error Message - Account validations are failing'
      );
    }
  }

  public static void createUser() {
    User userrec = new User();
    List<account> accList = new List<Account>();
    Profile profileRec = [SELECT id FROM profile WHERE Name = 'Standard User'];
    userrec.Username =
      'standarduser' +
      Datetime.now().gettime() +
      '@evergetest.com';
    userrec.Email = 'standarduser@test.com';
    userrec.EmailEncodingKey = 'UTF-8';
    userrec.Alias = 'standu';
    userrec.FirstName = 'Standard';
    userrec.LastName = 'User Testing';
    userrec.LanguageLocaleKey = 'en_US';
    userrec.LocaleSidKey = 'en_US';
    userrec.TimeZoneSidKey = 'America/LOS_Angeles';
    userrec.ProfileId = profileRec.Id;

    System.runAs(userrec) {
      for (integer i = 0; i < 50; i++) {
        Account acc = new Account();
        acc.Name = 'Test Hot Account ' + i;
        acc.AnnualRevenue = 6000000;
        acc.rating = 'Hot';
        accList.add(acc);
      }
      insert accList;
    }
    Account acc1 = new Account(name = 'Other than standard user test', AnnualRevenue = 6000000,Rating = 'Hot');
    insert acc1;
  }
}
