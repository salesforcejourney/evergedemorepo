public with sharing class InvocableApexWithMultipleRecords {
  @InvocableMethod(
    label='Fetch Accounts'
    description='Fetch Top 10 Accounts'
    category='Welcome'
  )
  public static List<List<Account>> fetchAccounts() {
    List<List<Account>> accrecList = new List<List<Account>>();
    List<Account> accList = [
      SELECT id, name
      FROM account
      WHERE AnnualRevenue != NULL
      ORDER BY AnnualRevenue DESC
      LIMIT 10
    ];
    accrecList.add(accList);
    return accrecList;
  }
}
