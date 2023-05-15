import { LightningElement } from "lwc";

export default class IteratorDemo extends LightningElement {
  cars = ["Audi", "BMW", "Honda", "TATA"];
  contacts = [
    {
      id: 1,
      ceo: "Mark Benioff",
      company: "Salesforce"
    },
    {
      id: 2,
      ceo: "Elon Musk",
      company: "SpaceX"
    },
    {
      id: 3,
      ceo: "Tim Cook",
      company: "Apple"
    }
  ];
}
