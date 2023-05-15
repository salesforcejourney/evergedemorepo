import { LightningElement, api, track } from "lwc";

export default class LwcCalculator extends LightningElement {
  @api
  number1 = 0;
  number2 = 0;
  @track result = 0;
  showOutput = false;

  changeHandler(event) {
    let eventname = event.target.name;
    console.log("eventname", eventname);
    if (eventname === "number1") {
      this.number1 = event.target.value;
    }
    if (eventname === "number2") {
      this.number2 = event.target.value;
    }

    // let { name, value } = event.target;
    // if (name === "number1") this.number1 = value;
    // if (name === "number2") this.number2 = value;
  }

  handleClick(event) {
    this.showOutput = true;
    let eventLabel = event.target.label;
    if (eventLabel === "Add") {
      this.result = parseInt(this.number1) + parseInt(this.number2);
    }
    if (eventLabel === "Sub") {
      this.result = parseInt(this.number1) - parseInt(this.number2);
    }
    if (eventLabel === "Mul") {
      this.result = parseInt(this.number1) * parseInt(this.number2);
    }
    if (eventLabel === "Div") {
      this.result = parseInt(this.number1) / parseInt(this.number2);
    }
  }

  @api
  doCalcualtion() {}
}
