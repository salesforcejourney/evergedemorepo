import { LightningElement } from "lwc";
import getTopAccounts from "@salesforce/apex/AccontHelper.getTopAccounts";
import getAccountsByIndustry from "@salesforce/apex/AccontHelper.getAccountsByIndustry";
export default class ImperativeApexDemo extends LightningElement {
  accountData;
  accountError;
  inputaccIndustry;
  accountSearchData;
  accountSearchError;
  columns = [
    { label: "Name", fieldName: "Name" },
    { label: "Account Industry", fieldName: "Industry" },
    { label: "Account Rating", fieldName: "Rating" }
  ];
  loadHandler() {
    getTopAccounts()
      .then((result) => {
        //console.log("getTopAccounts result", result);
        this.accountData = result;
        this.accountError = null;
      })
      .catch((error) => {
        //console.log("getTopAccounts error", error);
        this.accountData = null;
        this.accountError = error;
      });
  }

  changeHandler(event) {
    this.inputaccIndustry = event.target.value;
  }

  searchHandler(event) {
    getAccountsByIndustry({
      accindustry: this.inputaccIndustry
    })
      .then((result) => {
        console.log("getAccountsByIndustry result", result);
        this.accountSearchData = result;
        this.accountSearchError = null;
      })
      .catch((error) => {
        console.log("getAccountsByIndustry error", error);
        this.accountSearchData = null;
        this.accountSearchError = error;
      });
  }
}
