@RestResource(urlMapping='/v1/AccountMgmt/*')
global with sharing class AccountRestService {
  //get all the account where industry is energy
  @httpget
  //   global static List<Account> getEnergyIndustry() {
  //     List<Account> accList = [
  //       SELECT id, name, rating
  //       FROM Account
  //       WHERE industry = 'Energy'
  //     ];
  //     return accList;
  //   }

  //   global static List<Account> getIndustryRecords() {
  //     Map<String, String> paramsMap = RestContext.request.params;
  //     String Industry = paramsMap.get('industry');
  //     String Rating = paramsMap.get('rating');
  //     List<Account> accList = [
  //       SELECT id, name, rating
  //       FROM Account
  //       WHERE industry = :Industry and Rating = :Rating
  //     ];
  //     return accList;
  //   }

  //based on industry, return the list of accounts, list of contacts and list of cases.
  global static AccountWrapper getIndustryRecords() {
    Map<String, String> paramsMap = RestContext.request.params;
    String Industry = paramsMap.get('industry');
    Map<Id, Account> accMap = new Map<Id, Account>(
      [SELECT id, name, rating FROM Account WHERE Industry = :Industry]
    );
    List<Contact> contactList = [
      SELECT firstname, lastname
      FROM contact
      WHERE accountId IN :accMap.keyset()
    ];
    List<Case> caseList = [
      SELECT subject, description, priority, status
      FROM Case
      WHERE accountId IN :accMap.keyset()
    ];

    AccountWrapper wrapper = new AccountWrapper();
    wrapper.accList = accMap.values();
    wrapper.conList = contactList;
    wrapper.caseList = caseList;

    return wrapper;
  }

  @Httppost
  //   global static String postAccount(
  //     String accName,
  //     String accIndustry,
  //     String accrating,
  //   ) {
  //     Account acc = new Account(
  //       name = accName,
  //       Industry = accIndustry,
  //       rating = accrating
  //     );
  //     try {
  //       insert acc;
  //       return acc.Id;
  //     } catch (Exception ex) {
  //       return ex.getMessage();
  //     }
  //   }
  /**
  * 
  {
    "accName" : "Account from Rest Service",
    "accIndustry" : "Energy",
    "accrating" : "Hot"
    
}
  */
  //   global static responseWrapper postAccountContact(
  //     AccountInformation information
  //   ) {
  //     Account accRecord = information.accountRecord;
  //     Contact conRecord = information.contactRecord;
  //     responseWrapper wrapper = new responseWrapper();
  //     try {
  //       insert accRecord;
  //       conRecord.accountId = accRecord.Id;
  //       insert conRecord;
  //       wrapper.accId = accRecord.Id;
  //       wrapper.conId = conRecord.Id;
  //       wrapper.message = 'Account and Contact Created Successfully';
  //       return wrapper;
  //     } catch (exception ex) {
  //       wrapper.accId = '';
  //       wrapper.conId = '';
  //       wrapper.message = ex.getMessage();
  //       return wrapper;
  //     }
  //   }

  /**
   * 
   {
    "information" :{
        "accountRecord" :{
            "Name" :"Account Name from Rest Service",
            "Rating" : "Hot",
            "Industry" : "Energy",
            "SLA__c" : "Platinum"
        },
        "contactRecord" : {
            "LastName" : "JSON",
            "FirstName" : "Contact"
        }
    }
}
   */

  global static responseWrapper postAccountContact(
    AccountContactWrapper information
  ) {
    Account acc = new Account(
      name = information.acc_Name,
      Industry = information.acc_Industry,
      Rating = information.acc_Rating,
      SLA__c = information.acc_SLA
    );
    Contact con = new Contact(
      lastname = information.con_LastName,
      FirstName = information.con_FirstName
    );
    responseWrapper wrapper = new responseWrapper();
    try {
      insert acc;
      con.AccountId = acc.Id;
      insert con;
      wrapper.accId = acc.Id;
      wrapper.conId = con.Id;
      wrapper.message = 'Account and Contact Created Successfully';
      return wrapper;
    } catch (Exception ex) {
      wrapper.accId = '';
      wrapper.conId = '';
      wrapper.message = ex.getMessage();
      return wrapper;
    }
  }

  /**
    {
    "information" :{
        
            "acc_Name" :"Account Name from Rest Service",
            "acc_Rating" : "Hot",
            "acc_Industry" : "Energy",
            "acc_SLA" : "Platinum",
            "con_LastName" : "JSON",
            "con_FirstName" : "Contact"  
    }
}
   */

  @httpdelete
  global static String deleteAccount() {
    Map<String, String> paramsMap = RestContext.request.params;
    String accountId = paramsMap.get('id');

    List<Account> accList = [SELECT id FROM Account WHERE id = :accountId];
    try {
      delete accList;
      return 'Account deleted Successfully';
    } catch (Exception ex) {
      return ex.getMessage();
    }
  }

  global class AccountWrapper {
    global List<Account> accList;
    global List<Contact> conList;
    global List<Case> caseList;
  }

  global class AccountInformation {
    global Account accountRecord { get; set; }
    global Contact contactRecord { get; set; }
  }

  global class AccountContactWrapper {
    global string acc_Name { get; set; }
    global string acc_Rating { get; set; }
    global string acc_Industry { get; set; }
    global string acc_SLA { get; set; }
    global string con_LastName { get; set; }
    global string con_FirstName { get; set; }
  }

  global class responseWrapper {
    global String accId;
    global String conId;
    global String message;
  }

  //get accountId from URL

  // update the rating of that account as Hot

  //return wrapper :
  //Account Record
  //Message - Account Updated Successfully
}
