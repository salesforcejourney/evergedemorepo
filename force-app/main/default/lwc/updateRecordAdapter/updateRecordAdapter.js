import { LightningElement, api, wire } from "lwc";
import {
  deleteRecord,
  getFieldValue,
  getRecord,
  updateRecord
} from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_ID from "@salesforce/schema/Account.Id";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
export default class UpdateRecordAdapter extends NavigationMixin(
  LightningElement
) {
  @api recordId;
  accountName;

  @wire(getRecord, { recordId: "$recordId", fields: ACCOUNT_NAME })
  accountRecordHandler({ data, error }) {
    if (data) {
      console.log("accountRecordHandler data", data);
      this.accountName = getFieldValue(data, ACCOUNT_NAME);
    } else if (error) {
      console.log("accountRecordHandler error", error);
    }
  }

  changeHandler(event) {
    this.accountName = event.target.value;
  }

  clickHanlder(event) {
    let accField = {};
    accField[ACCOUNT_ID.fieldApiName] = this.recordId; //mandatory field to populate
    accField[ACCOUNT_NAME.fieldApiName] = this.accountName;
    let recordInput = { fields: accField };
    updateRecord(recordInput)
      .then((data) => {
        //validateData() //assignment
        console.log("contact updated successfully", data);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Record Updated Successfully",
            variant: "success"
          })
        );
      })
      .catch((error) => {
        console.log("Failure in update record", error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: error.message,
            variant: "error"
          })
        );
      });
  }

  deleteHanlder(event) {
    deleteRecord(this.recordId)
      .then(() => {
        console.log("Record Deleted Successfully");
        let pageRef = {
          type: "standard__objectPage",
          attributes: {
            objectApiName: ACCOUNT_OBJECT.objectApiName,
            actionName: "list"
          },
          state: {
            filterName: "Recent"
          }
        };
        this[NavigationMixin.Navigate](pageRef);
      })
      .catch((error) => {
        console.log("Error in delete operation", error);
      });
  }
}
