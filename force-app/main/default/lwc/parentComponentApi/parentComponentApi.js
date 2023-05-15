import { LightningElement } from "lwc";

export default class ParentComponentApi extends LightningElement {
  userObj = {
    username: "ankitjain@training.com",
    email: "ankitjain@testemail.com",
    phone: "79879879879879"
  };

  oldclickHandler(event) {
    this.template
      .querySelector("c-child-component-api")
      .refreshDateTime("Refresh Date and Time");
  }

  newclickHandler(event) {
    this.refs.childcomp.refreshDateTime("Refresh Date and Time");
  }
}
