import { LightningElement, wire } from "lwc";
import getAccountsByIndustry from "@salesforce/apex/AccontHelper.getAccountsByIndustry";
export default class WireDecoratorWithParam extends LightningElement {
  accountIndustry = "";

  columns = [
    { label: "Account Name", fieldName: "Name" },
    { label: "Account Industry", fieldName: "Industry" },
    { label: "Account Rating", fieldName: "Rating" }
  ];

  @wire(getAccountsByIndustry, {
    accindustry: "$accountIndustry"
  })
  accounts;

  changeHandler(event) {
    this.accountIndustry = event.target.value;
  }
}
