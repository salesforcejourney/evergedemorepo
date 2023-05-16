import { LightningElement } from "lwc";

export default class ParentLifeCycleHook extends LightningElement {
  addComponent = false;
  myArray = [1, 2, 3];
  constructor() {
    super();
    console.log("Parent constructor invoked");
  }

  connectedCallback() {
    console.log("Connected Callback on parent is called");
  }

  renderedCallback() {
    console.log("Render Callback on parent is called");
  }

  errorCallback(error, stack) {
    console.log(error.message);
    console.log(stack);
  }

  addHandler() {
    this.addComponent = true;
  }

  removekHandler() {
    this.addComponent = false;
  }
}
