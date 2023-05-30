import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['templateName', 'orderTemplate', 'sanjaraTemplate'];

  connect() {
    this.params = {}
  }

  orderSanjaraTemplate(){
    var arr = [];
    var orderName = this.orderTemplateTarget.dataset.name;
    var orderTemplate = this.orderTemplateTarget.value;
    var sanjaraName = this.sanjaraTemplateTarget.dataset.name;
    var sanjaraTemplate = this.sanjaraTemplateTarget.value;
    if(orderTemplate != 'p1'){ arr[arr.length] = orderName+"="+orderTemplate; }
    if(sanjaraTemplate != 'p1'){ arr[arr.length] = sanjaraName+"="+sanjaraTemplate; }
    return arr;
  }

  updateUrl(event){
    var paramArr = []
    for(var i=0;i<this.templateNameTargets.length; i++){
      var name = this.templateNameTargets[i].dataset.name;
      var vl = this.templateNameTargets[i].value;
      if(vl != 'pdf-paragraph-40'){ paramArr[paramArr.length] = name+"="+vl; }
    }
    if(vl != 'pdf-paragraph-40'){ paramArr[paramArr.length] = name+"="+vl; }
    
    var aavedan = event.target.dataset.aavedan;
    if(aavedan == 'fauti') {
      var arr = this.orderSanjaraTemplate()
      paramArr = paramArr.concat(arr)
    }

    var url = $(".file-download").attr('href');
    if(url.indexOf('?')>5){url= url.substring(0, url.indexOf('?'))}
    url += ('?'+ paramArr.join('&'))
    $(".file-download").attr('href', url);
  }

  resetUrl(){
    for(var i=0;i<this.templateNameTargets.length; i++){
      this.templateNameTargets[i].value = 'pdf-paragraph-40';
    }
    var url = $(".file-download").attr('href');
    url = url.substring(0, url.indexOf("?"));
    $(".file-download").attr('href', url);
  }

  /* end js block - make ajax requext */
}
