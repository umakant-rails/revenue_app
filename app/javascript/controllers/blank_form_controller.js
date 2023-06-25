import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['inputField', 'textField', 'textHolder'];

  connect() {
    this.params = {}
  }

  addRemoveElement(element, actionType){
    if(actionType == 'add'){
      $(element).html(this.textFieldTargets[0]);
    } else if(actionType == 'restore'){
      $("#hidden_input").html(this.textFieldTargets[0]);
      this.textHolderTarget.value = '';
    }
  }

  inputCreation(element){
    var inputFieldVal = '';
    var inputField = '';

    if(element.dataset.blnkFrmTarget != 'textHolder'){
      return ;
    }
    
    if(element.dataset.isRead == undefined){
      element.dataset.blankText = element.textContent;
      element.dataset.isRead = true;
    } else if(element.dataset.isRead && (element.dataset.blankText == element.textContent)) {
      this.textFieldTarget.value = '';
    } else {
      this.textFieldTarget.value = element.textContent.trim();
    }
    // inputField = `        
    //   <input id="input1" name="inputText" type="text" value="${inputFieldVal}" style="display: inline-block;" 
    //   data-blnk-frm-target="inputField" 
    //   data-action="blur1->blnk-frm#showAsItis keydown.tab->blnk-frm#nextInput keydown.enter->blnk-frm#typingText" />   
    // `;
     
    this.addRemoveElement(element, 'add');

    setTimeout(()=>{
      element.children[0].focus();
    },100);
  }

  createInput(event){
    if(this.hasInputFieldTarget 
      && this.inputFieldTarget.parentNode != event.target 
      && event.target.dataset.blnkFrmTarget == 'textHolder'
    ){
      var vl = this.inputFieldTarget.value
      this.inputFieldTarget.innerHTML = (vl == '') ? this.inputFieldTarget.parentNode.dataset.blankText: vl;
    }

    if(event.target.dataset.blnkFrmTarget == 'textHolder'){
      this.inputCreation(event.target);
    } else{return;}
  }

  typingText(event){
    var vl = event.target.value;
    var parentNodeElement = event.target.parentNode;

    if(event.keyCode == 13){
      this.textFieldTarget.value = '';
      this.addRemoveElement(null, 'restore')
      parentNodeElement.innerHTML = (vl!='') ? vl : parentNodeElement.dataset.blankText;
    }
  }

  // showAsItis(event){
  //   if(event.target.value == ''){
  //     this.prevElement.innerHTML = this.prevElement.dataset.blankText;
  //   } else {
  //     this.prevElement.innerHTML = this.prevElement.value;
  //   }
  // }

  nextInput(event){
    var elements = this.textHolderTargets;
    var indx = elements.indexOf(event.target.parentNode);

    if(this.hasTextFieldTarget){
      var vl = this.textFieldTarget.value;
      var parentNodeElement = this.textFieldTarget.parentNode;
      this.textFieldTarget.value = '';
      this.addRemoveElement(null, 'restore')
      parentNodeElement.innerHTML = (vl == '') ? parentNodeElement.dataset.blankText : vl;
    }

    if(elements.length > indx+1){
      this.inputCreation(elements[indx+1])
    }
  }
}
