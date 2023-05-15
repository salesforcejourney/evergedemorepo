import { LightningElement, track } from "lwc";

export default class TrackDecorator extends LightningElement {
  @track userDetail = {
    username: "ankitjain",
    useremail: "ankitjain@test.com"
  };

  @track toDoTask = [
    "Wake up in morning",
    "Get Ready for Office",
    "Pickup the cab"
  ];

  clickHandler(event) {
    this.userDetail.useremail = "changedemail@training.com";
  }

  addTaskHandler(event) {
    this.toDoTask.push("Attend the training");
  }
}

/**
 * Scenario 1 --

  @track userDetail = {
    username: "ankitjain",
    useremail: "ankitjain@test.com"
  };

  clickHandler(event) {
    this.userDetail.useremail = "changedemail@training.com";
  }

Scenario 2 - 

  userDetail = {
    username: "ankitjain",
    useremail: "ankitjain@test.com"
  };

  clickHandler(event) {
    this.userDetail = {
    username: "ankitjain",
    useremail: "changedemail@test.com"
  };

  }


Scenario 3 --

  userDetail = {
    username: "ankitjain",
    useremail: "ankitjain@test.com"
  };
  newMessage;

  clickHandler(event) {
    this.userDetail.useremail = "changedemail@training.com";
    this.newMessage = 'Welcome'
  }

  Scenario 4

@track toDoTask = [
    "Wake up in morning",
    "Get Ready for Office",
    "Pickup the cab"
  ];

addTaskHandler(event) {
    this.toDoTask.push("Attend the training");
  }

... operator

Scenario 5

toDoTask = [
    "Wake up in morning",
    "Get Ready for Office",
    "Pickup the cab"
  ];

addTaskHandler(event) {
    this.toDoTask = [...this.task,'Attend the training']
  }
  
 */
