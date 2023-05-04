public with sharing class ExceptionDemo {
  public static void dmlExceptionDemo() {
    Account acc = new Account();
    try {
      insert acc;
      System.debug('Account Created Successfully');
    } catch (DmlException ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } catch (Exception ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } finally {
      System.debug('Finally Block Executed');
    }
  }

  public static void nullPointerException() {
    String myName; //null
    // if(myName != '' || myName != null){
    //dont check for blank and null like this
    // }
    // if(String.isNotBlank(myName)){
    //     String lownerCaseName = myName.toLowerCase();
    // }

    try {
      String lownerCaseName = myName.toLowerCase();
    } catch (NullPointerException ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } catch (Exception ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } finally {
      System.debug('Finally Block Executed');
    }
  }

  public static void sObjectExceptionDemo() {
    List<Account> accList = [SELECT id, Name FROM Account LIMIT 5];
    try {
      for (Account acc : accList) {
        String accIndustry = acc.Industry;
      }
    } catch (SObjectException ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } catch (Exception ex) {
      System.debug('getCause ' + ex.getCause());
      System.debug('getLineNumber ' + ex.getLineNumber());
      System.debug('getMessage ' + ex.getMessage());
      System.debug('getTypeName ' + ex.getTypeName());
    } finally {
      System.debug('Finally Block Executed');
    }
  }

  public static void queryExceptionDemo1(String conEmail) {

    // Contact con = [select id,lastname,email from contact where email = :conEmail];
    // System.debug('con ' + con);

    //If no record is prensent with then entered email address : 
    //System.QueryException: List has no rows for assignment to SObject

    List<Contact> con = [select id,lastname,email from contact where email = :conEmail];
    System.debug('con ' + con);

  }

  public static void queryExceptionDemo2(String conEmail) {

    // Contact con = [select id,lastname,email from contact where email = :conEmail];
    // System.debug('con ' + con);

    //if more than one record is present for entered email address
    //System.QueryException: List has more than 1 row for assignment to SObject

    // User usr = [select id ,lastname from user where id = :UserInfo.getUserId()];

    List<Contact> con = [select id,lastname,email from contact where email = :conEmail];
    System.debug('con ' + con);

  }
}
