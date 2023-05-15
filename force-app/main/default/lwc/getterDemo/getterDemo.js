import { LightningElement } from "lwc";

export default class GetterDemo extends LightningElement {
  firstname = "";
  lastname = "";

  changeHandler(event) {
    let { name, value } = event.target;
    if (name === "fname") this.firstname = value;
    if (name === "lname") this.lastname = value;
  }

  get fullName() {
    // let fullName = this.firstname + " " + this.lastname;
    // return fullName.toUpperCase();
    return `${this.firstname} ${this.lastname}`.toUpperCase();
  }
}
