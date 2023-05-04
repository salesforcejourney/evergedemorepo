public with sharing class collectionDemo {
  public static void listCollectionDemo() {
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

    //size of list
    System.debug('studentList size ' + studentList.size());

    //check list is empty or now
    System.debug('studentList isEmpty ? ' + studentList.isEmpty());

    //check a particular entry is present in list or not : contains
    System.debug('studentList contains Raju ? ' + studentList.contains('Raju'));

    //get the values from list : we have to specify the index
    System.debug('Get Amit from List ' + studentList.get(1));
    System.debug('Get Amit from List ' + studentList[1]);

    //remove the entry from list
    String removedStudent = studentList.remove(1);
    System.debug('updated list after removal studentList ' + studentList);
    System.debug('removedStudent ' + removedStudent);

    System.debug('Index of Ankit ' + studentList.indexOf('Ankit'));
    //clear method
    studentList.clear();
    System.debug('updated list after clear studentList ' + studentList);
  }

  public static void setCollectionDemo() {
    Set<Integer> rollNoSet = new Set<Integer>();
    Set<Integer> additionalRollNo = new Set<Integer>{ 115, 120 };
    //Add the element in set
    rollNoSet.add(108);
    rollNoSet.add(105);
    rollNoSet.add(101);
    rollNoSet.add(107);
    rollNoSet.add(105);
    rollNoSet.addAll(additionalRollNo);

    System.debug('Rollnoset ' + rollNoSet);
    System.debug('Rollnoset size ' + rollNoSet.size());
    System.debug('Rollnoset isEmpty' + rollNoSet.isEmpty());
    Boolean isValueRemoved = rollNoSet.remove(107);

    System.debug('Rollnoset updated' + rollNoSet);
    System.debug('is 107 ValueRemoved ' + isValueRemoved);

    System.debug('Is set contains 105 roll no ? ' + rollNoSet.contains(105));

    List<Integer> rollNoList = new List<Integer>(rollNoSet);

    rollNoSet.clear();
    System.debug('Rollnoset cleared ' + Rollnoset);
  }

  public static void mapCollectionDemo() {
    //create student map : set of keys and list of values
    Map<Integer, String> studentDetail = new Map<Integer, String>();

    //Add values
    studentDetail.put(108, 'Sumit');
    studentDetail.put(104, 'Raju');
    studentDetail.put(105, 'Raju');
    studentDetail.put(102, 'Ankit');
    studentDetail.put(108, 'Amit');

    //108 - same roll  no : Sumit, Amit : 108 :Amit
    //104,105 - diff roll no : Raju

    System.debug('studentDetail ' + studentDetail);
    System.debug('studentDetail size ' + studentDetail.size());
    System.debug('studentDetail isEmpty() ' + studentDetail.isEmpty());

    //check 102 key is present in map
    System.debug(
      'Check 102 key is present in map ' + studentDetail.containsKey(102)
    );

    //Access the value from the map
    System.debug('Access Raju from Map ' + studentDetail.get(105));

    //Remove the entry from map
    String removedItem = studentDetail.remove(102);
    System.debug('udpated studentDetail ' + studentDetail);
    System.debug('removedItem ' + removedItem);

    //Access all the keys of the map
    System.debug('All the rollnos ' + studentDetail.keySet());

    //Access all the value of the map
    System.debug('All the student name ' + studentDetail.values());
  }
}
