import { LightningElement, api } from "lwc";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class RecordEditFormDemo extends LightningElement {
  @api objectApiName;
  @api recordId;
  accountPhone;
  accountObj = {
    Name: NAME_FIELD,
    Industry: INDUSTRY_FIELD,
    Type: TYPE_FIELD,
    Rating: RATING_FIELD
  };

  changeHandler(event) {
    this.accountPhone = event.target.value;
  }

  resetHandler(event) {
    let elementsArray = Array.from(
      this.template.querySelectorAll("lightning-input-field")
    );
    elementsArray.forEach((currItem) => currItem.reset());
  }

  successHandler() {
    //Assignment : for reference : recordFormDemo component
    //show the toast message
    //navigate to new record
  }

  editsuccesshandler() {
    const toastEvent = new ShowToastEvent({
      title: "Success",
      message: "Record Updated Successfully",
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
  }

  editErrorHandler(event) {
    const toastEvent = new ShowToastEvent({
      title: "Error",
      message: event.detail.message,
      variant: "error"
    });
    this.dispatchEvent(toastEvent);
  }

  editsubmitHandler(event) {
    event.preventDefault(); //will stop the form from submit

    let isValid = this.validateInput();

    if (isValid) {
      let fields = event.detail.fields; //return all fields with values
      console.log("fields", JSON.stringify(fields));
      //Business requirement - if industry is energy and rating is not hot , autopopulate the rating as Hot
      if (fields.Industry === "Energy" && fields.Rating != "Hot") {
        fields.Rating = "Hot";
      }
      fields.Phone = this.accountPhone
        .querySelector("lightning-record-edit-form")
        .submit(fields);
    } else {
      alert("Invalid Inputs");
    }
  }

  validateInput() {
    let isValid = true;
    let accountPhoneElement = this.template.querySelector("lightning-input");
    if (!this.accountPhone) {
      accountPhoneElement.setCustomValidity(
        "Account Phone number is Mandatory"
      );
      isValid = false;
    } else {
      isValid = true;
      accountPhoneElement.setCustomValidity("");
    }
    accountPhoneElement.reportValidity();
    return isValid;
  }
}
