import { LightningElement } from "lwc";

export default class WelcomeToLearnLwc extends LightningElement {
  greeting = "Property Message - Welcome to learn LWC ";

  changeHandler(event) {
    this.greeting = event.target.value;
  }
}
