public with sharing class InvokeApexWithMultipleInputOutput {

    @InvocableMethod(label='Welcome with Multiple Parameters' description='Welcome Message with Additional Details' category='Welcome')
    public static List<outputResource> welcomeMessage(List<inputResource> inputResourceList) {
        List<outputResource> outputresourceList = new List<outputResource>();
        inputResource inputRsc = inputResourceList.get(0);
        outputResource outputRsc = new outputResource();
        outputRsc.formaatedMessage = 'Your Name is ' + inputRsc.name + ' with age as ' + inputRsc.age + ' and place is ' + inputRsc.place;
        outputRsc.additionalDetails = UserInfo.getUserName();
        outputresourceList.add(outputRsc);
        return outputresourceList;
    }

    public class inputResource{
        @InvocableVariable(label='Enter Name' description = 'Enter your Name' required='true')
        public string name;
        @InvocableVariable(label='Enter Age' description = 'Enter your Age' required='true')
        public Integer age;
        @InvocableVariable(label='Enter Place' description = 'Enter your Place')
        public string place;
    }

    public class outputResource{
        @InvocableVariable(label='Formatted Message' description = 'Detailed Message')
        public string formaatedMessage;
        @InvocableVariable(label='Additional Details' description = 'Additional Details')
        public String additionalDetails;
    }
}