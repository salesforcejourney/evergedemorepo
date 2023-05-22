import {
  subscribe,
  unsubscribe,
  MessageContext,
  APPLICATION_SCOPE
} from "lightning/messageService";
import accdetail from "@salesforce/messageChannel/accdetail__c";
import { LightningElement, wire } from "lwc";

export default class DetailComponent extends LightningElement {
  subscriber;
  accrecId;
  @wire(MessageContext) context;
  connectedCallback() {
    this.subscribeAccountDetailChannel();
  }

  subscribeAccountDetailChannel() {
    this.subscriber = subscribe(
      this.context,
      accdetail,
      (message) => this.handleMessage(message),
      { Scope: APPLICATION_SCOPE }
    );
  }

  handleMessage(message) {
    this.accrecId = message.lmsData.recordId;
  }

  disconnectedCallback() {
    unsubscribe(this.subscriber);
    subscriber = null;
  }
}
