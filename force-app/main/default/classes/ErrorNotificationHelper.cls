public with sharing class ErrorNotificationHelper {
  public static void afterInsert(List<Error_Notification__e> errorList) {
    List<Error_Log__c> errLogList = new List<Error_Log__c>();
    for (Error_Notification__e err : errorList) {
      Error_Log__c errorLog = new Error_Log__c();
      errorLog.Error_Class__c = err.Class_Name__c;
      errorLog.Error_Message__c = err.Error_Message__c;
      errLogList.add(errorLog);
    }
    if (!errLogList.isEmpty()) {
      try {
        insert errLogList;
      } catch (Exception ex) {
        System.debug('Error in Exception writing ' + ex.getMessage());
      }
    }
  }
}
