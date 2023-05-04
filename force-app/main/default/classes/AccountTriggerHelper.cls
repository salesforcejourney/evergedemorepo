public with sharing class AccountTriggerHelper {
  public static void beforeInsert(List<Account> newAccountList) {
    User userRec = [select id,profile.Name from user where id = :userInfo.getUserId()];
    for (Account acc : newAccountList) {
      if (acc.AnnualRevenue > 2000000 && String.IsNotBlank(acc.Industry)) {
        acc.Rating = 'Hot';
      }
      if(acc.AnnualRevenue > 5000000 && acc.Rating == 'Hot'){
        if(userRec.Profile.Name == 'Standard User'){
          acc.SLA__c = 'Platinum';
        }else{
          acc.SLA__c = 'Gold';
        }
      }
    }
    validateAccountRatingWithRevenue(newAccountList);
  }

  public static void beforeUpdate(
    List<Account> newAccountList,
    Map<Id, Account> oldAccountMap
  ) {
    for (Account newAccount : newAccountList) {
      String newPhoneNumber = newAccount.phone;

      Account oldAccount = oldAccountMap.get(newAccount.Id);
      String oldPhoneNumber = oldAccount.Phone;

      if (newPhoneNumber != oldPhoneNumber) {
        newAccount.Description =
          'Old Phone Number ' +
          oldPhoneNumber +
          ' new phone number ' +
          newPhoneNumber +
          ' update by ' +
          UserInfo.getFirstName() +
          ' ' +
          UserInfo.getLastName();
      }
    }
    validateAccountRatingWithRevenue(newAccountList);
  }

  public static void validateAccountRatingWithRevenue(
    List<Account> newAccountList
  ) {
    for (Account acc : newAccountList) {
      if (acc.Rating == 'Hot' && acc.AnnualRevenue <= 0) {
        acc.addError('Annual revenue for Hot Rating is Mandatory');
      }
    }
  }

  public static void afterUpdate(
    List<Account> newAccountList,
    Map<Id, Account> oldAccountMap
  ) {
    
    Map<Id,String> accountIdPhoneMap = new Map<Id,String>();
    for (Account acc : newAccountList) {
      if (acc.phone != oldAccountMap.get(acc.Id).Phone) {
        accountIdPhoneMap.put(acc.Id,acc.Phone);
        // List<Contact> conList = [
        //   SELECT id, lastname
        //   FROM contact
        //   WHERE accountId = :acc.Id
        // ];
      }
    }

    List<Contact> conList = [select id,lastname,accountId from Contact where accountId in :accountIdPhoneMap.keySet()];
    for(Contact con : conList){
      con.Phone = accountIdPhoneMap.get(con.AccountId);
    }

    if(!conList.isEmpty()){
      try {
        update as user conList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
    
    if(!accountIdPhoneMap.isEmpty()){
      phoneValidator(accountIdPhoneMap);
    }
  }

  public static void afterInsert(List<Account> newAccList){
    List<Case> caseList = new List<Case>();
    for(Account acc : newAccList){
      if(acc.SLA__c == 'Platinum'){
        Case newCase = new Case();
        newCase.Status = 'New';
        newCase.Priority = 'High';
        newCase.Subject = 'This Case is created for Platinum Account - ' +  acc.Name;
        newCase.AccountId = acc.Id;
        newCase.OwnerId = acc.OwnerId;
        caseList.add(newCase);
        //insert as user newCase; --> Bad Practice
      }
      if(!caseList.isEmpty()){
        try {
          insert as user caseList;
        } catch (Exception ex) {
          System.debug('Error Message ' + ex.getMessage());
        }
      }
    }

  }

  @future(callout=true)
  public static void phoneValidator(Map<Id,String> accountIdPhoneMap){

    Map<Id,Boolean> phoneValidDetails = new Map<Id,Boolean>();
    for(Id accountId : accountIdPhoneMap.keySet()){
      String Phone = accountIdPhoneMap.get(accountId);
      
      String endpoint = System.Label.NumVerifyUrl + '?access_key=' + System.label.NumverifyKey + '&number=' + Phone + '&country_code=IN&format=1';
      
      System.debug('endpoint ' + endpoint);
      
      //1. Create the HTTP instance
      Http http = new Http();

      //2. Create the instance of HTTP request
      HttpRequest request = new HttpRequest();

      //3. Set the request - endpoint (URI) , method , headers, body
      request.setEndpoint(endpoint);
      request.setMethod('GET');
      request.setHeader('Content-Type', 'application/json');
      request.setTimeout(12000);

      //Send the request and capture the response
      HttpResponse response = http.send(request);

      System.debug('response code ' + response.getStatusCode());
      System.debug('response Status ' + response.getStatus());
      System.debug( 'Response output ' + response.getBody() );

      if(response.getStatusCode() == 200){
        NumverifyResponse numresponse =  NumverifyResponse.parse(response.getBody());
        phoneValidDetails.put(accountId,numresponse.valid);
      }else{
        System.debug('Error on phone validation ' + response.getBody());
      }
    }

    List<Account> accList = [select id,Is_Phone_Valid__c from Account where id in :phoneValidDetails.keySet()];
   
    for(Account acc : accList){
      acc.Is_Phone_Valid__c = phoneValidDetails.get(acc.Id);
    }

    if(!accList.isEmpty()){
      try {
        update accList;
      } catch (Exception ex) {
        System.debug('Error message ' + ex.getMessage());
      }
    }
  }
}
