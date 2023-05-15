import { LightningElement } from "lwc";

export default class ValidateInput extends LightningElement {
  clickHandler(event) {
    let isValid = this.validateInput();
    isValid = this.validateCompanyEmail();
    if (isValid === true) alert("Valid Input");
    if (isValid === false) alert("InValid Input");
  }

  //validate input and return true or false. true -- if validation successful , false -- validation failure
  validateInput() {
    let inputElements = [...this.template.querySelectorAll("lightning-input")]; //nodelist --> [...nodelist] ==> []
    let isValid = inputElements.reduce((validSoFar, inputField) => {
      inputField.reportValidity();
      return validSoFar && inputField.checkValidity();
    }, true);
    return isValid;
  }
  //Email address must contain @everge.com -- Error message as 'Email must be company email address'
  validateCompanyEmail() {
    let compEmailElement = this.template.querySelector(".compemail");
    let isValid = true;
    if (!compEmailElement.value.endsWith("@everge.com")) {
      compEmailElement.setCustomValidity("Email must be company email address");
      isValid = false;
    } else {
      compEmailElement.setCustomValidity("");
      isValid = true;
    }
    compEmailElement.reportValidity();
    return isValid;
  }
}
