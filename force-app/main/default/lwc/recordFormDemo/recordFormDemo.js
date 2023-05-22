import { LightningElement, api } from "lwc";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
export default class RecordFormDemo extends NavigationMixin(LightningElement) {
  @api objectApiName;
  @api recordId;
  accObject = ACCOUNT_OBJECT;
  fieldList = [NAME_FIELD, INDUSTRY_FIELD, TYPE_FIELD, RATING_FIELD];

  successHandler(event) {
    //1. show the message

    const successevent = new ShowToastEvent({
      title: "Success",
      message: "Record Created Successfully",
      variant: "success"
    });
    this.dispatchEvent(successevent);

    //2. Navigation
    //create page reference
    let pageRef = {
      type: "standard__recordPage",
      attributes: {
        recordId: event.detail.id,
        objectApiName: "Account",
        actionName: "view"
      }
    };
    this[NavigationMixin.Navigate](pageRef);
  }

  errorHandler(event) {
    const errorevent = new ShowToastEvent({
      title: "Error",
      message: event.detail.message,
      variant: "success"
    });
    this.dispatchEvent(errorevent);
  }
}
