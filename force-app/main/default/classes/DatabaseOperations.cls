public with sharing class DatabaseOperations {
  public static void dmlStatementAtomicOperation() {
    Contact con1 = new Contact(lastname = 'Test Contact 3');
    Contact con2 = new Contact(lastname = 'Test Contact 4');
    Contact con3 = new Contact(); //bad record
    Contact con4 = new Contact(lastname = 'Test Contact 5');
    List<Contact> conList = new List<Contact>{ con1, con2, con3, con4 };
    try {
      insert as user conList;
    } catch (Exception ex) {
      System.debug('Error message ' + ex.getMessage());
    }
  }

  public static void databaseInsert(){
    // database.insert(sobject);
    // database.update();
    // database.delete();
    // database.undelete();
    // database.upsert();
    //allOrNothing : Boolean : true or false
    //true --> it will work same as DML statement
    //false --> it will ignore bad record and process good record

    Contact con1 = new Contact(lastname = 'Test Contact 3');
    Contact con2 = new Contact(lastname = 'Test Contact 4');
    Contact con3 = new Contact(); //bad record
    Contact con4 = new Contact(lastname = 'Test Contact 5');
    List<Contact> conList = new List<Contact>{ con1, con2, con3, con4 };
    if(!conList.isEmpty()){
        List<Database.SaveResult> srList =  database.insert(conList, false,AccessLevel.USER_MODE);
        
        for(Database.SaveResult sr : srList){
            if(sr.isSuccess()){
                system.debug('Record Created ' + sr.getId());
            }else{
                List<Database.Error> errList = sr.getErrors();
                for(Database.Error err : errList){
                    System.debug('Error Record ' + err.getFields() + ' -- ' + err.getMessage());
                }
            }
        }
    }
  }
}
