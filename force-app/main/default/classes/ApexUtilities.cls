public with sharing class ApexUtilities {
  public static void userInfoDemo() {
    System.debug('Username value' + UserInfo.getUserName());
    System.debug('User Id ' + UserInfo.getUserId());
    System.debug('User Email ' + UserInfo.getUserEmail());
    System.debug('User ProfileId ' + UserInfo.getProfileId());
    //Profile profileRec = [select id,Name from Profile where id = :UserInfo.getProfileId() with USER_MODE];
    String profileName = [
      SELECT id, Name, Industry, Rating, AnnaulRevenue
      FROM Profile
      WHERE id = :UserInfo.getProfileId()
      WITH USER_MODE
    ]
    .Name;
    System.debug('Profile Name ' + profileName);
  }

  public static void customMetadataDemo() {
    Map<String, Discount_Information__mdt> discountInformation = Discount_Information__mdt.getAll();
    System.debug('discountInformation keys' + discountInformation.keyset());
    System.debug('discountInformation values ' + discountInformation.values());

    Discount_Information__mdt platinumRec = Discount_Information__mdt.getInstance(
      'Platinum'
    );
    System.debug('platinumRec ' + platinumRec);

    for (Discount_Information__mdt discountInfo : [
      SELECT id, DeveloperName, MasterLabel, Discount_Percentage__c
      FROM Discount_Information__mdt
    ]) {
      System.debug('SOQL Output ' + discountInfo);
    }
  }

  public static void customSettingDemo() {
    Contact_Details__c orgDetail = Contact_Details__c.getOrgDefaults();

    System.debug('orgDetail  ' + orgDetail);

    Contact_Details__c profileDetail = Contact_Details__c.getInstance(
      UserInfo.getProfileId()
    );

    System.debug('profileDetail  ' + profileDetail);
  }
}
