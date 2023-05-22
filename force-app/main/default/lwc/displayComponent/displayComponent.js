import { LightningElement, wire } from "lwc";
import getIndustryRecords from "@salesforce/apex/AccontHelper.getIndustryRecords";
import filter from "@salesforce/messageChannel/filter__c";
import {
  APPLICATION_SCOPE,
  subscribe,
  unsubscribe,
  MessageContext
} from "lightning/messageService";

export default class DisplayComponent extends LightningElement {
  subscriber;
  searchIndustry = "";
  searchRating = "";
  @wire(MessageContext) context;
  @wire(getIndustryRecords, {
    Industry: "$searchIndustry",
    Rating: "$searchRating"
  })
  accounts;
  selectedRecord;
  selectHandler(event) {
    let accountId = event.detail;
    this.selectedRecord = this.accounts.data.find(
      (currItem) => currItem.Id == accountId
    );
  }

  connectedCallback() {
    this.subscribeTFilteroMessageChannel();
  }

  subscribeTFilteroMessageChannel() {
    this.subscriber = subscribe(
      this.context,
      filter,
      (message) => this.handleFilter(message),
      { Scope: APPLICATION_SCOPE }
    );
  }

  handleFilter(message) {
    console.log("message", message);
    this.searchIndustry = message.lmsData.industry;
    this.searchRating = message.lmsData.rating;
  }

  disconnectedCallback() {
    unsubscribe(this.subscriber);
    this.subscriber = null;
  }
}
