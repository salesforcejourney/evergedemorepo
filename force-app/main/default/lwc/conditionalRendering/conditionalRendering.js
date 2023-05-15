import { LightningElement } from "lwc";

export default class ConditionalRendering extends LightningElement {
  showUserDetails = false;

  changeHandler(event) {
    this.showUserDetails = event.target.checked;
  }
}
