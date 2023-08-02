import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['inputField', 'textField', 'textHolder'];

  connect() {
    this.params = {};
    this.liveInputElement = undefined;
  }

  addRemoveElement(parentElement, elementToAdd, actionType){
    if(actionType == 'add'){
      $(parentElement).html(elementToAdd);
    } else if(actionType == 'restore'){
      elementToAdd.value = '';
      if(elementToAdd.dataset.translatable == "true"){
        $("#translatable").html(elementToAdd);
      } else {
        $("#not-translatable").html(elementToAdd);
      }
      this.liveInputElement = undefined;
    }
  }

  inputCreation(parentElement, inputElement){
    var inputFieldVal = '';
    var inputField = '';

    if(parentElement.dataset.blnkFrmTarget != 'textHolder'){
      return ;
    }

    if(parentElement.dataset.isRead == undefined){
      parentElement.dataset.blankText = parentElement.textContent;
      parentElement.dataset.isRead = true;
    } else if(parentElement.dataset.isRead && (parentElement.dataset.blankText == parentElement.textContent)) {
      inputElement.value = '';
    } else {
      inputElement.value = parentElement.textContent.trim();
    }
    this.addRemoveElement(parentElement, inputElement, 'add');

    if(parentElement.children.length > 0){
      setTimeout(()=>{
        parentElement.children[0].focus();
      },100);
    } else{
      console.log('error');
    }
  }

  createInput(event){
    var parentElement = (this.liveInputElement == undefined ) ? undefined : this.liveInputElement.parentNode;
    if(parentElement && event.target.dataset.blnkFrmTarget == parentElement.dataset.blnkFrmTarget 
      && this.liveInputElement && this.liveInputElement.parentNode != event.target
    ){
      var vl = this.liveInputElement.value.trim();
      this.addRemoveElement(null, this.liveInputElement, 'restore');
      parentElement.innerHTML = (vl == '') ? parentElement.dataset.blankText : vl;
    }

    if(event.target.dataset.blnkFrmTarget == 'textHolder'){
      var translatableStatus = event.target.dataset.translatable;
      this.liveInputElement = this.textFieldTargets.find(target => target.dataset.translatable == translatableStatus);
      this.inputCreation(event.target, this.liveInputElement);   
    } else{return;}
  }

  typingText(event){
    var parentElement = event.target.parentNode;

    if(event.keyCode == 13){
      var vl = event.target.value;
      this.liveInputElement.value = '';
      this.addRemoveElement(null, event.target, 'restore');
      parentElement.innerHTML = (vl.length != 0) ? vl : parentElement.dataset.blankText;
    }
  }

  nextInput(event){
    var elements = this.textHolderTargets;
    var indx = elements.indexOf(event.target.parentNode);

    if(this.hasTextFieldTarget){
      var vl = this.liveInputElement.value.trim();
      var parentElement = this.liveInputElement.parentNode;
      this.liveInputElement.value = '';
      this.addRemoveElement(null, this.liveInputElement, 'restore')
      parentElement.innerHTML = (vl == '') ? parentElement.dataset.blankText : vl;
    }

    if(elements.length > indx+1){
      var translatableStatus = elements[indx+1].dataset.translatable;
      this.liveInputElement = this.textFieldTargets.find(target => target.dataset.translatable == translatableStatus);
      this.inputCreation(elements[indx+1], this.liveInputElement)
    }
  }

  downloadPDF(event){
    var element = document.getElementsByClassName("page-a4")[0];

    var options = {
        margin: 0,
        filename: 'PMKisan.pdf',
        image: { type: 'jpeg', quality: 0.98 },
        html2canvas: { scale: 2 },
        jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' },
        pagebreak: { mode: 'avoid-all', before: '.page-a4' }
    };
    html2pdf().from(element).set(options).save();

  }

}
