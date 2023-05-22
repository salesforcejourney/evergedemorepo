import { LightningElement } from "lwc";
import { getLinkedinDetails } from "@salesforce/apex/LinkedinHelper.getLinkedinDetails";
export default class LinkedinPost extends LightningElement {
  authorizeHandler() {
    getLinkedinDetails()
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        console.log(error);
      });
  }

  postHandler() {}
}
