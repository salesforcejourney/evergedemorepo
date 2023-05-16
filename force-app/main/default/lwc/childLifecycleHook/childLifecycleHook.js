import { LightningElement } from "lwc";

export default class ChildLifecycleHook extends LightningElement {
  constructor() {
    super();
    console.log("Child constructor invoked");
  }

  connectedCallback() {
    console.log("Connected Callback on child is called");
    //throw new Error("Loading of child component is failed");
  }

  renderedCallback() {
    console.log("Render Callback on child is called");
  }

  disconnectedCallback() {
    console.log("Disconected callback on child is called");
  }
}
