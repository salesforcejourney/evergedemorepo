import { LightningElement } from "lwc";
import singInTemplate from "./signin.html";
import singUpTemplate from "./signup.html";
import renderDemoTemplate from "./renderDemo.html";
export default class RenderDemo extends LightningElement {
  selectedBtn = "";
  render() {
    if (this.selectedBtn === "Signup") {
      return singUpTemplate;
    } else if (this.selectedBtn === "Signin") {
      return singInTemplate;
    } else {
      return renderDemoTemplate;
    }
  }

  clickHandler(event) {
    this.selectedBtn = event.target.label;
  }

  submitHandler(event) {
    console.log(`${event.target.label} successfully`);
  }
}
