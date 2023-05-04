trigger SubscribePlatformEvent on Error_Notification__e(after insert) {
  System.debug('In  trigger file');
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      ErrorNotificationHelper.afterInsert(Trigger.new);
    }
  }
}
