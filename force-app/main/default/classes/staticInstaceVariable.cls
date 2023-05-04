public with sharing class staticInstaceVariable {
  public static String staticVariable = 'I am static variable';
  public String instanceVariable = 'I am instace variable';

  public static void staticMethodDemo() {
    System.debug('Static Method');
  }

  public void instanceMethodDemo() {
    System.debug('Instance Method');
  }
}
