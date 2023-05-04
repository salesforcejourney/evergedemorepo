public with sharing class loopingDemo {
  public static void traditionalForLoop() {
    //ordered collection -- Duplicate values
    //Declared the list
    List<String> studentList = new List<String>();
    List<String> additionalStudentList = new List<String>{ 'Suresh', 'Ramesh' };
    List<Account> accList = new List<Account>();

    //add the element in list
    studentList.add('Ankit');
    studentList.add('Amit');
    studentList.add('Kiran');
    studentList.add('Raju');
    studentList.add('Ankit');
    studentList.add(2, 'Sanjay');
    studentList.addAll(additionalStudentList);
    System.debug('studentList ' + studentList);
    Integer studentListSize = studentList.size();

    for (integer i = 0; i < studentListSize; i++) {
      System.debug(studentList[i] + ' ' + studentList.get(i));
    }
  }

  public static void apexForLoop() {
    //ordered collection -- Duplicate values
    //Declared the list
    List<String> studentList = new List<String>();
    List<String> additionalStudentList = new List<String>{ 'Suresh', 'Ramesh' };
    List<Account> accList = new List<Account>();

    //add the element in list
    studentList.add('Ankit');
    studentList.add('Amit');
    studentList.add('Kiran');
    studentList.add('Raju');
    studentList.add('Ankit');
    studentList.add(2, 'Sanjay');
    studentList.addAll(additionalStudentList);
    System.debug('studentList ' + studentList);

    for (String studentName : studentList) {
      System.debug('studentName - ' + studentName);
    }
  }

  public static void forSoqlLoop(String accIndustry) {
    for (Account acc : [
      SELECT id, Name, Industry, Rating
      FROM Account
      WHERE Industry = :accIndustry
      WITH USER_MODE
    ]) {
      System.debug(acc.Name);
    }
  }
}
