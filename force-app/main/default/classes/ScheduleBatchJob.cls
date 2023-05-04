public with sharing class ScheduleBatchJob implements Schedulable {
  public void execute(SchedulableContext context) {
    Database.executeBatch(new BatchApexDemo(), 100);
  }
}
