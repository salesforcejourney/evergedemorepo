public with sharing class futureDemo {
  public static void createAccountUpdateUser() {
    createAccount();
    updateUserProfile();
  }

  //nonsetup object
  public static void createAccount() {
    Account acc = new Account(name = 'future demo');
    insert acc;
  }

  //setup object
  @future
  public static void updateUserProfile() {
    List<User> userList = [
      SELECT id, profileId
      FROM user
      WHERE username = 'testdemoeverge@test.com'
    ];
    Profile userProfile = [
      SELECT id, Name
      FROM Profile
      WHERE Name = 'System Administrator'
    ];
    for (User usr : userList) {
      usr.ProfileId = userProfile.Id;
    }
    if (!userList.isEmpty()) {
      update userList;
    }
  }
}