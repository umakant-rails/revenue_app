import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {

  getRecords(event){
    this.params = {};
    let targetName = event.target.name;
    let selected_value = event.target.value;
    let url = "/blank_forms/get_records"

    if(selected_value == ''){
      return ;
    }

    this.params.selected_field = targetName;
    this.params.selected_value = selected_value;

    if(targetName == 'district'){
      this.getData('get', url, this.params);
    } else if (targetName == 'tehsil'){
      this.getData('get', url, this.params);
    } else if (targetName == 'circle'){
      this.getData('get', url, this.params);
    }
    
  }

  /* start js block - make ajax requext */
  getData(requestType, url, params){
    $(".spinner").css('display', 'block');
    $.ajax({
      type: requestType,
      url: url,
      data: params,
      dataType: 'script',
      success: function(data){
      }
    });
  }
  /* end js block - make ajax requext */
}