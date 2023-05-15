import { LightningElement, api } from "lwc";

export default class ChildSetter extends LightningElement {
  childUserDetail;
  @api
  get detail() {
    return this.childUserDetail;
  }

  set detail(data) {
    let localData = { ...data };
    localData.username = localData.username.toUpperCase();
    localData.age = localData.age * 2;
    this.childUserDetail = { ...localData };
  }
}
