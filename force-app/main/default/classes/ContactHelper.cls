public with sharing class ContactHelper {
  @AuraEnabled
  public static String updateContact(
    String contactId,
    String contactFname,
    String contactLname,
    String contactEmail
  ) {
    Contact con = [
      SELECT Firstname, lastname, email
      FROM contact
      WHERE Id = :contactId
    ];
    con.Firstname = contactFname;
    con.Lastname = contactLname;
    con.Email = contactEmail;
    try {
      update con;
      return 'Contact Updated Successfully';
    } catch (Exception ex) {
      System.debug('Contact Updated Failed ' + ex.getMessage());
      return ex.getMessage();
    }
  }
}
