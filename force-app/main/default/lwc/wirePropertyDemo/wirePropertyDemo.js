import { LightningElement, wire } from "lwc";
import getTopAccounts from "@salesforce/apex/AccontHelper.getTopAccounts";
export default class WirePropertyDemo extends LightningElement {
  @wire(getTopAccounts) accounts;
}
