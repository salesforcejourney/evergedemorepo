public with sharing class SOQLDemo {
  //Get all the accounts from system where account Industry is Energy
  public static void standardSoqlQuery() {
    //List<Account> accList = new List<Account>();
    List<Account> accList = [
      SELECT id, name, rating
      FROM Account
      WHERE Industry = 'Energy'
      WITH USER_MODE
    ];

    for (Account acc : accList) {
      System.debug(acc.Name);
    }
  }

  public static void standardSOQLQueryWithParameter(String accIndustry) {
    List<Account> accList = [
      SELECT id, name, rating
      FROM Account
      WHERE Industry = :accIndustry
      WITH USER_MODE
    ];
    for (Account acc : accList) {
      System.debug(acc.Name);
    }
  }

  public static void standardSOQLQueryWithMultiParameter(
    List<String> accIndustryList
  ) {
    List<Account> accList = [
      SELECT id, name, rating, Industry
      FROM Account
      WHERE Industry IN :accIndustryList
      WITH USER_MODE
    ];
    for (Account acc : accList) {
      System.debug(acc.Name + '--' + acc.Industry);
    }
  }

  /**
   * 
   * List<String> industryList = new List<String>{'Energy','Biotechnology'}; 
    SOQLDemo.standardSOQLQueryWithMultiParameter(industryList);
   */

  public static void dynamicSoqlDemo(String objectname) {
    String accfieldList = 'Industry,rating,annualRevenue';
    String confieldList = 'Lastname,Email,Phone';
    String selectedFieldList = '';
    List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();

    if (objectname.equalsIgnoreCase('Account')) {
      selectedFieldList = accfieldList;
    } else if (objectname.equalsIgnoreCase('Contact')) {
      selectedFieldList = confieldList;
    }
    if (String.isNotBlank(selectedFieldList)) {
      String query =
        ' select Id,Name, ' +
        selectedFieldList +
        ' from ' +
        objectname;

      List<sObject> recordList = Database.query(query, AccessLevel.USER_MODE);

      if (objectname.equalsIgnoreCase('Account')) {
        accList = (List<Account>) recordList;
        System.debug('Account List ' + accList);
      } else if (objectname.equalsIgnoreCase('Contact')) {
        conList = (List<Contact>) recordList;
        System.debug('Contact List ' + conList);
      }
    }
  }

  public static void childToParentTraversing(String industry) {
    for (Contact con : [
      SELECT
        id,
        firstname,
        lastname,
        Account.Name,
        Account.Industry,
        Account.Owner.Name
      FROM contact
      WHERE Account.Industry = :industry
      WITH USER_MODE
    ]) {
      System.debug(
        'Contact Lastname ' +
          con.LastName +
          ' Account Name ' +
          con.Account.Name +
          'Account Owner Name ' +
          con.Account.Owner.Name
      );
    }
  }

  public static void parentToChildTraversing(String industry) {
    for (Account acc : [
      SELECT id, name, industry, (SELECT firstname, lastname FROM contacts)
      FROM Account
      WHERE industry = :industry
      WITH USER_MODE
    ]) {
      System.debug('Account Name ' + acc.name);
      List<Contact> conList = acc.contacts;
      for (Contact con : conList) {
        System.debug('Related Contacts ' + con.lastname);
      }
    }
  }

  public static void aggregateQueries() {
    for (AggregateResult agr : [
      SELECT
        industry,
        count(Id),
        avg(annualrevenue) AvgAnnualRevenue,
        sum(annualrevenue)
      FROM Account
      WHERE industry != NULL
      GROUP BY Industry
    ]) {
      System.debug('Industry Name ' + agr.get('Industry'));
      System.debug('Annual Revenu ' + agr.get('AvgAnnualRevenue'));
      System.debug('Count ' + agr.get('expr0'));
      System.debug('Sum Of Revenue ' + agr.get('expr1'));
    }
  }

  public static void soqlQuerieswithMap() {
    Map<Id, Account> accMap = new Map<Id, Account>(
      [SELECT Id, Name FROM Account WHERE industry = 'Energy']
    );
    System.debug('Count of records ' + accMap.size());
    for(Id accId : accMap.keySet()){
      Account acc = accMap.get(accId);
      System.debug(acc);
    }
  }
}
