public with sharing class InvocableApexHelloMessage {
  @InvocableMethod(
    label='Welcome Text'
    description='Welcome Message from Apex'
    category='Welcome'
  )
  public static List<String> welcomeMessage() {
    List<String> welcomeList = new List<String>();
    welcomeList.add('Welcome from Apex Programming');
    return welcomeList;
  }
}
