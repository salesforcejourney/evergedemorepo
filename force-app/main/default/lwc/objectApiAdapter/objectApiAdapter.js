import { LightningElement, wire } from "lwc";
import {
  getObjectInfo,
  getObjectInfos,
  getPicklistValues,
  getPicklistValuesByRecordType
} from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import CONATCT_OBJECT from "@salesforce/schema/Contact";
import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import TYPE from "@salesforce/schema/Account.Rating";

export default class ObjectApiAdapter extends LightningElement {
  accountobjectinfo;
  accountobjecterror;
  objectinfosdata;
  objectinfoserror;
  industryOptions = [];
  selectedIndustry = "";
  ratingOptions = [];
  typeOptions = [];

  @wire(getObjectInfo, {
    objectApiName: ACCOUNT_OBJECT
  })
  objectInfoHandler({ data, error }) {
    if (data) {
      //   console.log("objectinfo data", data);
      //   console.log("objectinfo data", JSON.stringify(data));
      this.accountobjectinfo = data;
      this.accountobjecterror = null;
    } else if (error) {
      //   console.log("objectinfo error", error);
      this.accountobjectinfo = null;
      this.accountobjecterror = error;
    }
  }

  @wire(getObjectInfos, {
    objectApiNames: [CONATCT_OBJECT, OPPORTUNITY_OBJECT]
  })
  objectInfosHandler({ data, error }) {
    if (data) {
      //console.log("objectInfosHandler data", data);
      this.objectinfosdata = data;
      this.objectinfoserror = null;
    } else if (error) {
      //console.log("objectInfosHandler error", error);
      this.objectinfosdata = null;
      this.objectinfoserror = error;
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$accountobjectinfo.defaultRecordTypeId",
    fieldApiName: INDUSTRY_FIELD
  })
  picklistvalueHandler({ data, error }) {
    if (data) {
      //console.log("picklistvalueHandler data", data);
      this.industryOptions = data.values.map((currItem) => ({
        label: currItem.label,
        value: currItem.value
      }));
    } else if (error) {
      console.log("picklistvalueHandler error", error);
    }
  }

  @wire(getPicklistValuesByRecordType, {
    objectApiName: ACCOUNT_OBJECT,
    recordTypeId: "$accountobjectinfo.defaultRecordTypeId"
  })
  picklistRecordTypeHandler({ data, error }) {
    if (data) {
      console.log("picklistRecordTypeHandler data", data);
      this.ratingOptions = data.picklistFieldValues.Rating.values.map(
        (currItem) => ({
          label: currItem.label,
          value: currItem.value
        })
      );
      this.typeOptions = data.picklistFieldValues.Type.values.map(
        (currItem) => ({
          label: currItem.label,
          value: currItem.value
        })
      );
    } else if (error) {
      console.log("picklistRecordTypeHandler error", error);
    }
  }

  changeHandler(event) {
    this.selectedIndustry = event.target.value;
  }
}
