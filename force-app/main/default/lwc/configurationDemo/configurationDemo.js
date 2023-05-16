import { LightningElement, api } from "lwc";

export default class ConfigurationDemo extends LightningElement {
  @api message; //global property
  @api pageNo;
}
