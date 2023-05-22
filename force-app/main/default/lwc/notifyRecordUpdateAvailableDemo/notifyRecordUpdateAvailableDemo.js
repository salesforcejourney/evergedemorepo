import { LightningElement, api, wire } from "lwc";
import {
  getFieldValue,
  getRecord,
  notifyRecordUpdateAvailable
} from "lightning/uiRecordApi";
import FirstName from "@salesforce/schema/Contact.FirstName";
import LastName from "@salesforce/schema/Contact.LastName";
import Email from "@salesforce/schema/Contact.Email";
import updateContact from "@salesforce/apex/ContactHelper.updateContact";
export default class NotifyRecordUpdateAvailableDemo extends LightningElement {
  @api recordId;
  firstname;
  lastname;
  email;
  @wire(getRecord, {
    recordId: "$recordId",
    fields: [FirstName, LastName, Email]
  })
  getRecordHandler({ data, error }) {
    if (data) {
      this.firstname = getFieldValue(data, FirstName);
      this.lastname = getFieldValue(data, LastName);
      this.email = getFieldValue(data, Email);
    } else if (error) {
      console.log("Error in getRecord ", email);
    }
  }

  changeHandler(event) {
    let { name, value } = event.target;
    if (name === "fname") this.firstname = value;
    if (name === "lname") this.lastname = value;
    if (name === "email") this.email = value;
  }

  updateHandler(event) {
    //imperative Apex
    updateContact({
      contactId: this.recordId,
      contactFname: this.firstname,
      contactLname: this.lastname,
      contactEmail: this.email
    })
      .then((result) => {
        console.log("updateContact result ", result);
        notifyRecordUpdateAvailable([
          {
            recordId: this.recordId
          }
        ]);
      })
      .catch((error) => {
        console.log("updateContact Error", error);
      });
  }
}
