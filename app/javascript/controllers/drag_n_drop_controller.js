import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = [];
  

  connect(){
  }

  dragover(event) {
    event.preventDefault()
    return true;
  }

  drop(ev){
    ev.preventDefault();
    ev.stopPropagation();
    if(ev.dataTransfer){
      if(ev.dataTransfer.files.length) {
        var droppedFiles = ev.dataTransfer.files;
        for(var i = 0; i < droppedFiles.length; i++) {
          
        }
      }
    }
    return false;
  }

  selectFile(event){
    var id = event.target.dataset.target;
    document.querySelector(id).click();
  }
}

 // <div class=" col-md-12 drag-n-drop-block" data-action="dragover->dragndrop#dragover drop->dragndrop#drop click->dragndrop#selectFile" data-target="#select_image">
 //        <i class="fa-solid fa-circle-plus fnt-22"></i>
 //      </div>