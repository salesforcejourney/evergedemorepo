public with sharing class InvocableApexHelloMessageWithInput {
    @InvocableMethod(
    label='Welcome Text'
    description='Welcome Message from Apex'
    category='Welcome'
  )
  public static List<String> welcomeMessage(List<String> inputMessage) {
    List<String> welcomeList = new List<String>();
    String inputMessageString = inputMessage.get(0);
    welcomeList.add('Welcome from Apex Programming - ' + inputMessageString);
    return welcomeList;
  }
}