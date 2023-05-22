import { LightningElement, api } from "lwc";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
export default class RecordViewFormDemo extends LightningElement {
  @api objectApiName;
  @api recordId;
  accountField = {
    Name: NAME_FIELD,
    Industry: INDUSTRY_FIELD,
    type: TYPE_FIELD,
    rating: RATING_FIELD
  };
}
