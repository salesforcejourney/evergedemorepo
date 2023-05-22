import { LightningElement, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class RecordDetailsDemo extends NavigationMixin(
  LightningElement
) {
  @api recordId;
  @api objectApiName;

  openRecordinEditMode() {
    let pageRef = {
      type: "standard__recordPage",
      attributes: {
        recordId: this.recordId,
        objectApiName: this.objectApiName,
        actionName: "edit"
      }
    };

    this[NavigationMixin.Navigate](pageRef);
  }
  openRecordinViewMode() {
    let pageRef = {
      type: "standard__recordPage",
      attributes: {
        recordId: this.recordId,
        objectApiName: this.objectApiName,
        actionName: "view"
      }
    };

    this[NavigationMixin.Navigate](pageRef);
  }
}
