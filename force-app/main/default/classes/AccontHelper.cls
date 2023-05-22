public with sharing class AccontHelper {
  @AuraEnabled(cacheable=true)
  public static List<Account> getTopAccounts() {
    List<Account> accList = [
      SELECT id, Name, Industry, Rating
      FROM Account
      WHERE AnnualRevenue != NULL
      ORDER BY AnnualRevenue DESC
    ];
    return accList;
  }

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccountsByIndustry(String accindustry) {
    List<Account> accList = new List<Account>();

    if (String.isNotEmpty(accindustry)) {
      accList = [
        SELECT id, Name, Industry, Rating
        FROM Account
        WHERE Industry = :accindustry
      ];
    }
    return accList;
  }

  @AuraEnabled(cacheable=true)
  public static List<Account> getIndustryRecords(String Industry,String Rating ) {
    List<Account> accList = new List<Account>();
    if(String.isBlank(Industry) && String.isBlank(Rating)){
    accList = [
      SELECT id, Name, Industry, Rating
      FROM Account
      WHERE Industry != NULL AND Rating !=NUll
      ORDER BY AnnualRevenue DESC
    ];

   }else{
    accList = [
      SELECT id, Name, Industry, Rating
      FROM Account
      WHERE Industry = :Industry AND Rating =:Rating
      ORDER BY AnnualRevenue DESC
    ];
   }
    return accList;
  }
}
