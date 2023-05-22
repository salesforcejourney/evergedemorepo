import { LightningElement, wire } from "lwc";
import getTopAccounts from "@salesforce/apex/AccontHelper.getTopAccounts";
import { deleteRecord } from "lightning/uiRecordApi";
import { refreshApex } from "@salesforce/apex";
export default class RefreshApexDemo extends LightningElement {
  selectedRecordId;
  accountsProp;
  accountData;
  accountError;
  columns = [
    { label: "Name", fieldName: "Name" },
    { label: "Industry", fieldName: "Industry" },
    { label: "Rating", fieldName: "Rating" }
  ];
  //   @wire(getTopAccounts) accounts;

  @wire(getTopAccounts) accountsFunction(response) {
    this.accountsProp = response;
    let { data, error } = response;
    if (data) {
      this.accountData = data;
      this.accountError = null;
    } else if (error) {
      this.accountError = error;
      this.accountData = null;
    }
  }

  handleSelection(event) {
    let selectedRows = [];
    selectedRows = event.detail.selectedRows;
    if (selectedRows.length > 0) {
      this.selectedRecordId = selectedRows[0].Id;
    }
  }

  deleteHandler() {
    deleteRecord(this.selectedRecordId)
      .then(() => {
        console.log("Record Deleted Successfully");
        //refreshApex(this.accounts);
        refreshApex(this.accountsProp);
      })
      .catch(() => {
        console.log("Failure in record deletion");
      });
  }
}
