import { LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";
export default class NavigationDemo extends NavigationMixin(LightningElement) {
  homeNavigation(event) {
    //create the pageReference

    let pageRef = {
      type: "standard__namedPage",
      attributes: {
        pageName: "home"
      }
    };

    //Navigate method
    this[NavigationMixin.Navigate](pageRef);
  }

  accountHomeNavigation(event) {
    let pageRef = {
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "home"
      }
    };

    //Navigate method
    this[NavigationMixin.Navigate](pageRef);
  }

  accountListViewNavigation(event) {
    let pageRef = {
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "list"
      },
      state: {
        filterName: "PlatinumandGoldSLACustomers"
      }
    };

    //Navigate method
    this[NavigationMixin.Navigate](pageRef);
  }

  createNewAccount() {
    let pageRef = {
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "new"
      }
    };

    //Navigate method
    this[NavigationMixin.Navigate](pageRef);
  }

  createNewAccountWithDefaultValues() {
    const defaultValues = encodeDefaultFieldValues({
      Rating: "Hot",
      Phone: "798798798797",
      Industry: "Energy"
    });
    let pageRef = {
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Account",
        actionName: "new"
      },
      state: {
        defaultFieldValues: defaultValues
      }
    };

    //Navigate method
    this[NavigationMixin.Navigate](pageRef);
  }
}
