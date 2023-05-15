import { LightningElement, api } from "lwc";

export default class ChildComponentApi extends LightningElement {
  @api message;
  @api userdetail = {};
  @api inputFromParent; //camel case
  @api showMe = false;
  dateTimeDetails;

  @api
  refreshDateTime(messageFromParent) {
    alert(messageFromParent);
    this.dateTimeDetails = new Date();
  }
}
