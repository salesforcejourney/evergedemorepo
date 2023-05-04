//Everynight at 9 PM, run one job to send an email to the contact owners for all the contacts which have not submitted the email address.

public with sharing class ScheduleApexDemo implements Schedulable {

  public void execute(SchedulableContext context){
    sendEmailToContacts();
  }

  public static void sendEmailToContacts() {
    Set<String> emailAddress = new Set<String>();

    for (Contact con : [
      SELECT id, lastname, owner.email
      FROM contact
      WHERE email = NULL
    ]) {
      emailAddress.add(con.owner.email);
    }
    //Convert set into list
    if (!emailAddress.isEmpty()) {
      List<String> toEmailList = new List<String>(emailAddress);
      List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
      
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(toEmailList);
      mail.setSubject('Alert - Email Address is not maintained for Contacts');
      mail.setPlainTextBody(
        'Could you please action on this email on priority. There are few contacts assigned to you for which email address is blank'
      );
      
      mailList.add(mail);
      Messaging.sendEmail(mailList);
    }
  }
}

/**
 * 
 String jobName = 'Submit job using CRON Expression';
String CRONExpression = '0 0 21 ? * MON,TUE,WED,THU,FRI *';
ScheduleApexDemo scheduleInstnace = new ScheduleApexDemo();
System.schedule(jobName,CRONExpression,scheduleInstnace);
 */