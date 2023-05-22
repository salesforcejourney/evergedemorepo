import { LightningElement, api, wire } from "lwc";
import {
  getFieldDisplayValue,
  getFieldValue,
  getRecord
} from "lightning/uiRecordApi";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import ANNUAL_REVENUE from "@salesforce/schema/Account.AnnualRevenue";
import INDUSTRY from "@salesforce/schema/Account.Industry";
export default class GetRecordDemo extends LightningElement {
  @api recordId;
  accountName;
  annualRevenue;
  industry;

  fieldValueAccountName;
  fieldDisplayValueAnnualRevenue;
  fieldDisplayValueindustry;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [NAME_FIELD, ANNUAL_REVENUE, INDUSTRY]
  })
  getRecordHandler({ data, error }) {
    if (data) {
      //console.log("getRecordHandler data", data);
      //console.log("getRecordHandler data", JSON.stringify(data));
      this.accountName = data.fields.Name.value;
      this.annualRevenue = data.fields.AnnualRevenue.displayValue;
      this.industry = data.fields.Industry.displayValue;
      this.fieldValueAccountName = getFieldValue(data, NAME_FIELD);
      this.fieldDisplayValueAnnualRevenue = getFieldDisplayValue(
        data,
        ANNUAL_REVENUE
      );
      this.fieldDisplayValueindustry = getFieldDisplayValue(data, INDUSTRY);
    } else if (error) {
      console.log("getRecordHandler error", error);
    }
  }
}
