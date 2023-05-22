import {
  getObjectInfo,
  getPicklistValues,
  getPicklistValuesByRecordType
} from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import filter from "@salesforce/messageChannel/filter__c";
import { publish, MessageContext } from "lightning/messageService";

export default class SearchComponent extends LightningElement {
  industryOptions;
  ratingOptions;
  industryvalue;
  ratingvalue;

  @wire(MessageContext) context;

  @wire(getObjectInfo, {
    objectApiName: ACCOUNT_OBJECT
  })
  accounts;

  @wire(getPicklistValuesByRecordType, {
    objectApiName: ACCOUNT_OBJECT,
    recordTypeId: "$accounts.data.defaultRecordTypeId"
  })
  getPickListHandler({ data, error }) {
    if (data) {
      this.ratingOptions = data.picklistFieldValues.Rating.values.map(
        (currItem) => ({
          label: currItem.label,
          value: currItem.value
        })
      );
      this.industryOptions = data.picklistFieldValues.Industry.values.map(
        (currItem) => ({
          label: currItem.label,
          value: currItem.value
        })
      );
    } else if (error) {
    }
  }

  changeHandler(event) {
    let { name, value } = event.target;
    if (name === "industry") this.industryvalue = value;
    if (name === "rating") this.ratingvalue = value;
  }

  clickHandler(event) {
    console.log(this.industryvalue);
    console.log(this.ratingvalue);

    let message = {
      lmsData: {
        industry: this.industryvalue,
        rating: this.ratingvalue
      }
    };
    publish(this.context, filter, message);
  }
}
