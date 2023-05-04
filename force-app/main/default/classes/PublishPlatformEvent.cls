public with sharing class PublishPlatformEvent {
  public static void createContact() {
    contact con = new contact();
    try {
      insert con;
    } catch (Exception ex) {
      //publish a platform event
      Error_Notification__e errorNotification = new Error_Notification__e();
      errorNotification.Class_Name__c = 'PublishPlatformEvent';
      errorNotification.Error_Message__c = ex.getMessage();
      Database.SaveResult sr = Eventbus.publish(errorNotification);

      if (sr.isSuccess()) {
        system.debug('Success');
      } else {
        for (Database.Error err : sr.getErrors()) {
          system.debug('err ' + err.getMessage() + '--' + err.getFields());
        }
      }
    }
  }
}
