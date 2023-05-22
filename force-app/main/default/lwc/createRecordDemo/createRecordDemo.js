import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { LightningElement, wire } from "lwc";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import LEAD_SOURCE_FIELD from "@salesforce/schema/Contact.LeadSource";
import { createRecord } from "lightning/uiRecordApi";
import LeadSource from "@salesforce/schema/CampaignMember.LeadSource";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
export default class CreateRecordDemo extends NavigationMixin(
  LightningElement
) {
  leadSourceOptions = [];
  contactRecordType = "";
  contactFirstName = "";
  contactLastName = "";
  contactEmail = "";
  contactLeadSource = "";

  @wire(getObjectInfo, {
    objectApiName: CONTACT_OBJECT
  })
  contactObjInfoHandler({ data, error }) {
    if (data) {
      console.log("contactObjInfoHandler data", data);
      this.contactRecordType = data.defaultRecordTypeId;
    } else if (error) {
      console.log(error);
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$contactRecordType",
    fieldApiName: LEAD_SOURCE_FIELD
  })
  leadSourcePicklistHandler({ data, error }) {
    if (data) {
      console.log("leadSourcePicklistHandler data", data);
      this.leadSourceOptions = data.values.map((currItem) => ({
        label: currItem.label,
        value: currItem.value
      }));
    } else if (error) {
      console.log("leadSourcePicklistHandler error", error);
    }
  }

  changeHandler(event) {
    let { name, value } = event.target;
    if (name === "fname") this.contactFirstName = value;
    if (name === "lname") this.contactLastName = value;
    if (name === "email") this.contactEmail = value;
    if (name === "leadsource") this.contactLeadSource = value;
  }

  clickHandler(event) {
    //validate data --> Assignment
    let isValid = this.validateInput();
    if (isValid) {
      let confields = {};
      //   confields["lastname"] = this.contactLastName;
      //   confields["firstname"] = this.contactFirstName;
      //   confields["email"] = this.contactEmail;
      //   confields["leadsource"] = this.contactLeadSource;
      confields[LASTNAME_FIELD.fieldApiName] = this.contactLastName;
      confields[FIRSTNAME_FIELD.fieldApiName] = this.contactFirstName;
      confields[EMAIL_FIELD.fieldApiName] = this.contactEmail;
      confields[LeadSource.fieldApiName] = this.contactLeadSource;

      console.log("LASTNAME_FIELD", LASTNAME_FIELD);
      console.log("LEAD_SOURCE_FIELD", LEAD_SOURCE_FIELD);
      console.log("CONTACT_OBJECT", CONTACT_OBJECT);
      let recordInput = {
        apiName: CONTACT_OBJECT.objectApiName,
        fields: confields
      };
      createRecord(recordInput)
        .then((data) => {
          console.log("create record data", data);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Record Created Successfully",
              variant: "success"
            })
          );
          let pageref = {
            type: "standard__recordPage",
            attributes: {
              recordId: data.id,
              objectApiName: CONTACT_OBJECT.objectApiName,
              actionName: "view"
            }
          };
          this[NavigationMixin.Navigate](pageref);
        })
        .error((error) => {
          console.log("Error ", error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error",
              message: "error.message",
              variant: "error"
            })
          );
        });
    }
  }

  validateInput() {
    let inputElements = [...this.template.querySelectorAll(".inputval")]; //nodelist --> [...nodelist] ==> []
    let isValid = inputElements.reduce((validSoFar, inputField) => {
      inputField.reportValidity();
      return validSoFar && inputField.checkValidity();
    }, true);
    return isValid;
  }
}
