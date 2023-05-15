import { LightningElement } from "lwc";

export default class SelectorComponent extends LightningElement {
  cars = ["Honda", "TATA", "BMW", "AUDI"];
  clickHandler(event) {
    const element = this.template.querySelector("h1");
    console.log("element", element.innerText);

    const jselement = this.template.querySelector(".js");
    console.log("jselement", jselement);
    jselement.style.border = "1px solid red";

    const carElements = this.template.querySelectorAll(".carcomp");
    console.log("carElements", carElements); //NODE_LIST

    Array.from(carElements).forEach((currItem) => {
      currItem.setAttribute("title", currItem.innerText);
      console.log(currItem);
      currItem.style.border = "1px solid blue";
    });
  }
}
