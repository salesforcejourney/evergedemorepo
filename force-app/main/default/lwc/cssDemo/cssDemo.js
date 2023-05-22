import { LightningElement } from "lwc";
import ANIMATE from "@salesforce/resourceUrl/Animate";
import { loadStyle } from "lightning/platformResourceLoader";
export default class CssDemo extends LightningElement {
  cssProperty = "auraDesignTokenDemo";
  percent = 100;

  renderedCallback() {
    loadStyle(this, ANIMATE)
      .then(() => {
        console.log("Styles Loaded Successfully");
      })
      .catch((error) => {
        console.log("Error in loading Styles", error);
      });
  }
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

  applyThirdPartyCss(event) {
    this.template
      .querySelector(".animate__animated")
      .classList.remove("animate__bounceIn");

    this.template
      .querySelector(".animate__animated")
      .classList.add("animate__bounceIn");
  }
  changeHandler(event) {
    this.percent = event.target.value;
  }
  get percentage() {
    return `font-size: ${this.percent}%`;
  }
}
