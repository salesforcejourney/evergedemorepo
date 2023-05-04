global with sharing class SOAPServiceDemo {
    webservice static String fullname(String firstname,String lastname){
        return 'Welcome ' + firstname +  ' ' + lastname;
    }

    webservice static String createAccount(AccountWrapper accountwrapper){
        Account acc = new Account(name = accountwrapper.Name,rating = accountwrapper.rating,Industry = accountwrapper.industry,Phone=accountwrapper.phone);
        try {
            insert acc;
            return acc.Id;
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }

    global class AccountWrapper {
        webservice String name;
        webservice String rating;
        webservice String industry;
        webservice String phone;
    }
}