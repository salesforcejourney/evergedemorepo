import { LightningElement, api, wire } from "lwc";
import accdetail from "@salesforce/messageChannel/accdetail__c";
import { publish, MessageContext } from "lightning/messageService";
export default class TileComponent extends LightningElement {
  @wire(MessageContext) context;
  @api accountrec;

  clickHandler(event) {
    //create the custom event
    let myCustomEvent = new CustomEvent("select", {
      detail: this.accountrec.Id
    });

    //dispatch the event
    this.dispatchEvent(myCustomEvent);
    let message = {
      lmsData: {
        recordId: this.accountrec.Id
      }
    };
    publish(this.context, accdetail, message);
  }
}
