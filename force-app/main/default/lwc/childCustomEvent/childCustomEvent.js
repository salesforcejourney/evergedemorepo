import { LightningElement, api } from "lwc";

export default class ChildCustomEvent extends LightningElement {
  @api accountrec;

  clickHandler() {
    //send details to parent

    //create the custom event
    let myCustomEvent = new CustomEvent("select", {
      detail: this.accountrec.Id
    });
    //dispatch the event
    this.dispatchEvent(myCustomEvent);
  }
}
