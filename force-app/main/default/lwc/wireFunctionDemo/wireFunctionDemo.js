import { LightningElement, wire } from "lwc";
import getTopAccounts from "@salesforce/apex/AccontHelper.getTopAccounts";
export default class WireFunctionDemo extends LightningElement {
  //whenever rating is blank --> replace blank value with the Warm
  accountData;
  accountError;
  columns = [
    { label: "Account Name", fieldName: "Name" },
    { label: "Account Industry", fieldName: "Industry" },
    { label: "Account Rating", fieldName: "Rating" }
  ];
  @wire(getTopAccounts) topAccountHandler({ data, error }) {
    if (data) {
      console.log("topAccountHandler data", data);
      let outputArray = [];
      data.map((currItem) => {
        if (!currItem.hasOwnProperty("Rating")) {
          let processItem = { ...currItem };
          processItem["Rating"] = "Warm";
          outputArray = [...outputArray, processItem];
        } else {
          outputArray = [...outputArray, { ...currItem }];
        }
      });
      console.log("outputArray data", outputArray);
      this.accountData = [...outputArray];
      this.accountError = null;
    } else if (error) {
      console.log("topAccountHandler error", error);
      this.accountError = error;
      this.accountData = null;
    }
  }
}
