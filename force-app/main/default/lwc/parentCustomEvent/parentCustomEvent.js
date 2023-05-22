import { LightningElement, wire } from "lwc";
import getTopAccounts from "@salesforce/apex/AccontHelper.getTopAccounts";
export default class ParentCustomEvent extends LightningElement {
  @wire(getTopAccounts) accounts;
  selectedAccount;
  selectHandler(event) {
    let accountId = event.detail;
    this.selectedAccount = this.accounts.data.find(
      (currItem) => currItem.Id === accountId
    );
  }
}
