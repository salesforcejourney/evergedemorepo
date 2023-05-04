public with sharing class DMLStatementDemo {
  public static void createSingleRecord() {
    //      Account acc = new Account(name='Test Account demo',Industry = 'Energy',Rating='Hot',AnnualRevenue='500000');
    Account acc = new Account();
    acc.Name = 'Test Account demo 1';
    acc.Industry = 'Energy';
    acc.Rating = 'Hot';
    acc.AnnualRevenue = 500000;

    try {
      insert as user acc;
      System.debug('Account Id ' + acc.Id);
    } catch (DMLException ex) {
      system.debug('Error message ' + ex.getMessage());
    } catch (Exception ex) {
      system.debug('Error message ' + ex.getMessage());
    }
  }

  public static void multipleRecords(){
    List<Account> accList = new List<Account>(); 
    Account acc1 = new Account(name = 'Test Account 1', Industry = 'Energy' , Rating = 'Warm');
    Account acc2 = new Account(name = 'Test Account 2', Industry = 'Banking' , Rating = 'Hot');
    Account acc3 = new Account(name = 'Test Account 3', Industry = 'Appreal' , Rating = 'Warm');
    Account acc4 = new Account(name = 'Test Account 4', Industry = 'Energy' , Rating = 'Hot');

    accList.add(acc1);
    accList.add(acc2);
    accList.add(acc3);
    accList.add(acc4);
   
    if(!accList.isEmpty()){
        try {
            insert as user accList;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
  }

  public static void dmlOnRelatedRecord(){
    //Create the account and create the contact and also relate that account with the contact. 
    Account acc5 = new Account(name = 'Test Account 5', Industry = 'Energy' , Rating = 'Hot');

    try {
        insert as user acc5;
        System.debug('Account record id ' + acc5.Id);
    } catch (DMLException ex) {
        system.debug('Error message ' + ex.getMessage());
      } catch (Exception ex) {
        system.debug('Error message ' + ex.getMessage());
      }

      Contact con1 = new Contact(lastname = 'Contact for Test Account 5', email = 'testcontact@test.com' , Phone= '12122121', AccountId = acc5.Id);
      try {
        insert as user con1;
        System.debug('Contact record id ' + con1.Id);
    } catch (DMLException ex) {
        system.debug('Error message ' + ex.getMessage());
      } catch (Exception ex) {
        system.debug('Error message ' + ex.getMessage());
      }

  }

  //for existing contact who does not have email , populate the default email address - 'default@email.com'

  public static void updateContactRecords(){
    //1. Get the records
    List<Contact> conList = [select lastname,email from contact where email = null with USER_MODE];

    //iterate the records and populate the default email
    for(Contact con : conList){
        con.email = 'default@email.com';
    }

    System.debug('conList ' + conList);
    //update operation
    try {
        update as user conList;

    } catch (DMLException ex) {
        system.debug('Error message ' + ex.getMessage());
      } catch (Exception ex) {
        system.debug('Error message ' + ex.getMessage());
      }
  }

  //input : email (contact) , update related account industry as Energy  
  public static void updateChildToParentRelatedRecord(String conEmail){
    Set<Id> accountIds = new Set<Id>();
    List<Contact> conList = [select id,lastname,email,Account.Id,Account.Name,Account.Industry from contact where email = :conEmail];
    
    for(Contact con : conList){
        accountIds.add(con.Account.Id);
        //bad practice
    }

    List<Account> accList = [select id,Industry from account where id in :accountIds];

    for(Account acc : accList){
        acc.Industry = 'Energy';
    }

    if(!accList.isEmpty()){
        try {
            update as user accList;

        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }

}

//input : email (contact) , update related cases as closed
public static void updateParentToChildRelatedRecord(String conEmail){
    List<Case> masterCaseList = new List<Case>();
    List<Contact> conList = [select id,lastname,email,(select Id,status ,subject from cases) from contact where email = :conEmail];
    for(Contact con : conList){
        List<Case> caseList = con.cases;
        masterCaseList.addAll(caseList);
    }
    for(Case caseRec : masterCaseList){
        caseRec.Status = 'Closed';
    }

    if(!masterCaseList.isEmpty()){
        try {
            update as user masterCaseList;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
}

//upsert : update + insert (recordId)

public static void upsertOnAccounts(){

    //update the existing account rating as Hot where industry is Energy
    List<Account> accList = [select id,name,rating from account where industry = 'Energy' and Rating != 'Hot' with USER_MODE];
    for(Account acc : accList){
        acc.Rating = 'Hot';
    }
    System.debug('accList ' + accList);

    //update accList;
    //create the new account

    Account acc = new Account(Name = 'Test Account 6',Industry = 'Appreal' , Rating = 'Warm');

    //insert acc;

    accList.add(acc);

    System.debug('accList with new account ' + accList);

    if(!accList.isEmpty()){
        try {
            upsert as user accList ;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
    }

public static void upsertBasedonUniqueField(){
    Contact con1 = new Contact(lastname = 'Test Contact 1 ' , email = 'jrogers@burlington.com', phone = '1123123123');
    Contact con2 = new Contact(lastname = 'Test Contact 2 ' , email = 'testcontact2@test.com', phone = '1123123123');
    List<Contact> conList = new List<Contact>{con1,con2};
    if(!conList.isEmpty()){
        try {
            upsert as user conList email;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
}

//delete all records which are having default email address
@TestVisible private static void deleteRecords(String conEmail){
   List<Case> masterCaseList = new List<Case>();
    
   List<Contact> conList = [select id,(select id from cases) from contact where email = :conEmail with USER_MODE];
   System.debug('before conList ' + conList); 
   for(Contact con : conList){
        List<Case> caseList = con.cases;
        masterCaseList.addAll(caseList);
    }

    if(masterCaseList.size() > 0){
        try{
            delete as user masterCaseList;
        }catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
    System.debug('after conList ' + conList); 
    if(conList.size() > 0){
        try {
            delete as user conList;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
}

public static void undeleteRecords(String conEmail){

    List<Contact> conList = [select id from Contact where email = :conEmail ALL ROWS ];
    if(!conList.isEmpty()){
        try {
            undelete as user conList;
        } catch (DMLException ex) {
            system.debug('Error message ' + ex.getMessage());
          } catch (Exception ex) {
            system.debug('Error message ' + ex.getMessage());
          }
    }
}
}


