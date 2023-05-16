import { LightningElement } from "lwc";

export default class CssDemo extends LightningElement {
  cssProperty = "auraDesignTokenDemo";
  percent = 100;
  addClassHandler(event) {
    this.template.querySelector("h2").className = "auraDesignTokenDemo";
  }
  removeClassHandler(event) {
    this.template.querySelector("h2").className = "";
  }

  addListClassHandler(event) {
    this.template.querySelector("h3").classList.add("auraDesignTokenDemo");
  }
  removeListClassHandler(event) {
    this.template.querySelector("h3").classList.remove("auraDesignTokenDemo");
  }

  changeHandler(event) {
    this.percent = event.target.value;
  }
  get percentage() {
    return `font-size: ${this.percent}%`;
  }
}
